# EndStream — Technical Stack & Technology Requirements

## Overview

EndStream is a 2-player tactical trading card board game about time-traveling outlaws. It requires a mobile client with a persistent animated background layer (the "Time Tree"), real-time and asynchronous multiplayer networking, a rules engine, deck building, social features, and push notifications.

The backend runs entirely on **Supabase** — no custom server framework needed. The game engine (rules validation, combat resolution, state machine) runs in Supabase Edge Functions. Since EndStream is asynchronous turn-based, every action is a request → validate → update → respond cycle, which Edge Functions handle perfectly.

---

## 1. Client — Mobile Application

### Framework

| Technology | Purpose |
|---|---|
| **Flutter (Dart)** | Cross-platform UI framework (iOS + Android from a single codebase) |
| **Flutter SDK >=3.22** | Latest stable with Impeller rendering engine enabled by default |

Flutter is the primary recommendation due to its single-codebase cross-platform support, custom rendering pipeline (Impeller), and strong CustomPainter APIs for the Time Tree background.

### UI Rendering

| Technology | Purpose |
|---|---|
| **CustomPainter (Flutter)** | Procedural rendering of the Time Tree background (branches, nodes, ripples) |
| **Rive (rive: ^0.13)** | Pre-authored vector animations for combat, card effects, and transitions |
| **Canvas API (dart:ui)** | Low-level 2D drawing for the ripple system and branch wave distortions |
| **Flutter Shaders (fragment shaders)** | Subtle background noise, gradient pulses, shimmer effects |

### State Management

| Technology | Purpose |
|---|---|
| **flutter_bloc (^8.1)** | BLoC/Cubit architecture for app-wide reactive state |
| **Cubit** | Lightweight state management for each feature (auth, game list, deck data, board state, settings) |

Cubit is used over full BLoC where event mapping is unnecessary. Each feature gets its own Cubit with clearly defined states. Full BLoC (with events) is reserved for complex flows like the game board action phase where event traceability matters.

### Navigation

| Technology | Purpose |
|---|---|
| **go_router (^14.0)** | Declarative routing with deep linking support for push notification targets |

### Local Storage

| Technology | Purpose |
|---|---|
| **shared_preferences** | Simple key-value storage (settings, UI preferences) |
| **drift (SQLite)** | Local cache for card catalog, deck data, and offline game state |
| **flutter_secure_storage** | Secure storage for Supabase session tokens |

### Networking (Client-Side)

| Technology | Purpose |
|---|---|
| **supabase_flutter (^2.5)** | Supabase client SDK — handles REST, Realtime, Auth, and Storage in one package |
| **connectivity_plus** | Network state detection for offline/online transitions |

No separate HTTP client (Dio) or WebSocket library needed — `supabase_flutter` handles all networking through the Supabase client.

### Push Notifications

| Technology | Purpose |
|---|---|
| **Firebase Cloud Messaging (firebase_messaging)** | Cross-platform push notifications for turn reminders and challenges |
| **flutter_local_notifications** | In-app notification display when the app is in foreground |

Push notifications are triggered from Supabase Edge Functions calling the FCM API.

### Authentication (Client-Side)

| Technology | Purpose |
|---|---|
| **Supabase Auth (via supabase_flutter)** | Email/password, Google OAuth, Apple Sign-In — all built into the Supabase SDK |
| **google_sign_in** | Native Google OAuth flow on device |
| **sign_in_with_apple** | Native Apple Sign-In flow (required for iOS App Store) |

No Firebase Auth needed — Supabase Auth handles everything including JWT session management, token refresh, and OAuth providers.

### Animations & Motion

| Technology | Purpose |
|---|---|
| **Flutter AnimationController** | Core animation primitives with custom cubic easing curves |
| **Rive runtime** | Pre-built animation playback (combat, card dissolve, operator elimination) |
| **Custom CurvedAnimation** | Restrained easing: `cubic-bezier(0.25, 0.1, 0.25, 1.0)` — no spring/bounce |

### Assets & Media

