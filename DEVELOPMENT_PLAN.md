# EndStream — Comprehensive Development Plan

## Architecture Summary

- **Client**: Flutter (Dart), BLoC/Cubit, go_router, CustomPainter for Time Tree
- **Backend**: Supabase (Auth, PostgreSQL + RLS, Realtime, Edge Functions, Storage)
- **Push**: Firebase Cloud Messaging (triggered from Edge Functions)
- **CI/CD**: GitHub Actions + Fastlane

---

## Workstream Overview

The plan is divided into **5 parallel workstreams** (tracks) that can be developed simultaneously by independent agents. Dependencies between tracks are explicitly marked.

```
TRACK A: Foundation & Infrastructure    ████████░░░░░░░░░░░░░░░░░░░░
TRACK B: Game Engine & Backend Logic    ░░░░████████████░░░░░░░░░░░░
TRACK C: UI Components & Screens        ░░░░░░████████████████░░░░░░
TRACK D: Game Board & Gameplay UI       ░░░░░░░░░░████████████████░░
TRACK E: Polish, Animation & Launch     ░░░░░░░░░░░░░░░░████████████

Phase 1        Phase 2        Phase 3        Phase 4        Phase 5
Foundation     Core Engine    Features       Integration    Polish
```

---

## PHASE 1 — Foundation (Week 1–2)

All three tracks below run in **parallel from day 1**.

---

### TRACK A — Agent 1: Project Scaffold & Supabase Infrastructure

**Goal**: Set up the Flutter project, Supabase project, database schema, and CI/CD pipeline.

#### Task A1: Flutter Project Initialization
- Create Flutter project with `flutter create endstream`
- Configure `pubspec.yaml` with all dependencies from TechStack.md Section 11
- Set up folder structure:
  ```
  /lib
    /app          — main.dart, routes.dart, theme.dart
    /core
      /models     — freezed data classes
      /engine     — game state machine stubs
      /services   — API service interfaces
      /blocs      — Cubit classes
    /ui
      /components — Tree design system widgets
      /background — Time Tree painter stubs
      /screens    — screen folders (auth, hub, games, board, deck, social, settings)
      /overlays   — overlay widgets
      /animations — easing curves, animation helpers
  /assets
    /images
    /audio
    /data         — cards.json seed
  ```
- Run `build_runner` to generate freezed/json_serializable boilerplate
- Configure `go_router` with all routes from Screen Map (Section 2 of Implementation Guide)
- Set up `flutter_bloc` with `BlocObserver` for debug logging

#### Task A2: Supabase Project & Database Schema
- Create Supabase project (or configure local with `supabase init` + `supabase start`)
- Write SQL migrations for all tables from TechStack.md Section 3:
  - **Migration 001**: `players` table (id UUID FK→auth.users, display_name, rank, xp, avatar_id, created_at)
  - **Migration 002**: `cards` table + `abilities` table
  - **Migration 003**: `decks` + `deck_cards` tables
  - **Migration 004**: `games` + `game_streams` + `game_hands` + `game_actions` tables
  - **Migration 005**: `friendships` + `challenges` tables
  - **Migration 006**: `matchmaking_queue` + `device_tokens` tables
  - **Migration 007**: Indexes from TechStack.md Section 3
  - **Migration 008**: Enable `pg_cron` extension, create scheduled functions
- Write RLS policies:
  - Players: read/update own profile only
  - Games: read only games where player is participant
  - Decks: full CRUD only on own decks
  - Cards: read-only for all authenticated users
  - Game actions: insert via Edge Functions only (service role)
  - Friendships: read/write where player_id matches auth.uid()

#### Task A3: Seed Data — Card Catalog
- Design 15 starter cards (per Implementation Guide Phase 1):
  - 6 Operators (one per century slot — varied HP/ATK/abilities)
  - 4 Tactics (direct effects — damage, heal, buff)
  - 3 Events (turnpoint modifiers — terrain changes, area effects)
  - 2 Equipment (attach to operator — stat boosts)
- Write `seed.sql` with card data
- Create a starter deck configuration (valid 30-card deck using starter cards)

