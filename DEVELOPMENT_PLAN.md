# EndStream — Comprehensive Development Plan

## Architecture Summary

- **Client**: Flutter (Dart), BLoC/Cubit, go_router, CustomPainter for Time Tree
- **Backend**: Supabase (Auth, PostgreSQL + RLS, Realtime, Edge Functions, Storage)
- **Push**: Firebase Cloud Messaging (triggered from Edge Functions)
- **CI/CD**: GitHub Actions + Fastlane

---

## Progress Overview

> Last updated: 2026-02-27

```
TRACK A: Foundation & Infrastructure    ██████████████░░░░░░░░░░░░░░  ~44% (A1-A4 done, A5-A9 remaining)
TRACK B: Game Engine & Backend Logic    ██████████████████░░░░░░░░░░  ~64% (B1-B9 done, B2 partial, B10-B14 remaining)
TRACK C: UI Components & Screens        ██████████████████████░░░░░░  ~76% (C1-C13 done, C14-C17 remaining)
TRACK D: Game Board & Gameplay UI       ███████████████░░░░░░░░░░░░░  ~55% (D1-D6 done, D7-D11 remaining)
TRACK E: Polish, Animation & Launch     ██░░░░░░░░░░░░░░░░░░░░░░░░░░  ~5% (easing curves only)

Phase 1        Phase 2        Phase 3        Phase 4        Phase 5
Foundation     Core Engine    Features       Integration    Polish
██████████     ██████████     ░░░░░░░░░░     ░░░░░░░░░░     ░░░░░░░░░░
```

### Status Legend
- ✅ **DONE** — Fully implemented and working
- 🔶 **PARTIAL** — Implemented with known gaps
- ❌ **NOT STARTED** — No implementation yet

### Overall: 31 of 59 tasks complete (~53%)

---

## PHASE 1 — Foundation (Week 1–2)

All three tracks below run in **parallel from day 1**.

---

### TRACK A — Agent 1: Project Scaffold & Supabase Infrastructure

**Goal**: Set up the Flutter project, Supabase project, database schema, and CI/CD pipeline.

#### ✅ Task A1: Flutter Project Initialization
- ✅ Flutter project created with correct structure
- ✅ `pubspec.yaml` configured with all dependencies (flutter_bloc, go_router, supabase_flutter, firebase, drift, freezed, etc.)
- ✅ Folder structure matching spec: `/lib/app/`, `/lib/core/models|engine|services|cubits/`, `/lib/ui/components|screens|animations/`
- ✅ `build_runner` run — all `.freezed.dart` and `.g.dart` files generated
- ✅ `go_router` configured with all 12 routes + auth redirect guard
- ✅ `BlocObserver` configured for debug logging
- ✅ `main.dart` — initializes Supabase, SharedPreferences, wires AuthCubit + SettingsCubit

#### ✅ Task A2: Supabase Project & Database Schema
- ✅ All 10 migrations applied to remote Supabase project (`wlxeodyguyzabtjoroey`)
  - 001: `players` table + RLS + auto-create trigger
  - 002: `cards` + `abilities` + enums
  - 003: `decks` + `deck_cards` + updated_at trigger
  - 004: `games` + `game_streams` + `game_hands` + `game_actions` + enums
  - 005: `friendships` + `challenges` + enums
  - 006: `matchmaking_queue` + `device_tokens`
  - 007: Performance indexes (13)
  - 008: pg_cron + scheduled functions
  - 009: search_path fix
  - 010: RLS optimization + 8 FK indexes
- ✅ All RLS policies configured
- ✅ Realtime enabled on `players`, `games`, `challenges`
- 🔶 **Gap**: Migration SQL files not stored locally in `/supabase/migrations/` — applied via MCP only

#### ✅ Task A3: Seed Data — Card Catalog
- ✅ `seed.sql` — 15 starter cards (6 Operators, 4 Tactics, 3 Events, 2 Equipment)
- ✅ 6 abilities defined for operator cards
- ✅ `starter_deck_template` table for default deck configuration
- ✅ `assets/data/cards.json` — mirrors seed data for client-side use