| Technology | Purpose |
|---|---|
| **flutter_svg** | SVG rendering for card art and UI icons |
| **cached_network_image** | Card art caching from Supabase Storage CDN |
| **audioplayers** | Music and SFX playback (ambient audio, interaction sounds) |

### Testing (Client)

| Technology | Purpose |
|---|---|
| **flutter_test** | Unit and widget testing |
| **bloc_test (^9.1)** | Testing Cubits and BLoCs with state assertions |
| **integration_test** | End-to-end UI testing |
| **mocktail** | Mocking dependencies for isolated tests |

---

## 2. Backend — Supabase

Supabase replaces the need for a custom backend framework. It provides a managed PostgreSQL database, auto-generated REST API, real-time subscriptions, authentication, file storage, and Edge Functions for custom logic.

### Supabase Services Used

| Service | Replaces | Purpose |
|---|---|---|
| **Supabase Auth** | Firebase Auth / custom JWT | User registration, login, OAuth (Google, Apple), session management |
| **Supabase Database (PostgreSQL)** | Self-hosted Postgres + ORM | All persistent data with Row Level Security (RLS) policies |
| **Supabase Realtime** | Socket.IO / WebSocket server | Real-time game state updates, turn notifications, friend presence |
| **Supabase Edge Functions (Deno)** | NestJS controllers + game engine | Server-side game logic, rules validation, combat resolution, matchmaking |
| **Supabase Storage** | AWS S3 / Cloudflare R2 | Card art, audio files, static assets with built-in CDN |
| **pg_cron (Postgres extension)** | BullMQ job queue | Scheduled tasks — turn reminder notifications, stale game cleanup |

### Edge Functions — Game Engine

The game engine runs as Supabase Edge Functions written in TypeScript (Deno runtime). Each function is invoked via HTTP and validates actions server-side.

| Function | Purpose |
|---|---|
| `submit-action` | Validates and processes a game action (play card, move, attack, ability, end turn) |
| `create-game` | Initializes game state, deals hands, places operators, generates turnpoints |
| `matchmaking` | Pairs players from the matchmaking queue, creates a game |
| `concede-game` | Handles game concession, updates records |
| `validate-deck` | Validates a deck against game rules before use |
| `send-push` | Triggers FCM push notification for turn reminders and challenges |

**How a turn works:**
```
1. Client calls Edge Function: submit-action({ game_id, action })
2. Edge Function loads game state from Postgres
3. Validates action against rules engine (TypeScript logic)
4. Updates game state in Postgres
5. Checks win conditions
6. Returns updated state to client
7. Supabase Realtime broadcasts the change to the opponent
8. If turn ends → Edge Function triggers push notification via FCM
```

### Realtime Channels

| Channel | Event | Purpose |
|---|---|---|
| `game:{game_id}` | `action_performed` | Opponent receives real-time action updates |
| `game:{game_id}` | `game_over` | Both players receive game result |
| `presence:friends` | `sync` | Friend online/offline status tracking |
| `challenges:{player_id}` | `challenge_received` | Incoming challenge notifications |

### Row Level Security (RLS)

Supabase RLS policies replace traditional API authorization:

```sql
-- Players can only read/update their own profile
-- Players can only read games they're part of
-- Players can only modify their own decks
-- Card catalog is readable by all authenticated users
-- Game actions are insert-only through Edge Functions (not direct table access)
```

### Database Functions (Postgres)

| Function | Purpose |
|---|---|
| `match_random_opponent()` | Finds a player in the matchmaking queue and pairs them |
| `cleanup_stale_games()` | Called by pg_cron to mark abandoned games |
| `send_turn_reminders()` | Called by pg_cron to trigger push notifications for overdue turns |

---

## 3. Database Schema Design

### PostgreSQL Tables (Supabase)

