# EndStream

2-player tactical trading card board game about time-traveling outlaws seeking redemption. Mobile-first (portrait mode), built with Flutter + Supabase.

## Project Structure

```
/EndStream
  /endstream                  ← Flutter app (client)
    /lib
      /app                    ← main.dart, routes, theme, DI setup
      /core
        /models               ← Player, Game, Card, Deck, Turnpoint, etc.
        /engine               ← Client-side game state machine (mirrors server)
        /services             ← SupabaseService, AuthService, PushService
        /cubits               ← Cubit classes organized by feature
      /ui
        /components           ← Tree* component library (TreeButton, TreeCard, etc.)
        /background           ← TimeTreePainter, RippleEngine
        /screens
          /auth               ← LoginScreen, RegisterScreen, SplashScreen
          /hub                ← MainHubScreen
          /games              ← ActiveGamesScreen, NewGameSetup
          /board              ← GameBoardScreen, StreamPanel, HandPanel
          /deck               ← DeckBuilderScreen, DeckEditorScreen
          /social             ← FriendsScreen, FriendProfileScreen
          /settings           ← SettingsScreen
        /overlays             ← CardDetailOverlay, TargetingOverlay, CombatOverlay
        /animations           ← AnimationCatalog, EasingCurves
    /assets
      /images
      /audio
      /shaders                ← Fragment shaders for background effects
    /test
  /supabase                   ← Supabase backend (Edge Functions + migrations)
    /functions
      /submit-action          ← Game action validation and processing
      /create-game            ← Game initialization
      /matchmaking            ← Random opponent pairing
      /concede-game           ← Game concession
      /validate-deck          ← Deck rule validation
      /send-push              ← FCM push notification trigger
    /migrations               ← SQL migration files
    /seed.sql                 ← Card catalog seed data
```

## Tech Stack

- **Client:** Flutter (Dart), SDK >=3.22, Impeller rendering
- **State Management:** Cubit (flutter_bloc). Use Cubit for simple features, full BLoC (with events) only for complex flows like game board ACTION_PHASE
- **Navigation:** go_router with deep linking
- **Backend:** Supabase only — no custom server
  - **Auth:** Supabase Auth (email, Google, Apple Sign-In)
  - **Database:** Supabase PostgreSQL with Row Level Security (RLS)
  - **Realtime:** Supabase Realtime for turn notifications and presence
  - **Server Logic:** Supabase Edge Functions (Deno/TypeScript) for game engine
  - **Storage:** Supabase Storage for card art, audio, assets
  - **Scheduled Jobs:** pg_cron for turn reminders and stale game cleanup
- **Push Notifications:** Firebase Cloud Messaging (only Firebase service used)
- **Rendering:** CustomPainter + Canvas API for Time Tree background, Rive for animations, fragment shaders for effects
- **Local Storage:** drift (SQLite) for offline cache, flutter_secure_storage for tokens, shared_preferences for settings
- **Networking:** supabase_flutter handles REST, Realtime, Auth, Storage — no Dio or separate WebSocket library

## Game Rules Summary

- 2 players, each with 6 Operators and 1 AI Controller
- Board: 2x6 grid — 2 parallel timelines (streams), 6 centuries each (2100–2600)
- Win conditions: eliminate all enemy operators OR destroy enemy Controller
- Turn-based: play cards, move operators, use abilities, attack, end turn
- Action Points (AP) limit actions per turn
- Card types: OPERATOR, TACTIC, EVENT, EQUIPMENT

## Game State Machine

```
GAME_INIT → TURN_START → ACTION_PHASE → TURN_END → (check win) → TURN_START or GAME_OVER
```

ACTION_PHASE substates: `IDLE → SELECTED → TARGETING → RESOLVING → IDLE`

Server is authoritative — all actions validated in Edge Functions. Client does optimistic rendering with rollback on rejection.

## Design System — "Time Tree" UI Language

Every UI element exists on a massive procedural time tree rendered as a persistent background layer. Nothing floats freely.

### Visual Rules

- **Angular geometry only** — squares, sharp points, straight segmented paths
- **Circles only** for anomaly/singularity states
- **Thin lines, small dots, barely visible patterns** — no fat buttons or cartoon UI
- **No rounded corners** except anomaly indicators
- **No glass, blur, gradients that scream, neon glow, or bounce animations**
- Tree looks 3D, UI panels are 2D mounted on it — clear depth contrast

### Color Palette

```dart
background:    Color(0xFF0A0C10)  // near-black, cool tint
branchDefault: Color(0xFF1A1E28)  // dim branch lines
branchActive:  Color(0xFF2E4A6E)  // muted electric blue
highlight:     Color(0xFF4A7AB5)  // informational blue
activation:    Color(0xFFB8A44C)  // muted pale yellow
dormant:       Color(0xFF3A3A42)  // dim white/grey
nodePoint:     Color(0xFF506882)  // branch node markers
```

- Blue = informational flow
- Yellow = activation / intervention
- Dim white = dormant timeline

### Motion Rules