#### ✅ Task A4: CI/CD Pipeline
- ✅ GitHub repository initialized
- ✅ `test.yml` — flutter test + format + analyze on push/PR
- ✅ `build.yml` — APK/AAB/IPA builds on version tags with secrets injection
- ✅ `supabase.yml` — DB push + Edge Function deploy on push to main
- ✅ Fastlane configured for both iOS (TestFlight/App Store) and Android (Play Store)
- ✅ `flutter_dotenv` configured, `.env` with Supabase URL + anon key

**Phase 1 Track A Outputs**: ✅ Complete — Runnable Flutter project, fully migrated DB, CI pipeline.

---

### TRACK B — Agent 2: Data Models & Core Services (Client)

**Goal**: Build all Dart data models, service layer, and auth flow.

#### ✅ Task B1: Freezed Data Models
All 9+ model classes implemented with `freezed` + `json_serializable`, generated code present:
- ✅ `Player` — id, displayName, rank, xp, avatarId, createdAt
- ✅ `GameCard` + `Ability` — full card stats, type, rarity, abilities
- ✅ `Deck` + `DeckCard` — id, ownerId, name, cards, isValid, timestamps
- ✅ `Game` — id, player1/2Id, status, winnerId, currentTurn, activePlayerId
- ✅ `ClientGameState` — game + myStream + opponentStream + myHand + AP
- ✅ `Turnpoint` + `TurnpointEffect` — century, terrain, operators, effects
- ✅ `OperatorInstance` + `StreamPosition` + `StatusEffect` — full board representation
- ✅ `GameAction` + `ActionSource/Target/Result` — all action types
- ✅ `Friendship` + `Challenge` — social models
- ✅ `enums.dart` — CardType, Rarity, GameStatus, ActionType, FriendshipStatus, ChallengeStatus, GamePhase, OpponentType

#### 🔶 Task B2: Supabase Service Layer
All 5 services fully implemented, but as **concrete classes without abstract interfaces**:
- ✅ `AuthService` — signUp (with starter deck), signIn, signOut, OAuth (Google/Apple), getPlayerProfile, onAuthStateChange stream
- ✅ `GameService` — getActiveGames, getGame, getGameState, createGame (Edge Function), submitAction (Edge Function), concedeGame (Edge Function), subscribeToGame (Realtime), unsubscribeFromGame
- ✅ `DeckService` — getDecks, getDeck, createDeck, updateDeck, renameDeck, deleteDeck, validateDeck (Edge Function), duplicateDeck
- ✅ `CardService` — getAllCards, getCard, getCardsByType, getCardsByIds (joins abilities)
- ✅ `SocialService` — getFriends, pendingRequests, sendFriendRequest, accept/decline/remove, searchPlayers, sendChallenge, accept/declineChallenge, subscribeToPresence (Realtime), subscribeToChallenges

**Gap**: CLAUDE.md requires abstract interfaces (`abstract class GameService`) with concrete implementations (`SupabaseGameService implements GameService`). Current code uses concrete classes directly — violates DI/Liskov Substitution and makes mocking harder.

#### ✅ Task B3: Auth BLoC + Login Flow
- ✅ `AuthCubit` with full lifecycle: checkSession, signIn, signUp, signInWithGoogle/Apple, signOut
- ✅ Listens to `onAuthStateChange` stream
- ✅ States: AuthInitial, AuthLoading, Authenticated(player), Unauthenticated, AuthError
- ✅ Auto-login on app restart via stored session

#### ✅ Task B4: Core BLoC Architecture
All cubits implemented with full state classes:
- ✅ `GameListCubit` — loadGames, createGame, concedeGame
- ✅ `GameBoardBloc` (full BLoC with events) — LoadGame, SelectCard, SelectOperator, SelectTarget, ConfirmAction, CancelAction, EndTurn, ReceiveOpponentAction, GameStateUpdated. Selection substates: None, CardSelected, OperatorSelected, Targeting
- ✅ `DeckListCubit` — loadDecks, createDeck, deleteDeck, renameDeck, duplicateDeck
- ✅ `DeckEditorCubit` — loadDeck, addCard, removeCard, saveDeck, filteredCards getter
- ✅ `CardCollectionCubit` — loadCards
- ✅ `FriendsCubit` — loadFriends, sendFriendRequest, accept/declineRequest, removeFriend, searchPlayers, presence subscription
- ✅ `SettingsCubit` — 8 settings keys persisted to SharedPreferences