```sql
-- Core tables
players         — id (UUID, FK→auth.users), display_name, rank, xp, avatar_id, created_at
cards           — id, name, type, cost, rarity, text, flavor_text, art_asset_path, hp, attack
abilities       — id, card_id (FK→cards), name, description, cost

-- Deck management
decks           — id, owner_id (FK→players), name, is_valid, created_at, updated_at
deck_cards      — deck_id (FK→decks), card_id (FK→cards), quantity

-- Game state
games           — id, player_1_id, player_2_id, status, winner_id, current_turn,
                  active_player_id, created_at, last_action_at
game_streams    — game_id (FK→games), player_id, stream_data (JSONB — turnpoints array)
game_hands      — game_id (FK→games), player_id, hand_data (JSONB — cards in hand)
game_actions    — id, game_id (FK→games), turn, player_id, type, source (JSONB),
                  target (JSONB), result (JSONB), created_at

-- Social
friendships     — player_id, friend_id, status (pending/accepted), created_at
challenges      — id, from_player_id, to_player_id, deck_id, status, created_at

-- Matchmaking
matchmaking_queue — player_id, deck_id, rank, queued_at

-- Push notifications
device_tokens   — player_id, token, platform (ios/android), created_at
```

### Key Indexes

```sql
CREATE INDEX idx_games_active_player ON games(active_player_id) WHERE status = 'active';
CREATE INDEX idx_games_players ON games(player_1_id, player_2_id);
CREATE INDEX idx_game_actions_game ON game_actions(game_id, turn);
CREATE INDEX idx_friendships_player ON friendships(player_id, status);
CREATE INDEX idx_matchmaking_rank ON matchmaking_queue(rank, queued_at);
```

---

## 4. Real-Time & Networking Protocols

| Layer | Technology | Usage |
|---|---|---|
| Game actions | Supabase Edge Functions (HTTPS) | Submitting moves, playing cards, ending turns |
| Game state reads | Supabase auto-generated REST API | Loading board state, game list, deck data |
| Turn notifications | Supabase Realtime (WebSocket) | Instant notification when opponent acts |
| Presence | Supabase Realtime Presence | Friend online/offline status |
| Background sync | FCM Push Notifications | Turn reminders when app is closed |

### Conflict Resolution Strategy

- Server-authoritative: all game actions validated in Edge Functions
- Client optimistic rendering: animate immediately, rollback on server rejection
- Idempotent actions: each action has a unique ID for safe retries
- Turn-based exclusivity: only the active player can submit actions
- Supabase RLS ensures players can only access their own data

---

## 5. Rendering Pipeline — Time Tree Background

The Time Tree is the signature visual element. It renders as a persistent background layer behind all UI.

### Architecture

```
Layer Stack (bottom to top):
  1. Time Tree Canvas (CustomPainter / Fragment Shader)
  2. Screen Content (Flutter Widgets)
  3. Overlay System (Modals, Tooltips)
```

### Technical Requirements

| Requirement | Implementation |
|---|---|
| Procedural branch generation | Algorithm generating straight-line segments with node points |
| Micro-oscillation (idle) | Continuous sine-wave displacement (0.5–1px amplitude) on branch vertices |
| Ripple propagation | Upward-traveling intensity wave triggered by user interactions |
| Performance target | 60fps on mid-range devices (2021+ phones) |
| Density control | Settings slider adjusts branch count and animation complexity |
| Reduced motion | Accessibility toggle disables oscillation and ripples |

### Color Constants

```dart
static const background     = Color(0xFF0A0C10);  // near-black, cool tint
static const branchDefault  = Color(0xFF1A1E28);  // dim branch lines
static const branchActive   = Color(0xFF2E4A6E);  // muted electric blue
static const highlight      = Color(0xFF4A7AB5);  // informational blue
static const activation     = Color(0xFFB8A44C);  // muted pale yellow
static const dormant        = Color(0xFF3A3A42);  // dim white/grey
static const nodePoint      = Color(0xFF506882);  // branch node markers
```

---

## 6. Audio