#### Task A4: CI/CD Pipeline
- Set up GitHub repository
- GitHub Actions workflow:
  - `test.yml` — run `flutter test` on push/PR
  - `build.yml` — build APK/IPA on release tags
  - `supabase.yml` — deploy Edge Functions and run migrations on push to `main`
- Configure Fastlane for iOS and Android build automation (skeleton)
- Set up `.env.example` with Supabase URL and anon key placeholders
- Configure `flutter_dotenv` for environment variable loading

**Outputs**: Runnable Flutter project with navigation shell, fully migrated Supabase DB with seed data, CI pipeline.

---

### TRACK B — Agent 2: Data Models & Core Services (Client)

**Goal**: Build all Dart data models, service layer, and auth flow.

#### Task B1: Freezed Data Models
Create all models in `/lib/core/models/` using `freezed` + `json_serializable`:

```dart
// player.dart
Player { id, displayName, email, avatarId, rank, xp, createdAt }

// card.dart
Card { id, name, type(CardType enum), cost, rarity(Rarity enum), text, flavorText, artAssetPath, hp?, attack?, abilities? }
Ability { id, cardId, name, description, cost }
CardType { operator, tactic, event, equipment }
Rarity { common, rare, epic, legendary }

// deck.dart
Deck { id, ownerId, name, cards(List<DeckCard>), isValid, createdAt, updatedAt }
DeckCard { cardId, quantity }

// game.dart
Game { id, player1Id, player2Id, status(GameStatus), winnerId?, currentTurn, activePlayerId, createdAt, lastActionAt }
GameStatus { active, completed, abandoned }

// game_state.dart (local representation)
GameState { game, myStream(List<Turnpoint>), opponentStream(List<Turnpoint>), myHand(List<Card>), actionPoints, phase(GamePhase) }
GamePhase { gameInit, turnStart, actionPhase, turnEnd, gameOver }

// turnpoint.dart
Turnpoint { century, terrainType, operators(List<OperatorInstance>), activeEffects(List<Effect>), controllerPresent }

// operator_instance.dart
OperatorInstance { operatorCardId, ownerId, currentHp, maxHp, attack, position(StreamPosition), statusEffects, hasActedThisTurn }
StreamPosition { stream(0|1), centuryIndex(0-5) }

// action.dart
GameAction { id, turn, playerId, type(ActionType), source, target?, result?, timestamp }
ActionType { playCard, move, attack, ability, endTurn }

// friendship.dart
Friendship { playerId, friendId, status(FriendshipStatus), createdAt }
FriendshipStatus { pending, accepted }

// challenge.dart
Challenge { id, fromPlayerId, toPlayerId, deckId, status, createdAt }
```

#### Task B2: Supabase Service Layer
Create services in `/lib/core/services/`:

```
auth_service.dart
  - signUp(email, password)
  - signIn(email, password)
  - signInWithGoogle()
  - signInWithApple()
  - signOut()
  - getCurrentUser()
  - onAuthStateChange (stream)

game_service.dart
  - getActiveGames() → List<Game>
  - getGame(gameId) → GameState
  - createGame(opponentType, deckId, friendId?) → Game
  - submitAction(gameId, action) → GameState
  - concedeGame(gameId)
  - subscribeToGame(gameId) → Stream<GameState>

deck_service.dart
  - getDecks() → List<Deck>
  - createDeck(name) → Deck
  - updateDeck(deckId, cards) → Deck
  - deleteDeck(deckId)
  - validateDeck(deckId) → bool

card_service.dart
  - getAllCards() → List<Card>
  - getCard(cardId) → Card
  - getPlayerCollection(playerId) → List<Card>

social_service.dart
  - getFriends() → List<Player>
  - sendFriendRequest(playerId)
  - acceptFriendRequest(playerId)
  - removeFriend(friendId)
  - getPlayerProfile(playerId) → Player
  - sendChallenge(playerId, deckId)
  - acceptChallenge(challengeId)
  - declineChallenge(challengeId)
  - subscribeToPresence() → Stream<Map<String, bool>>

notification_service.dart
  - initializeFCM()
  - registerDeviceToken(token)
  - handleBackgroundMessage(message)
  - handleForegroundMessage(message)
```