- **Allowed:** linear easing, subtle cubic easing, small oscillations, wave distortion along lines
- **Forbidden:** spring physics, bounce, overshoot, elastic, playful easing
- Easing curves:
  - standard: `cubic-bezier(0.25, 0.1, 0.25, 1.0)`
  - subtle: `cubic-bezier(0.33, 0.0, 0.67, 1.0)`
  - sharp: `cubic-bezier(0.4, 0.0, 1.0, 1.0)`
- Every interaction triggers an upward ripple on the tree background (intensity 0.1–1.0)
- Idle: continuous micro-oscillation of branches (0.5–1px amplitude)

### Emotional Principles

- **Fragile:** lines thin and vulnerable, nodes barely stable, stability never assumed
- **Political:** power propagates upward, local actions create systemic reactions
- **Tense:** motion restrained not playful, feedback sharp and controlled, silence has weight

## UI Component Library

Primitives: `TreeButton`, `TreeInput`, `TreeToggle`, `TreeCard`, `TreeNode`, `TreeBranch`, `TreeModal`, `TreeBadge`, `TreeDivider`

Composites: `GameListItem`, `TurnpointCell`, `OperatorToken`, `CardThumbnail`, `CardFull`, `FriendEntry`, `DeckSlot`, `ActionPointBar`, `ResourceCounter`

## Screens

All portrait mode. Game board uses horizontal scroll between 3 panels:

```
[Opponent Stream] ← scroll → [Your Stream (default)] ← scroll → [Hand + Menu]
```

Primary screens: Splash, Login, Main Hub, Active Games, New Game Setup, Game Board, Hand/Menu, Deck Builder, Deck Editor, Card Detail (overlay), Friends List, Friend Profile, Settings

## Data Models

Key tables (PostgreSQL/Supabase):
- `players` — id (FK→auth.users), display_name, rank, xp, avatar_id
- `cards` — id, name, type (OPERATOR/TACTIC/EVENT/EQUIPMENT), cost, rarity, text, hp, attack
- `abilities` — id, card_id, name, description, cost
- `decks` — id, owner_id, name, is_valid
- `deck_cards` — deck_id, card_id, quantity
- `games` — id, player_1_id, player_2_id, status, winner_id, current_turn, active_player_id
- `game_streams` — game_id, player_id, stream_data (JSONB)
- `game_hands` — game_id, player_id, hand_data (JSONB)
- `game_actions` — id, game_id, turn, player_id, type, source, target, result
- `friendships` — player_id, friend_id, status
- `challenges` — id, from_player_id, to_player_id, deck_id, status
- `matchmaking_queue` — player_id, deck_id, rank, queued_at
- `device_tokens` — player_id, token, platform

## Supabase Configuration

- Project ref: `wlxeodyguyzabtjoroey`
- MCP server configured in `.mcp.json`
- Edge Functions use Deno runtime (TypeScript, URL imports, no node_modules)
- All tables must have RLS policies enabled
- Game actions go through Edge Functions, never direct table inserts from client

## Key Commands

```bash
# Flutter
cd endstream && flutter run                    # Run app
cd endstream && flutter test                   # Run tests
cd endstream && dart run build_runner build     # Code generation (freezed, json_serializable, drift)

# Supabase
supabase start                                 # Start local Supabase stack
supabase functions serve                       # Run Edge Functions locally
supabase db push                               # Push migrations to remote
supabase functions deploy <name>               # Deploy a single Edge Function
supabase migration new <name>                  # Create a new migration file
```

## Implementation Phases

1. **Playable Prototype** — Auth, game board (pass-and-play), basic cards, state machine, win conditions
2. **Online Multiplayer** — Supabase backend, online games, push notifications, active games list
3. **Deck Building** — Full card catalog, deck builder/editor, deck validation
4. **Social** — Friends, challenges, profiles
5. **Polish & Launch** — Time Tree animations, full animation catalog, onboarding, audio, store submission

## Architecture — Clean Architecture + SOLID

This project MUST follow Clean Architecture and SOLID principles. No exceptions.

### Layer Separation

```
UI (Widgets) → Cubits/BLoCs → Services (Repositories) → Data Sources (Supabase, Drift)
```

- **UI layer** depends on Cubits only — never imports services or data sources directly
- **Cubit/BLoC layer** depends on service interfaces (abstractions) — never on concrete implementations
- **Service layer** depends on data source abstractions — orchestrates business logic
- **Data source layer** contains Supabase calls, Drift queries, secure storage — the only layer that knows about external APIs

### SOLID Principles

- **Single Responsibility:** Each class does one thing. A Cubit manages one feature's state. A service handles one domain. A widget renders one piece of UI.
- **Open/Closed:** Extend behavior through new classes, not by modifying existing ones. Use abstract classes and interfaces for extensibility.
- **Liskov Substitution:** All service implementations must be substitutable for their abstract interface without breaking callers.
- **Interface Segregation:** Define focused abstract classes. Prefer multiple small interfaces over one large one (e.g., `AuthReader` and `AuthWriter` over a monolithic `AuthService` if it grows too large).
- **Dependency Inversion:** High-level modules (Cubits, UI) depend on abstractions (abstract service classes), not on concrete implementations. Inject dependencies — never instantiate services inside Cubits or widgets.