| Technology | Purpose |
|---|---|
| **audioplayers (Flutter)** | Playback engine for music and SFX |
| **Supabase Storage** | Hosting audio files with CDN delivery |
| **Custom ambient tracks** | Low, dark ambient music — restrained, tense, not epic |
| **SFX set** | Interaction sounds: branch hum, node click, ripple whoosh, combat clash, card dissolve |

Audio style: minimal, non-intrusive. Think subdued sci-fi hum, not orchestral fanfare.

---

## 7. Security

| Concern | Mitigation |
|---|---|
| Authentication | Supabase Auth with JWT — short-lived access tokens + automatic refresh |
| API protection | Supabase RLS policies on every table — no unauthorized data access |
| Rate limiting | Supabase built-in rate limiting on Edge Functions |
| Game integrity | Edge Functions validate every action — client never decides game outcomes |
| Data privacy | Supabase encrypts data at rest, passwords hashed automatically |
| Transport | HTTPS everywhere, WSS for Realtime connections |
| App Store compliance | Apple Sign-In support, privacy policy, data deletion via Supabase Auth |

---

## 8. Third-Party Services Summary

| Service | Provider | Purpose |
|---|---|---|
| Authentication | Supabase Auth | User sign-up/sign-in, OAuth (Google, Apple) |
| Database | Supabase (PostgreSQL) | All persistent data with RLS |
| Real-time | Supabase Realtime | Turn notifications, presence, live updates |
| Server Logic | Supabase Edge Functions | Game engine, matchmaking, push triggers |
| File Storage | Supabase Storage | Card art, audio files, static assets |
| Push Notifications | Firebase Cloud Messaging | Turn reminders, challenge alerts (triggered from Edge Functions) |
| Error Tracking | Sentry | Crash reports, performance monitoring (client-side) |
| CI/CD | GitHub Actions + Fastlane | Automated builds and deployment |
| Analytics (optional) | PostHog or Mixpanel | Player behavior, retention, funnel analysis |

---

## 9. Infrastructure & DevOps

### Hosting

Everything runs on Supabase's managed infrastructure. No servers to provision, no containers to manage.

| Component | Hosted On |
|---|---|
| Database (PostgreSQL) | Supabase managed instance |
| Edge Functions | Supabase Edge (Deno Deploy) |
| File Storage + CDN | Supabase Storage |
| Realtime | Supabase Realtime server |
| Auth | Supabase Auth server |

### CI/CD

| Technology | Purpose |
|---|---|
| **GitHub Actions** | Automated testing, building, and deployment pipelines |
| **Supabase CLI** | Deploy Edge Functions, run migrations, manage config from CI |
| **Fastlane** | iOS and Android build automation, code signing, and store submission |
| **Codemagic (alternative)** | Flutter-specific CI/CD with native build support |

### Environment & Secrets

| Technology | Purpose |
|---|---|
| **Supabase Dashboard → Secrets** | Edge Function environment variables (FCM keys, etc.) |
| **GitHub Secrets** | CI/CD secrets for builds and deployments |
| **flutter_dotenv (local dev)** | Local environment variables for Supabase URL and anon key |

### Database Migrations

| Technology | Purpose |
|---|---|
| **Supabase CLI (`supabase migration`)** | Version-controlled SQL migrations |
| **Supabase Dashboard** | Visual schema editor for rapid prototyping |

---

## 10. Development Environment

| Tool | Purpose |
|---|---|
| **VS Code or Android Studio** | IDE with Flutter/Dart plugins |
| **Flutter DevTools** | Performance profiling, widget inspector |
| **Supabase CLI** | Local Supabase stack (Postgres, Auth, Realtime, Edge Functions) |
| **Supabase Studio (local)** | Local database management UI (runs with `supabase start`) |
| **Deno** | Local Edge Function development and testing |
| **Git + GitHub** | Version control and collaboration |
| **Figma** | UI/UX design and handoff |

No Docker needed for backend development — `supabase start` runs the entire local stack automatically.

---

## 11. Complete Dependency List

### Flutter Client (`pubspec.yaml`)