#### Task B3: Auth BLoC + Login Flow
- Create `AuthCubit` with states: `AuthInitial`, `AuthLoading`, `Authenticated(Player)`, `Unauthenticated`, `AuthError(String)`
- Wire up Supabase Auth listeners
- Implement login/register/OAuth flows
- Store session token in `flutter_secure_storage`
- Auto-login on app restart via stored session

#### Task B4: Core BLoC Architecture
Create Cubits for each feature domain (stubs with state classes, filled in later):
- `GameListCubit` — active games list state
- `GameBoardCubit` — in-game board state (complex — full BLoC with events)
- `DeckListCubit` — deck builder state
- `DeckEditorCubit` — deck editing state
- `CardCollectionCubit` — card catalog state
- `FriendsCubit` — friends list state
- `SettingsCubit` — app settings state

**Outputs**: All data models generated, service layer connecting to Supabase, working auth flow, BLoC architecture scaffolded.

---

### TRACK C — Agent 3: Design System & Theme

**Goal**: Build the "Time Tree" UI component library and app theme.

#### Task C1: App Theme (`theme.dart`)
Define the complete Flutter theme:
```dart
// Colors from TechStack.md Section 5
background:    Color(0xFF0A0C10)  // near-black, cool tint
branchDefault: Color(0xFF1A1E28)  // dim branch lines
branchActive:  Color(0xFF2E4A6E)  // muted electric blue
highlight:     Color(0xFF4A7AB5)  // informational blue
activation:    Color(0xFFB8A44C)  // muted pale yellow
dormant:       Color(0xFF3A3A42)  // dim white/grey
nodePoint:     Color(0xFF506882)  // branch node markers

// Typography: clean, monospace-influenced, angular
// No rounded corners anywhere (except anomaly/singularity indicators)
// ThemeData with dark color scheme
```

#### Task C2: Easing Curves & Animation Helpers
Define in `/lib/ui/animations/`:
```dart
standard: Cubic(0.25, 0.1, 0.25, 1.0)   // restrained ease-out
subtle:   Cubic(0.33, 0.0, 0.67, 1.0)    // barely perceptible
sharp:    Cubic(0.4, 0.0, 1.0, 1.0)      // quick start, slow end
linear:   Curves.linear                    // for wave propagation

// FORBIDDEN: Curves.bounceOut, Curves.elasticOut, SpringSimulation
```

#### Task C3: Primitive Components (`/lib/ui/components/`)
Build each component per Implementation Guide Section 7.1:

| Component | File | Description |
|---|---|---|
| `TreeButton` | `tree_button.dart` | Angular button, thin border, subtle pulse on hover, yellow on press. Takes `onPressed`, `label`, `variant(primary/secondary/danger)` |
| `TreeInput` | `tree_input.dart` | Text input as branch segment. Thin vertical cursor pulse. Takes `controller`, `hint`, `onSubmit` |
| `TreeToggle` | `tree_toggle.dart` | Node slides along branch segment. Takes `value`, `onChanged` |
| `TreeCard` | `tree_card.dart` | Container with angular corners, thin border, dark fill. Takes `child`, `padding`, `highlighted` |
| `TreeNode` | `tree_node.dart` | Small square/diamond marker. Takes `size`, `color`, `shape(square/diamond)` |
| `TreeBranch` | `tree_branch.dart` | H/V line connector with subtle wave animation. Takes `direction`, `length`, `animated` |
| `TreeModal` | `tree_modal.dart` | Overlay panel anchored to branch point. Angular shape. Takes `child`, `onClose` |
| `TreeBadge` | `tree_badge.dart` | Small angular label on branch. Takes `text`, `color` |
| `TreeDivider` | `tree_divider.dart` | Thin line with center node. Takes `color` |

#### Task C4: Composite Components (`/lib/ui/components/`)
Build per Implementation Guide Section 7.2:

| Component | File |
|---|---|
| `GameListItem` | `game_list_item.dart` — TreeBranch + TreeNode(status) + text + TreeBadge(turn) |
| `TurnpointCell` | `turnpoint_cell.dart` — TreeCard with terrain icon + operator tokens + effects |
| `OperatorToken` | `operator_token.dart` — Small angular avatar + HP bar (thin line) |
| `CardThumbnail` | `card_thumbnail.dart` — Mini TreeCard with art, cost badge, name |
| `CardFull` | `card_full.dart` — Full-size card with all info (for Card Detail overlay) |
| `FriendEntry` | `friend_entry.dart` — TreeNode(avatar) + name + status dot + stats |
| `DeckSlot` | `deck_slot.dart` — TreeCard with deck name + count + validity |
| `ActionPointBar` | `action_point_bar.dart` — Row of nodes (filled=available, empty=spent) |
| `ResourceCounter` | `resource_counter.dart` — TreeNode with number label |