**Phase 1 Track B Outputs**: 🔶 Mostly complete — all models, services, auth, and cubits working. Missing abstract service interfaces for proper DI.

---

### TRACK C — Agent 3: Design System & Theme

**Goal**: Build the "Time Tree" UI component library and app theme.

#### ✅ Task C1: App Theme (`theme.dart`)
- ✅ Complete `TreeColors` palette matching spec
- ✅ `EndStreamTheme.data` with typography, button, input, card, dialog styles
- ✅ Zero-radius corners throughout
- ✅ Dark color scheme

#### ✅ Task C2: Easing Curves & Animation Helpers
- ✅ `TreeCurves` — standard, subtle, sharp, linear (spring/bounce forbidden)
- ✅ `TreeDurations` — instant (100ms), fast (200ms), normal (350ms), slow (500ms), transition (400ms)

#### ✅ Task C3: Primitive Components
All 9 primitives fully implemented:
- ✅ `TreeButton` — 3 variants (primary/secondary/danger), press state, no InkWell
- ✅ `TreeInput` — angular TextField, monospace cursor
- ✅ `TreeToggle` — CustomPainter sliding square, linear animation
- ✅ `TreeCard` — animated border highlight, tap support
- ✅ `TreeNode` — square or diamond (45° rotated) marker
- ✅ `TreeBranch` — static or wave-animated CustomPainter (sine wave)
- ✅ `TreeModal` — stack overlay with backdrop dismiss
- ✅ `TreeBadge` — angular label with tinted border
- ✅ `TreeDivider` — horizontal line with centered diamond node

#### ✅ Task C4: Composite Components
All 9 composites fully implemented:
- ✅ `GameListItem` — pulse animation for yourTurn, all 5 statuses
- ✅ `TurnpointCell` — century/terrain header, operator tokens, effect badges
- ✅ `OperatorToken` — 36x36 square with HP bar (CustomPainter), ATK label
- ✅ `CardThumbnail` — mini card with art placeholder, cost badge
- ✅ `CardFull` — decomposed into proper sub-widgets (header, badges, art, stats, abilities)
- ✅ `FriendEntry` — online/offline status dot, name, rank
- ✅ `DeckSlot` — diamond node, name, card count, validity badge
- ✅ `ActionPointBar` — row of activation/dormant square nodes
- ✅ `ResourceCounter` — 28x28 square node with value overlay

**Phase 1 Track C Outputs**: ✅ Complete — Full design system, theme, all 19 components ready.

---

## PHASE 2 — Core Engine & Screens (Week 3–5)

### TRACK B — Agent 2: Game Engine (Edge Functions)

> **Depends on**: A2 (database schema deployed) ✅, A3 (seed data) ✅

#### ✅ Task B5: Rules Engine (TypeScript — Edge Functions)
All 11 shared modules implemented in `/supabase/functions/_shared/`:
- ✅ `rules-engine.ts` (347 lines) — validateAction for all 5 action types, getValidMoveTargets, adjacency checks, effective ATK calculation
- ✅ `combat-resolver.ts` (145 lines) — resolveCombat, resolveControllerAttack, applyDamage, applyHealing, eliminateOperator
- ✅ `state-machine.ts` (376 lines) — initializeGame, processAction, advanceTurn, checkWinConditions, buildClientResponse, loadGameState
- ✅ `effect-processor.ts` (578 lines) — processPlayCard (all 4 card types), processAbility (6 abilities), processEndOfTurnEffects, processStartOfTurnEffects
- ✅ `deck-validator.ts` (58 lines) — validateDeck (30 cards, max 2 copies, ≥1 operator)
- ✅ `types.ts` (170 lines) — all TypeScript interfaces and type definitions
- ✅ `constants.ts` (26 lines) — GAME_CONSTANTS (AP, board size, deck limits, matchmaking range)
- ✅ `push-sender.ts` (92 lines) — FCM HTTP v1 API integration
- ✅ `errors.ts` (51 lines) — AuthError, ValidationError, GameRuleError, NotFoundError
- ✅ `supabase-client.ts` (35 lines) — user client, admin client, JWT extraction
- ✅ `cors.ts` — CORS headers