### Widget Rules — NO Helper Functions

- **NEVER use helper functions that return widgets.** Every piece of UI MUST be a separate `StatelessWidget` or `StatefulWidget` class.
- **Extract, don't inline.** If a `build()` method exceeds ~40 lines or has distinct visual sections, extract each section into its own widget class.
- **Use `const` constructors everywhere possible.** Every widget that can be `const` MUST be `const`. Every constructor that can be `const` MUST be `const`. Mark widget instances as `const` at call sites.
- **Composition over inheritance.** Build complex UI by composing small widget classes, not by inheriting from other widgets.
- **Name widgets descriptively.** `GameListItemStatusBadge`, not `_buildBadge()`. The class name documents intent.

```dart
// WRONG — helper function returning a widget
Widget _buildHeader() {
  return Row(children: [...]);
}

// CORRECT — separate widget class
class GameListItemHeader extends StatelessWidget {
  const GameListItemHeader({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) => Row(children: [...]);
}
```

### Dependency Injection

- Use constructor injection for all dependencies
- Wire DI in `main.dart` or a dedicated DI setup file (`/lib/app/di.dart`)
- Cubits receive abstract service interfaces, never concrete classes
- Services receive abstract data source interfaces

### Repository / Service Pattern

```dart
// Abstract interface
abstract class GameService {
  Future<List<Game>> getActiveGames();
  Future<GameState> getGame(String gameId);
  Future<GameState> submitAction(String gameId, GameAction action);
}

// Concrete implementation
class SupabaseGameService implements GameService {
  const SupabaseGameService(this._client);
  final SupabaseClient _client;
  // ...
}
```

### State Management Rules

- Cubit states MUST be immutable (use `freezed` or `equatable`)
- Never mutate state — always emit a new state object
- One Cubit per feature, states defined with `equatable`
- Use Cubit for simple features, full BLoC (with events) only for complex flows like game board ACTION_PHASE
- Cubits MUST NOT depend on other Cubits — communicate through services or events

### Code Organization Rules

- One public class per file (private helper classes in the same file are fine)
- File names match class names in snake_case (`game_board_screen.dart` → `GameBoardScreen`)
- Group imports: dart → flutter → packages → project (relative)
- No circular dependencies between layers

## Coding Conventions

- Models use `freezed` + `json_serializable` for immutability and JSON serialization
- All Supabase calls go through service classes (never call Supabase directly from UI)
- Edge Functions are server-authoritative — client never decides game outcomes
- Use `supabase_flutter` for all networking — no Dio, no manual WebSocket
- Test Cubits with `bloc_test`, mock services with `mocktail`

## Testing Requirements

Every feature MUST ship with tests. Untested code is incomplete code.

### What to Test

- **Cubits/BLoCs:** Test every state transition. Use `bloc_test` with `build`, `act`, `expect` pattern. Cover initial state, success paths, error paths, and edge cases.
- **Services:** Test public methods against mocked data sources using `mocktail`. Verify correct calls are made, correct data is returned, and errors are propagated.
- **Models:** Test `fromJson`/`toJson` round-trips for all freezed models. Test equality, copyWith, and edge cases (null optional fields, enum serialization).
- **Widgets:** Test rendering, user interactions, and state-driven UI changes. Verify correct widgets appear for each Cubit state. Test navigation triggers.
- **Edge Functions:** Test validation logic, error responses, and happy paths. Use Deno test runner.

### Test Structure

```
/test
  /core
    /models        — Model serialization and equality tests
    /cubits        — Cubit state transition tests
    /services      — Service method tests with mocked dependencies
  /ui
    /components    — Component rendering and interaction tests
    /screens       — Screen integration tests (widget + cubit)
  /helpers         — Shared test utilities, fakes, fixtures
```

### Rules

- **Every Cubit** must have a corresponding test file testing all state transitions
- **Every service** must have a corresponding test file with mocked dependencies
- **Every model** must have a serialization round-trip test
- **Mock dependencies, never real services.** Use `mocktail` to create mocks of abstract interfaces. Never hit Supabase or any external service in unit tests.
- **Test file naming:** `<source_file>_test.dart` (e.g., `auth_cubit.dart` → `auth_cubit_test.dart`)
- **Test descriptions** must describe behavior, not implementation (e.g., "emits Authenticated when login succeeds" not "calls signIn method")
- **No test should depend on another test's state.** Each test must set up its own context.
- **Run `flutter test` before considering any feature complete.** All tests must pass.

## Reference Documents

- `UI Plan.md` — full design language, color system, motion language, emotional principles
- `EndStream_Implementation_Guide.md` — screen specs, workflows, data models, wireframes, animation catalog
- `TechStack.md` — complete dependency list, Supabase architecture, database schema, Edge Functions