**Outputs**: Full design system, theme configuration, all reusable components ready for screen assembly.

---

## PHASE 2 — Core Engine & Screens (Week 3–5)

### TRACK B — Agent 2: Game Engine (Edge Functions)

> **Depends on**: A2 (database schema deployed)

#### Task B5: Rules Engine (TypeScript — Edge Functions)
Create shared game logic in `/supabase/functions/_shared/`:

```
rules-engine.ts
  - validateAction(gameState, action) → { valid: bool, error?: string }
  - canPlayCard(gameState, playerId, cardId, targetPosition) → bool
  - canMoveOperator(gameState, playerId, operatorId, targetPosition) → bool
  - canAttack(gameState, playerId, attackerId, targetId) → bool
  - canUseAbility(gameState, playerId, operatorId, abilityId, target?) → bool
  - getValidTargets(gameState, action) → Position[]

combat-resolver.ts
  - resolveCombat(attacker: OperatorInstance, defender: OperatorInstance) → CombatResult
  - applyDamage(operator, amount) → OperatorInstance
  - checkElimination(operator) → bool

state-machine.ts
  - initializeGame(player1, player2, deck1, deck2) → GameState
  - processAction(gameState, action) → { newState: GameState, events: GameEvent[] }
  - advanceTurn(gameState) → GameState
  - checkWinConditions(gameState) → { gameOver: bool, winner?: string, reason?: string }
  - dealCards(gameState, playerId, count) → GameState
  - generateTurnpoints() → Turnpoint[6]

effect-processor.ts
  - applyCardEffect(gameState, card, target) → GameState
  - processEndOfTurnEffects(gameState) → GameState
  - resolveStatusEffects(operator) → OperatorInstance

deck-validator.ts
  - validateDeck(cards: DeckCard[]) → { valid: bool, errors: string[] }
  - Rules: exactly 30 cards, max 2 copies per card, max 6 operators, at least 1 operator
```

#### Task B6: Edge Function — `create-game`
```
Input:  { player_id, opponent_type: "random"|"friend"|"local", deck_id, friend_id? }
Logic:
  1. Validate deck (call deck-validator)
  2. If random → add to matchmaking_queue (or pair if match found)
  3. If friend → create challenge record, return pending
  4. If local → initialize immediately
  5. Call state-machine.initializeGame()
  6. Insert game, game_streams, game_hands rows
  7. Return game object
```

#### Task B7: Edge Function — `submit-action`
```
Input:  { game_id, action: { type, source, target } }
Logic:
  1. Load game state from DB (games + game_streams + game_hands)
  2. Verify caller is active_player
  3. Validate action via rules-engine.validateAction()
  4. Process action via state-machine.processAction()
  5. Check win conditions
  6. Update game state in DB (transactional)
  7. Insert game_actions log entry
  8. If turn ended → trigger push notification (call send-push)
  9. Return updated game state
  10. Supabase Realtime auto-broadcasts DB changes to subscribed opponent
```

#### Task B8: Edge Function — `matchmaking`
```
Input:  { player_id, deck_id }
Logic:
  1. Insert into matchmaking_queue
  2. Query for another player within ±200 rank
  3. If found → remove both from queue → call create-game logic
  4. If not found → return { status: "queued" }
  5. (Opponent is notified via Realtime subscription on matchmaking_queue)
```

#### Task B9: Edge Functions — `concede-game`, `validate-deck`, `send-push`
- `concede-game`: Update game status, set winner, broadcast via Realtime
- `validate-deck`: Run deck-validator, return result
- `send-push`: Accept `{ player_id, title, body, data }`, look up device_token, call FCM HTTP API

---

### TRACK C — Agent 3: Static Screens (No Game Logic)

> **Depends on**: C1–C4 (design system), A1 (project scaffold)