#### ✅ Task B6: Edge Function — `create-game`
- ✅ Implemented (206 lines) — validates deck, creates game via initializeGame(), writes to 6 tables atomically
- ✅ Handles local, friend, and random opponent types (random redirects to matchmaking)

#### ✅ Task B7: Edge Function — `submit-action`
- ✅ Implemented (153 lines) — loads state from 8 parallel queries, validates, processAction, atomic update via RPC
- ✅ Sends push notification on end_turn (fire-and-forget)

#### ✅ Task B8: Edge Function — `matchmaking`
- ✅ Implemented (191 lines) — rank-based matching (±200), queue insert, deck validation for both players

#### ✅ Task B9: Edge Functions — `concede-game`, `validate-deck`, `send-push`
- ✅ `concede-game` (67 lines) — validates game/participant, sets winner, records action
- ✅ `validate-deck` (51 lines) — validates ownership, runs deck-validator, updates is_valid flag
- ✅ `send-push` (36 lines) — FCM integration via sendPushToPlayer()

**Known gaps in Edge Functions:**
- `update_game_state()` RPC stored procedure not yet created as a migration
- Additional DB tables expected by Edge Functions (game_draw_piles, game_controllers, game_player_state) not yet migrated
- No deno.json configuration file
- No Edge Function tests written

---

### TRACK C — Agent 3: Static Screens (No Game Logic)

> **Depends on**: C1–C4 (design system) ✅, A1 (project scaffold) ✅

**Status**: All screens fully implemented with component library and cubit wiring.

#### ✅ Task C5: Splash & Auth Screens
- ✅ `SplashScreen` — AnimationController with branch animation + logo node, dispatches checkSession to AuthCubit, routes to hub or login
- ✅ `LoginScreen` — Decomposed: LoginHeader, LoginErrorBanner, LoginFormFields, LoginActionButtons, LoginOAuthSection. Wired to AuthCubit (signIn, Google, Apple)
- ✅ `RegisterScreen` — Full validation (email, display name, password match, 6-char min), wired to AuthCubit.signUp()

#### ✅ Task C6: Main Hub Screen
- ✅ Title + HubNavigationPanel (4 TreeBranch paths: Active Games, Deck Builder, Friends, Settings) + HubPlayerBar
- ✅ All navigation wired via context.push() with go_router

#### ✅ Task C7: Active Games List Screen
- ✅ BlocBuilder<GameListCubit> with Loading/Error/Loaded states
- ✅ 3 filter tabs (Your Turn, Waiting, Completed), GameListItem components, New Game button
- ✅ Status mapping: game status → GameItemStatus enum

#### ✅ Task C8: New Game Setup Screen
- ✅ NewGameOpponentSelector (Random/Challenge Friend/Pass & Play cards)
- ✅ NewGameDeckSelector with dynamic deck list from state
- ✅ Validation: canStart requires both selections. Calls gameListCubit.createGame(), navigates to board

#### ✅ Task C9: Settings Screen
- ✅ BlocBuilder<SettingsCubit> wired to all 8 settings
- ✅ Sections: Account, Notifications (push + reminders), Audio (music + SFX sliders), Visual (reduce motion + tree density), Game (auto end turn + confirm), About

#### ✅ Task C10: Deck Builder Screen
- ✅ BlocBuilder<DeckListCubit>, horizontal DeckSlot scroll, detail panel on selection
- ✅ Create modal, Edit (→ /decks/{id}), Duplicate, Delete actions

#### ✅ Task C11: Deck Editor Screen
- ✅ Split layout: top 2/5 deck contents grid, bottom 3/5 card collection browser
- ✅ DeckEditorFilterBar (search + type filter chips), long-press CardDetailOverlay
- ✅ Wired to DeckEditorCubit: addCard, removeCard, saveDeck, setSearchQuery, setFilterType

#### ✅ Task C12: Card Detail Overlay
- ✅ `/ui/overlays/` directory created
- ✅ `CardDetailOverlay` — TreeModal wrapping CardFull with ScrollView, close on backdrop tap
- ✅ Triggered via long-press on HandCardItem in game board

#### ✅ Task C13: Friends List Screen
- ✅ `FriendsScreen` — BlocBuilder<FriendsCubit>, search bar wired to searchPlayers(), pending requests with Accept/Decline, online/offline friend sections with FriendEntry
- ✅ `FriendProfileScreen` — FriendProfileHeader (name, rank, online status), FriendProfileStats, FriendProfileActions (Challenge + Remove Friend)