```yaml
dependencies:
  flutter:
    sdk: flutter

  # State Management
  flutter_bloc: ^8.1.0
  bloc: ^8.1.0

  # Navigation
  go_router: ^14.0.0

  # Supabase (Auth + Database + Realtime + Storage — all in one)
  supabase_flutter: ^2.5.0

  # Firebase (push notifications only)
  firebase_core: ^3.0.0
  firebase_messaging: ^15.0.0

  # Native OAuth
  google_sign_in: ^6.2.0
  sign_in_with_apple: ^6.1.0

  # Local Storage
  shared_preferences: ^2.2.0
  drift: ^2.16.0
  sqlite3_flutter_libs: ^0.5.0
  flutter_secure_storage: ^9.0.0

  # Network State
  connectivity_plus: ^6.0.0

  # UI & Rendering
  flutter_svg: ^2.0.0
  cached_network_image: ^3.3.0
  rive: ^0.13.0

  # Audio
  audioplayers: ^6.0.0

  # Notifications
  flutter_local_notifications: ^17.0.0

  # Utilities
  freezed_annotation: ^2.4.0
  json_annotation: ^4.9.0
  uuid: ^4.3.0
  intl: ^0.19.0
  equatable: ^2.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  integration_test:
    sdk: flutter
  build_runner: ^2.4.0
  freezed: ^2.5.0
  json_serializable: ^6.7.0
  drift_dev: ^2.16.0
  bloc_test: ^9.1.0
  mocktail: ^1.0.0
```

### Supabase Edge Functions (`deno.json`)

```json
{
  "compilerOptions": {
    "strict": true
  },
  "imports": {
    "supabase": "https://esm.sh/@supabase/supabase-js@2",
    "cors": "https://deno.land/x/cors/mod.ts"
  }
}
```

Edge Functions are written in TypeScript and run on Deno. No `package.json` or `node_modules` — dependencies are URL imports.

### Supabase Project Structure

```
/supabase
  /functions
    /submit-action      — game action validation and processing
    /create-game        — game initialization
    /matchmaking        — random opponent pairing
    /concede-game       — game concession
    /validate-deck      — deck validation
    /send-push          — FCM push notification trigger
  /migrations           — SQL migration files (version-controlled schema)
  /seed.sql             — seed data (card catalog, test players)
  config.toml           — local Supabase config
```

---

## 12. Performance Targets

| Metric | Target |
|---|---|
| App launch to hub | < 3 seconds (cold start) |
| Screen transitions | < 400ms |
| Game board load | < 1 second |
| Edge Function response (game action) | < 300ms |
| Realtime event delivery | < 150ms |
| Background tree rendering | 60fps on mid-range devices |
| App binary size | < 50MB (initial download) |
| Offline capability | View cached games, browse deck, queue actions |

---

## 13. Why Supabase-Only Works for EndStream

| Concern | Why Supabase Handles It |
|---|---|
| **Server-side game logic** | Edge Functions run TypeScript — same language, same game engine code, just on Deno instead of Node |
| **Real-time turn updates** | Supabase Realtime listens to Postgres changes — when an Edge Function updates the `games` table, the opponent gets notified instantly |
| **Matchmaking** | Edge Function + Postgres query — find a queued player with similar rank, pair them, create the game |
| **Presence (friend online status)** | Supabase Realtime Presence — built-in, no custom WebSocket server needed |
| **Scheduled jobs** | `pg_cron` extension — runs SQL on a schedule for turn reminders and stale game cleanup |
| **Auth + OAuth** | Supabase Auth supports email, Google, Apple out of the box with JWT session management |
| **File storage + CDN** | Supabase Storage with automatic CDN for card art and audio assets |
| **Scaling** | Supabase Pro plan handles thousands of concurrent connections — upgrade to Enterprise if needed |

The only external service still needed is **Firebase Cloud Messaging** for push notifications, since Supabase doesn't have a native push notification service. Edge Functions call the FCM API directly.

---

*This document serves as the definitive technology reference for EndStream. All architectural decisions, dependencies, and infrastructure choices are captured here for implementation planning and onboarding.*