These screens use the design system components and connect to Cubits. They don't require the game engine.

#### Task C5: Splash & Auth Screens
- **Splash Screen**: Time Tree assembles animation (branches draw in, logo appears as node label). 2-3s duration, auto-transition.
- **Login Screen**: Email + password as TreeInput nodes on a branch. "Sign In" and "Create Account" as TreeButtons. Google/Apple OAuth as smaller branch nodes.
- Wire to `AuthCubit`

#### Task C6: Main Hub Screen
- Central node with 4 branch paths diverging:
  - Active Games (left-up), Deck Builder (right-up), Friends (left-down), Settings (right-down)
- Player identity bar (name, rank, avatar TreeNode) at top
- Notification count / pending turn indicators at bottom
- Tap branch → energy flows along it → navigate to screen

#### Task C7: Active Games List Screen
- Vertical scrollable list of `GameListItem` components
- Filter tabs: "Your Turn" | "Waiting" | "Completed"
- "+" TreeButton (angular, top-right) for new game
- States: yellow pulse (your_turn), dim blue (opponent_turn), bright blue (won), faded (lost), fragmented (abandoned)
- Swipe left → Concede/Archive
- Wire to `GameListCubit`

#### Task C8: New Game Setup Screen (Overlay)
- Opponent selection: Random / Challenge Friend / Pass & Play
- Deck selector (from saved decks)
- Confirm TreeButton
- Wire to game creation flow

#### Task C9: Settings Screen
- Simple list of TreeToggle rows per Implementation Guide Section 3.10
- Account, Notifications, Audio, Visual (reduce motion, tree density), Game preferences, About
- Wire to `SettingsCubit` + `shared_preferences`

#### Task C10: Deck Builder Screen
- Horizontal scroll of DeckSlot components (saved decks)
- Each shows: name, card count, validity indicator
- "+" to create new deck
- Long-press: Rename / Duplicate / Delete
- Wire to `DeckListCubit`

#### Task C11: Deck Editor Screen
- **Top half**: Current deck contents (scrollable grid of CardThumbnail)
  - Card count/limit indicator (30/30), validity status
- **Bottom half**: Card collection browser
  - Filter bar: by type (Operator/Tactic/Event/Equipment), by cost, by faction
  - Search TreeInput
  - Scrollable grid of all owned CardThumbnails
- Tap card in collection → add to deck
- Tap card in deck → remove
- Tap-hold → Card Detail overlay
- Wire to `DeckEditorCubit`

#### Task C12: Card Detail Overlay
- TreeModal overlay on darkened background
- Full card art (angular frame)
- Card name, type, cost, text, flavor text, stats (if operator)
- Accessible from: hand, board, deck editor, collection

#### Task C13: Friends List Screen
- Search bar (TreeInput) at top
- Sections: "Online" (green dot) / "Offline"
- Each entry: FriendEntry component
- Tap → Friend Profile overlay (name, rank, head-to-head stats, Challenge button, Remove)
- Incoming requests section
- Wire to `FriendsCubit`

---

### TRACK D — Agent 4: Game Board UI (Parallel with Track C)

> **Depends on**: C1–C4 (design system), B1 (data models)

#### Task D1: Game Board Screen — Layout Shell
- Horizontal `PageView` or `ScrollView` with 3 panels:
  ```
  [Opponent Stream] ← scroll → [Your Stream (default)] ← scroll → [Hand + Menu]
  ```
- Default to center panel (Your Stream) on load
- Status bar at bottom: AP, turn number, phase indicator

#### Task D2: Stream Panel Widget
- Vertical column of 6 TurnpointCell widgets (centuries 2100–2600)
- Century labels on left edge (small, dim)
- Each cell shows: turnpoint card, operator tokens (OperatorToken), active effects
- Controller node at top/bottom
- Visual TreeBranch connectors between centuries

#### Task D3: Hand + Menu Panel Widget
- **Top**: Cards in hand — horizontal scrollable row of CardThumbnail widgets
  - Tap → Card Detail overlay
  - Drag toward board → initiate card play
- **Middle**: ActionPointBar showing remaining AP
- **Bottom**: Game menu
  - "End Turn" TreeButton (prominent, yellow activation color)
  - "Concede" (small, dim)
  - "Game Log" → scrollable action log
  - "Rules Reference"