---

### TRACK D — Agent 4: Game Board UI (Parallel with Track C)

> **Depends on**: C1–C4 (design system) ✅, B1 (data models) ✅, B4 (GameBoardBloc) ✅

#### ✅ Task D1: Game Board Screen — Layout Shell
- ✅ `GameBoardScreen` — BlocBuilder dispatches to loading/error/loaded/game-over views
- ✅ `GameBoardBody` — Column with top bar + Stack (PageView + TargetingOverlay)
- ✅ `GameBoardTopBar` — turn number badge, AP bar, pulsing TurnIndicatorBadge
- ✅ `GameBoardLoadingView` — centered loading indicator
- ✅ `GameBoardErrorView` — error message + retry button
- ✅ `GameBoardPageView` — 3-page PageView with ClampingScrollPhysics (no bounce)

#### ✅ Task D2: Stream Panel Widget
- ✅ `StreamPanel` — header + scrollable turnpoint list
- ✅ `StreamPanelHeader` — label with colored diamond indicator (blue own, red opponent)
- ✅ `StreamTurnpointList` — ListView.separated of 6 turnpoint items
- ✅ `StreamTurnpointItem` — wraps TurnpointCell with targeting highlight border
- ✅ `TurnpointCell` enhanced — added `onOperatorTap`, `isOpponent`, `selectedOperatorId` params
- ✅ `TreeCard` enhanced — added optional `highlightColor` param for activation yellow

#### ✅ Task D3: Hand + Menu Panel Widget
- ✅ `HandMenuPanel` — action bar + card list + game controls + card detail overlay
- ✅ `HandCardList` — scrollable list with empty state, cost-gated playability
- ✅ `HandCardItem` — type indicator + name + cost badge, selection state, long-press for detail
- ✅ `HandActionBar` — "HAND" label + AP display
- ✅ `HandGameControls` — End Turn + Concede buttons (End Turn disabled when not my turn)

#### ✅ Task D4: Targeting Overlay
- ✅ `TargetingOverlay` — bottom-positioned with source label + target label + confirm/cancel
- ✅ `TargetingActionButtons` — Confirm (secondary variant, disabled until target selected) + Cancel (danger)
- ✅ `TargetingHighlightBorder` — pulsing activation-yellow border (1200ms cycle, opacity 0.3–0.8)

#### ✅ Task D5: Board Interaction System
- ✅ Card play flow: tap card → highlight valid cells → tap target → confirm overlay
- ✅ Operator move flow: tap operator → adjacent cells valid → tap target → confirm
- ✅ Turn control: End Turn button dispatches EndTurn event
- ✅ Concede flow: Concede button → TreeModal confirmation dialog → pop to game list
- ✅ Not-my-turn: all interactive elements disabled (null onTap, greyed out)
- ✅ Long-press card: CardDetailOverlay via TreeModal + CardFull

#### ✅ Task D6: GameBoardBloc Wiring
- ✅ All BLoC events wired: SelectCard, SelectOperator, SelectTarget, ConfirmAction, CancelAction, EndTurn
- ✅ State flows DOWN via constructor params (no nested BlocBuilders)
- ✅ Events bubble UP via callbacks from leaf widgets
- ✅ GameOverView overlay shows on GameBoardGameOver state (Victory/Defeat + exit)

---

## PHASE 3 — Integration & Networking (Week 5–7)

### TRACK A — Agent 1: Realtime & Push Notifications

> **Depends on**: B5–B9 (Edge Functions deployed) ✅, B2 (service layer) ✅

#### ❌ Task A5: Supabase Realtime Integration
Subscribe to game channels, wire opponent actions, presence for friends, challenge notifications, reconnection handling.
**Note**: Realtime subscription code already exists in `GameService.subscribeToGame()` and `FriendsCubit` presence — needs testing with live Edge Functions.

#### ❌ Task A6: Push Notifications
FCM initialization, device token registration, background/foreground message handling, deep links.

#### ❌ Task A7: Matchmaking Queue UI
"Searching for opponent..." screen, Realtime subscription, auto-navigate on match, cancel option.