#### Task D4: Targeting Overlay
- Valid targets highlighted with yellow pulsing borders
- Invalid areas dimmed
- Thin yellow line from source to finger position
- On confirm: ripple from source upward through tree

#### Task D5: Board Interaction System
Wire up the full action flow from Implementation Guide Section 3.5.2:
- Tap card in hand → CARD_SELECTED state → tap valid turnpoint → TARGETING → confirm → RESOLVING
- Tap operator on board → OPERATOR_SELECTED → choose action → TARGETING → confirm → RESOLVING
- Connect all to `GameBoardBloc` (full BLoC with events for traceability)

#### Task D6: GameBoardBloc (Full BLoC)
Complex state management for the game board:
```
Events:
  LoadGame(gameId)
  SelectCard(cardId)
  SelectOperator(operatorInstanceId)
  SelectTarget(position)
  ConfirmAction()
  CancelAction()
  EndTurn()
  ReceiveOpponentAction(action)

States:
  GameBoardInitial
  GameBoardLoading
  GameBoardLoaded(gameState, selectionState, validTargets)
  GameBoardActionResolving(gameState, action)
  GameBoardError(message)
  GameBoardGameOver(winner, reason)

SelectionState:
  None
  CardSelected(card, validTargets)
  OperatorSelected(operator, availableActions)
  Targeting(source, validTargets, currentTarget?)
```

---

## PHASE 3 — Integration & Networking (Week 5–7)

### TRACK A — Agent 1: Realtime & Push Notifications

> **Depends on**: B5–B9 (Edge Functions deployed), B2 (service layer)

#### Task A5: Supabase Realtime Integration
- Subscribe to `game:{game_id}` channel for live game updates
- Wire opponent actions through `GameBoardBloc` → animate opponent moves
- Subscribe to `presence:friends` for online/offline status
- Subscribe to `challenges:{player_id}` for incoming challenges
- Handle reconnection and state sync after disconnect

#### Task A6: Push Notifications
- Initialize FCM in `main.dart`
- Register device tokens on login (store in `device_tokens` table)
- Handle background messages → deep link to correct game via `go_router`
- Handle foreground messages → show in-app notification via `flutter_local_notifications`
- Test turn reminder notifications end-to-end

#### Task A7: Matchmaking Queue UI
- "Searching for opponent..." screen with animated TreeBranch
- Subscribe to matchmaking result via Realtime
- Auto-navigate to Game Board when match found
- Cancel matchmaking option

---

### TRACK B — Agent 2: Client-Server Integration

> **Depends on**: B5–B9 (Edge Functions), C5–C13 (screens), D1–D6 (board)

#### Task B10: Wire Game Flow End-to-End
- Active Games List → loads real games from Supabase
- New Game Setup → calls `create-game` Edge Function
- Game Board → loads game state, submits actions via `submit-action`
- Turn cycling → push notifications → opponent loads updated state
- Concede → calls `concede-game`
- Game over → post-game summary screen

#### Task B11: Wire Deck Flow End-to-End
- Deck Builder → loads decks from Supabase
- Deck Editor → saves to Supabase, validates via `validate-deck`
- Card Collection → loads from local drift cache (synced from Supabase)

#### Task B12: Wire Social Flow End-to-End
- Friends List → loads from Supabase `friendships` table
- Friend requests → insert/update via Supabase
- Challenge → calls `create-game` with `opponent_type: "friend"`
- Presence → Supabase Realtime Presence

#### Task B13: Local Caching with Drift
- Set up Drift (SQLite) database for offline data:
  - Card catalog (sync on launch)
  - Deck data (sync on change)
  - Game state snapshots (for offline viewing)
- Sync strategy: pull from Supabase on app start, cache locally, serve from cache

---

### TRACK D — Agent 4: Combat & Card Resolution Animations

> **Depends on**: D1–D6 (board UI), C2 (easing curves)

#### Task D7: Combat Resolution Animation
- Lines between combatants intensify, flicker 3x (600ms)
- Damage numbers: small sharp text (not floating cartoonish)
- Operator eliminated: token fractures into line segments that drift apart and fade (800ms)
- Surviving operator: brief stabilization pulse