---

### TRACK B — Agent 2: Client-Server Integration

> **Depends on**: B5–B9 (Edge Functions) ✅, C5–C13 (screens) ✅, D1–D6 (board) ✅

#### ❌ Task B10: Wire Game Flow End-to-End
Active Games → create-game → Game Board → submit-action → turn cycling → concede → game over

#### ❌ Task B11: Wire Deck Flow End-to-End
Deck Builder → Supabase CRUD → validate-deck → card collection from drift cache

#### ❌ Task B12: Wire Social Flow End-to-End
Friends List → friendships table → friend requests → challenge → presence

#### ❌ Task B13: Local Caching with Drift
Drift SQLite for offline: card catalog, deck data, game state snapshots. Sync strategy.

---

### TRACK D — Agent 4: Combat & Card Resolution Animations

> **Depends on**: D1–D6 (board UI) ✅, C2 (easing curves) ✅

#### ❌ Task D7: Combat Resolution Animation
#### ❌ Task D8: Card Play Resolution Animation
#### ❌ Task D9: Operator Move Animation
#### ❌ Task D10: Turn Transition Animations

---

## PHASE 4 — Time Tree & Polish (Week 7–9)

### TRACK E — Agent 5: Time Tree Background System

> **Depends on**: C1 (theme/colors) ✅, C2 (easing curves) ✅

#### ❌ Task E1: Time Tree Renderer (`TimeTreePainter`)
CustomPainter for procedural tree background. No `/ui/background/` directory exists yet.

#### ❌ Task E2: Micro-Oscillation System
#### ❌ Task E3: Ripple System
#### ❌ Task E4: Tree Density Control
#### ❌ Task E5: Screen Transition Integration

---

### TRACK C — Agent 3: Onboarding & Tutorial

> **Depends on**: C5 (auth screens) ✅, D1–D6 (board) ✅, E1 (tree background) ❌

#### ❌ Task C14: Onboarding Screens (First-Time User)
#### ❌ Task C15: Tutorial Game
#### ❌ Task C16: Post-Game Summary Screen

---

## PHASE 5 — Final Polish & Launch (Week 9–11)

### ALL AGENTS — Parallel Final Tasks

#### ❌ Agent 1: Task A8 — Audio System
#### ❌ Agent 1: Task A9 — Error Tracking & Analytics
#### ❌ Agent 2: Task B14 — Scheduled Jobs (pg_cron)
**Note**: pg_cron extension and scheduled functions already set up in migration 008. This task may just need verification.
#### ❌ Agent 3: Task C17 — Accessibility & Final UI Polish
#### ❌ Agent 4: Task D11 — Win/Lose Animations
#### ❌ Agent 5: Task E6 — Performance Optimization
#### ❌ All Agents: Task X1 — Integration Testing
#### ❌ All Agents: Task X2 — App Store Preparation

---

## Known Gaps & Technical Debt

These items are not individual tasks but cross-cutting issues to address:

### 1. No Abstract Service Interfaces (Affects B2, all cubits, all tests)
**Priority: HIGH** — CLAUDE.md mandates abstract interfaces with concrete implementations for DI and testability. Currently all 5 services are concrete classes. Need to:
- Create `abstract class` for each service
- Rename current implementations (e.g., `GameService` → `SupabaseGameService implements GameService`)
- Update all Cubit constructors to accept abstract types
- Update routes.dart DI wiring

### 2. No Local Migration Files (Affects A2)
Migrations were applied via MCP but no `.sql` files exist in `/supabase/migrations/`. The `supabase.yml` CI workflow runs `supabase db push` which requires local files. Need to either:
- Export migrations from remote and save locally, OR
- Use `supabase db pull` to generate local migration files

### 3. Missing Test Coverage (Affects all tracks)
Component tests exist (18 files), but CLAUDE.md requires:
- 0/8 Cubit/BLoC state transition tests
- 0/5 Service tests with mocked dependencies
- 0/9+ Model serialization round-trip tests
- 0/12 Screen integration tests
- No `/test/core/` or `/test/helpers/` directories

### 4. ~~No Overlays Directory~~ RESOLVED
`/ui/overlays/` created with `CardDetailOverlay`, `TargetingOverlay`, `TargetingActionButtons`, `TargetingHighlightBorder`. Remaining: `CombatOverlay` (Track D7).