#### Task D8: Card Play Resolution Animation
- Card dissolves into energy lines flowing to target turnpoint (500ms)
- Turnpoint flickers and reconfigures
- Ripple propagates up tree background

#### Task D9: Operator Move Animation
- Token slides along branch path (400ms)
- Leaves fading trail behind

#### Task D10: Turn Transition Animations
- Your turn start: yellow pulse from bottom to top of your stream (500ms)
- Opponent turn start: blue pulse on opponent stream (500ms)
- End turn: lines briefly dim, then opponent stream brightens (400ms)

---

## PHASE 4 — Time Tree & Polish (Week 7–9)

### TRACK E — Agent 5: Time Tree Background System

> **Depends on**: C1 (theme/colors), C2 (easing curves)
> **Can start in Phase 2** — independent of game logic

#### Task E1: Time Tree Renderer (`TimeTreePainter`)
- CustomPainter that renders the full tree background
- Procedural branch generation: straight-line segments with node points
- Algorithm:
  - Start with trunk at bottom center
  - Branch recursively with angular splits (no organic curves)
  - Node points at branch junctions (small squares/diamonds)
  - Use colors from TechStack.md Section 5
- Performance target: 60fps on mid-range devices

#### Task E2: Micro-Oscillation System
- Continuous sine-wave displacement on branch vertices (0.5–1px amplitude)
- Runs on infinite loop using `AnimationController` with `repeat()`
- Respect "Reduce motion" accessibility setting

#### Task E3: Ripple System
```dart
class Ripple {
  Offset origin;       // interaction point
  double intensity;    // 0.1 (tap) to 1.0 (game over)
  double speed;        // pixels per frame
  String direction;    // always "up"
  double decay;        // intensity drop rate
  int affectedBranches;
}
```
- Triggered by every user interaction
- Intensity scale: 0.1 (button tap), 0.3 (card played), 0.5 (attack), 0.8 (elimination), 1.0 (game over)
- Travels upward through tree branches
- Multiple ripples can coexist

#### Task E4: Tree Density Control
- Settings slider adjusts branch count and animation complexity
- Reduced motion toggle disables oscillation and ripples entirely
- Store preference in `shared_preferences`

#### Task E5: Screen Transition Integration
- Branch energy flows in direction of navigation before panel slides in (300–400ms)
- Each hub branch animates when its screen is selected
- Tree responds contextually to current screen (game board = more intense, settings = calm)

---

### TRACK C — Agent 3: Onboarding & Tutorial

> **Depends on**: C5 (auth screens), D1–D6 (board), E1 (tree background)

#### Task C14: Onboarding Screens (First-Time User)
- 3–4 screens explaining lore and core mechanic:
  1. "You are broken. The AI offers redemption."
  2. "6 operators. 6 centuries. 2 streams."
  3. "Eliminate the rival — or destroy their Controller."
  4. "Build your deck. Enter the stream."
- Shown after first account creation, before hub access

#### Task C15: Tutorial Game
- Guided first match vs simple AI opponent
- Highlight valid actions step-by-step
- Teach: play card, move operator, attack, end turn
- On completion → starter deck awarded → hub unlocked

#### Task C16: Post-Game Summary Screen
- Win/Loss result display
- Key moments (optional)
- XP / rewards earned
- "Rematch" and "Return to Hub" TreeButtons

---

## PHASE 5 — Final Polish & Launch (Week 9–11)

### ALL AGENTS — Parallel Final Tasks

#### Agent 1: Task A8 — Audio System
- Integrate `audioplayers` package
- Ambient music: low, dark ambient (subdued sci-fi hum, not orchestral)
- SFX: branch hum, node click, ripple whoosh, combat clash, card dissolve
- Volume controls wired to Settings
- Audio files stored in Supabase Storage, cached locally

#### Agent 1: Task A9 — Error Tracking & Analytics
- Integrate Sentry for crash reports and performance monitoring
- Optional: PostHog or Mixpanel for player behavior analytics

#### Agent 2: Task B14 — Scheduled Jobs (pg_cron)
- `cleanup_stale_games()` — mark games as abandoned after 7 days of inactivity
- `send_turn_reminders()` — push notification for turns older than 24 hours
- Schedule both via `pg_cron` in Supabase