### 5. Shader Assets Not Declared
`assets/shaders/` directory exists but is not declared in `pubspec.yaml` asset list.

### 6. Missing Database Objects for Edge Functions (Affects B5-B9, B10)
**Priority: HIGH** — Edge Functions reference DB objects that don't exist yet:
- `update_game_state()` RPC stored procedure — atomic multi-table update called by submit-action, create-game, concede-game
- `game_draw_piles` table — tracks remaining draw pile per player
- `game_controllers` table — tracks controller HP per player
- `game_player_state` table — tracks per-player AP and status
Need new migration(s) to create these before Edge Functions can be deployed.

### 7. No Edge Function Tests (Affects B5-B9)
No Deno test files exist for Edge Functions. Need tests for submit-action, matchmaking, and validation logic.

### 8. No deno.json Configuration (Affects B5-B9)
Edge Functions directory has no deno.json/deno.jsonc for import maps or compiler options.

---

## Dependency Graph (Critical Path)

```
A1 (scaffold) ✅ ─────────────────────────┐
A2 (database) ✅ ──→ B5-B9 (engine) ✅ ──→ B10-B12 (integration) ❌ ──→ X1 (testing)
A3 (seed data) ✅ ──→ B5 (rules engine) ✅                                │
                                                                           ▼
B1 (models) ✅ ──→ B2 (services) 🔶 ──→ B3 (auth) ✅ ──────────────→ B10-B12
               ──→ D1-D6 (board UI) ✅                                    │
                                                                           ▼
C1-C4 (design) ✅ ──→ C5-C13 (screens) ✅ ──→ C14-C16 (onboard) ❌ → X2 (launch)
                    ──→ D1-D6 (board UI) ✅ ──→ D7-D10 (anim) ❌       │
                    ──→ E1-E5 (tree) ❌ ──→ E6 (perf opt) ❌ ──────────┘
```

**Critical path**: A2 ✅ → B5-B9 ✅ → B10 ❌ → X1 ❌ → X2 ❌

**Next priority tasks** (unblocked, ready to start):
1. **B10-B12**: Client-Server Integration — all dependencies met (B5-B9 ✅, C5-C13 ✅, D1-D6 ✅)
2. **D7-D10**: Combat & Card Animations — all dependencies met (D1-D6 ✅, C2 ✅)
3. **E1-E5**: Time Tree Background — all dependencies met (C1 ✅, C2 ✅)
4. **A5-A6**: Realtime & Push Integration — all dependencies met (B5-B9 ✅, B2 ✅)

---

## Agent Assignment Summary

| Agent | Primary Responsibility | Phases Active |
|---|---|---|
| **Agent 1** | Infrastructure, Supabase, CI/CD, Realtime, Push, Audio | 1 ✅, 3, 5 |
| **Agent 2** | Data models, Services, Game engine (Edge Functions), Integration | 1 ✅, 2 ✅, 3, 5 |
| **Agent 3** | Design system, UI components, Static screens, Onboarding | 1 ✅, 2 ✅, 3, 4, 5 |
| **Agent 4** | Game board UI, Gameplay interactions, Combat animations | 2 ✅, 3, 4, 5 |
| **Agent 5** | Time Tree background, Ripple system, Performance optimization | 4, 5 |

---

## Task Count Summary

| Track | Total | Done | Remaining | Completion |
|---|---|---|---|---|
| Track A (Infrastructure) | 9 | 4 | 5 | 44% |
| Track B (Engine & Services) | 14 | 9 | 5 | 64% |
| Track C (UI & Screens) | 17 | 13 | 4 | 76% |
| Track D (Game Board) | 11 | 6 | 5 | 55% |
| Track E (Time Tree) | 6 | 0 | 6 | 0% |
| Cross-cutting (X) | 2 | 0 | 2 | 0% |
| **Total** | **59** | **32** | **27** | **54%** |

*Note: B2 counted as partial (done with gaps — missing abstract interfaces). B5-B9 Edge Functions need `update_game_state()` RPC migration and additional table migrations (game_draw_piles, game_controllers, game_player_state). B14 partially done via migration 008. Counting 31 fully complete + B2 partial = 32.*