#### Agent 3: Task C17 — Accessibility & Final UI Polish
- Verify all components work with screen readers
- Ensure adequate contrast ratios
- Test reduced motion mode end-to-end
- Ensure all interactive elements have adequate touch targets (48px minimum)

#### Agent 4: Task D11 — Win/Lose Animations
- Win: all branches in your stream illuminate fully, steady glow (1500ms)
- Lose: your stream's branches fade and fragment (1500ms)

#### Agent 5: Task E6 — Performance Optimization
- Profile Time Tree rendering on low-end devices
- Reduce draw calls if needed (batch branch rendering)
- Optimize CustomPainter `shouldRepaint` logic
- Verify 60fps target on mid-range devices (2021+ phones)
- App binary size check (target < 50MB)

#### All Agents: Task X1 — Integration Testing
- Full game flow: create account → build deck → start game → play turns → win/lose
- Multiplayer: two clients, turn cycling, push notifications
- Offline: view cached games, browse decks
- Edge cases: concede mid-game, disconnect and reconnect, matchmaking timeout

#### All Agents: Task X2 — App Store Preparation
- App icons and splash screens
- App Store screenshots and descriptions
- Privacy policy (required for Apple)
- Data deletion capability via Supabase Auth
- Apple Sign-In compliance
- TestFlight / Google Play internal testing track

---

## Dependency Graph (Critical Path)

```
A1 (scaffold) ──────────────────────────┐
A2 (database) ───→ B5-B9 (engine) ──→ B10-B12 (integration) ──→ X1 (testing)
A3 (seed data) ──→ B5 (rules engine)                              │
                                                                    ▼
B1 (models) ──→ B2 (services) ──→ B3 (auth) ──────────────────→ B10-B12
               ──→ D1-D6 (board UI)                                │
                                                                    ▼
C1-C4 (design system) ──→ C5-C13 (screens) ──→ C14-C16 (onboard) → X2 (launch)
                        ──→ D1-D6 (board UI) ──→ D7-D10 (anim)     │
                        ──→ E1-E5 (tree) ──→ E6 (perf opt) ────────┘
```

**Critical path**: A2 → B5-B9 → B10 → X1 → X2

---

## Agent Assignment Summary

| Agent | Primary Responsibility | Phases Active |
|---|---|---|
| **Agent 1** | Infrastructure, Supabase, CI/CD, Realtime, Push, Audio | 1, 3, 5 |
| **Agent 2** | Data models, Services, Game engine (Edge Functions), Integration | 1, 2, 3, 5 |
| **Agent 3** | Design system, UI components, Static screens, Onboarding | 1, 2, 3, 4, 5 |
| **Agent 4** | Game board UI, Gameplay interactions, Combat animations | 2, 3, 4, 5 |
| **Agent 5** | Time Tree background, Ripple system, Performance optimization | 2 (start), 4, 5 |

---

## Parallel Execution Timeline

```
Week  1  2  3  4  5  6  7  8  9  10  11
      ├──┤  ├─────┤  ├─────┤  ├─────┤  ├──┤
      Ph1    Ph2      Ph3      Ph4      Ph5

Agent 1: [A1-A4]·········[A5-A7]·········[A8-A9]
Agent 2: [B1-B4]··[B5-B9]·····[B10-B13]··[B14]
Agent 3: [C1-C4]··[C5-C13]·········[C14-C16]··[C17]
Agent 4: ·········[D1-D6]··[D7-D10]·········[D11]
Agent 5: ·········[E1-E4]·········[E5]··[E6]
All:     ··································[X1][X2]
```

**Maximum parallelism**: 5 agents working simultaneously from Phase 2 onward.

---

## Task Count Summary

| Track | Tasks | Estimated Complexity |
|---|---|---|
| Track A (Infrastructure) | 9 tasks | Medium |
| Track B (Engine & Services) | 14 tasks | High |
| Track C (UI & Screens) | 17 tasks | Medium-High |
| Track D (Game Board) | 11 tasks | High |
| Track E (Time Tree) | 6 tasks | Medium |
| Cross-cutting (X) | 2 tasks | Medium |
| **Total** | **59 tasks** | |
