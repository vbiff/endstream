# EndStream — Mobile Implementation Guide

## Table of Contents

1. [App Architecture Overview](#1-app-architecture-overview)
2. [Screen Map & Navigation](#2-screen-map--navigation)
3. [Screen Specifications](#3-screen-specifications)
4. [Core Workflows](#4-core-workflows)
5. [Game State Machine](#5-game-state-machine)
6. [Data Models](#6-data-models)
7. [UI Component Library](#7-ui-component-library)
8. [Animation & Motion System](#8-animation--motion-system)
9. [Multiplayer & Networking](#9-multiplayer--networking)
10. [Tech Stack Recommendations](#10-tech-stack-recommendations)

---

## 1. App Architecture Overview

```
App Shell (Time Tree Background — always rendered)
├── Auth Layer
├── Main Hub (tab-based navigation)
│   ├── Active Games
│   ├── Deck Builder
│   ├── Friends
│   └── Settings
├── Game Session (full-screen takeover)
│   ├── Board View (horizontally scrollable)
│   ├── Hand Panel
│   └── Game Menu
└── Overlay System (modals, tooltips, confirmations)
```

The Time Tree background is a persistent WebGL/Canvas layer that lives behind every screen. All UI panels are "mounted" onto this tree visually. Navigation between screens triggers branch ripple animations on the tree before the panel transitions.

---

## 2. Screen Map & Navigation

### Primary Screens

| Screen | Access From | Purpose |
|---|---|---|
| **Splash / Login** | App launch | Authentication |
| **Main Hub** | Post-login | Central navigation |
| **Active Games List** | Hub tab | Resume or view ongoing matches |
| **New Game Setup** | Active Games → "+" | Configure and start a match |
| **Game Board** | Active Games → select game | Core gameplay |
| **Hand & Menu Panel** | Game Board → scroll right | View cards, actions, game menu |
| **Deck Builder** | Hub tab | Build and manage decks |
| **Deck Editor** | Deck Builder → select deck | Edit a specific deck |
| **Card Detail** | Any card tap | Full card info overlay |
| **Friends List** | Hub tab | Social features |
| **Friend Profile** | Friends → select friend | Stats, challenge option |
| **Settings** | Hub tab | App preferences |

### Navigation Flow Diagram

```
[Splash] → [Login] → [Main Hub]
                          │
            ┌─────────────┼─────────────┬──────────────┐
            ▼             ▼             ▼              ▼
      [Active Games]  [Deck Builder]  [Friends]    [Settings]
            │             │             │
            ▼             ▼             ▼
      [Game Board]   [Deck Editor]  [Friend Profile]
            │             │             │
            ▼             ▼             ▼
      [Hand/Menu]    [Card Detail]  [Challenge → New Game]
```

---

## 3. Screen Specifications

### 3.1 Splash & Authentication

**Splash Screen**
- Time tree slowly assembles from nothing — branches draw themselves in
- Logo "EndStream" appears as a node label on the trunk
- Duration: 2–3 seconds, then auto-transition

**Login Screen**
- Minimal: email + password fields styled as input nodes on a branch
- "Sign In" and "Create Account" as angular button nodes
- OAuth options (Apple, Google) as smaller branch nodes
- No decorative elements — the tree IS the decoration

**Workflow:**
```
App Launch → Splash Animation → Check Auth Token
  ├── Valid → Main Hub
  └── Invalid → Login Screen → Auth Flow → Main Hub
```

---

### 3.2 Main Hub

The hub is not a traditional home screen. It's a junction point on the tree where four major branches diverge. Each branch leads to a tab.

**Layout:**
- Top: Player identity bar (name, rank, avatar node)
- Center: Four branch paths extending from a central node, each labeled
  - Active Games (left-up)
  - Deck Builder (right-up)
  - Friends (left-down)
  - Settings (right-down)
- Bottom: Current notification count / pending turn indicators

**Interaction:** Tapping a branch animates energy flowing along it, then the corresponding screen slides in from that direction.

---

### 3.3 Active Games List

**Layout:**
- Vertical scrollable list
- Each game entry is a horizontal branch segment showing:
  - Opponent name
  - Turn indicator (your turn / their turn / finished)
  - Current century / round number
  - Time since last action
- "+" button (angular, top-right) to start a new game
- Filter tabs at top: "Your Turn" | "Waiting" | "Completed"

**States per game entry:**
- `your_turn` — yellow pulse on the node
- `opponent_turn` — dim blue, static
- `completed_won` — bright steady blue
- `completed_lost` — dim, line partially faded
- `abandoned` — line broken/fragmented

**Workflow:**
```
Active Games List
  ├── Tap game (your turn) → Load Game Board
  ├── Tap game (waiting) → Load Game Board (spectate/review)
  ├── Tap game (completed) → Load Game Board (replay mode)
  ├── Tap "+" → New Game Setup
  └── Swipe left on game → Concede / Archive
```

---

### 3.4 New Game Setup

**Layout (overlay or full screen):**
- Select opponent:
  - "Random Opponent" — matchmaking
  - "Challenge Friend" — opens friend picker
  - "Pass & Play" — local two-player
- Select deck (from your built decks)
- Confirm button

**Workflow:**
```
New Game Setup
  ├── Choose opponent type
  ├── Choose deck
  ├── Confirm → 
  │     ├── Random: Enter matchmaking queue → Game Board (when matched)
  │     ├── Friend: Send challenge → Waiting screen → Game Board (when accepted)
  │     └── Local: Game Board (immediate)
  └── Cancel → Back to Active Games
```

---

### 3.5 Game Board (Core Screen)

This is the most complex screen. It is a horizontally scrollable viewport showing three panels.

**Horizontal scroll structure:**
```
[Opponent Stream] ← scroll → [Your Stream] ← scroll → [Hand + Menu]
   (left)                      (center/default)              (right)
```

On load, the view defaults to "Your Stream" (right-side stream).

#### 3.5.1 Stream Panel (×2)

Each stream is a vertical column of 6 turnpoints (centuries), filling the screen height.

**Layout per stream:**
- 6 rows, each representing a century (e.g., 2100, 2200, ... 2600)
- Century label on the left edge (small, dim)
- Each turnpoint cell shows:
  - The turnpoint card (terrain/event type)
  - Operators present (as small angular tokens)
  - Active effects / modifiers (as small icons or line patterns)
- Controller node at the top or bottom of each stream (the AI target)
- Visual connectors between centuries (the branch segments)

**Interaction on the board:**
- Tap a turnpoint → expand detail (operators present, effects, actions available)
- Tap an operator token → operator detail overlay (stats, abilities, status)
- Long-press a turnpoint → contextual action menu (move, deploy, activate ability)
- Scroll vertically within a stream is locked (all 6 fit on screen) unless operator detail is expanded

#### 3.5.2 Hand + Menu Panel

**Layout (scrolled-to from the right):**
- Top section: Cards in hand (horizontal scrollable row or stacked fan)
  - Each card is tappable → Card Detail overlay
  - Drag a card toward the board to play it
- Middle section: Resources / action points remaining this turn
- Bottom section: Game menu
  - "End Turn" button (prominent, yellow activation color)
  - "Concede" (small, dim)
  - "Game Log" (small) → opens scrollable log of all actions
  - "Rules Reference" (small)

**Workflow during a turn:**
```
Your Turn Begins
  ├── View board state (scroll between streams)
  ├── Select action:
  │     ├── Play a card from hand
  │     │     ├── Tap card → Card Detail (preview)
  │     │     ├── Drag card to valid turnpoint → Targeting UI
  │     │     ├── Confirm target → Card resolves
  │     │     └── Cancel → Card returns to hand
  │     ├── Move an operator
  │     │     ├── Tap operator on board → Highlight valid moves
  │     │     ├── Tap destination → Confirm move
  │     │     └── Cancel → Deselect
  │     ├── Activate operator ability
  │     │     ├── Tap operator → Action menu
  │     │     ├── Select ability → Targeting UI (if needed)
  │     │     └── Confirm → Ability resolves
  │     └── Attack
  │           ├── Tap your operator → Tap enemy operator/controller
  │           ├── Combat resolution animation
  │           └── Result displayed
  ├── Repeat actions (if action points remain)
  └── End Turn → Opponent's turn begins
```

#### 3.5.3 Board Overlays

**Targeting UI:**
- Valid targets highlighted with yellow pulsing borders
- Invalid areas dimmed further
- A thin yellow line connects source to cursor/finger position
- On confirm: ripple travels from action source upward through the tree

**Combat Resolution:**
- Brief animation: lines between combatants intensify, flicker
- Damage numbers appear as small sharp text (not floating cartoonish numbers)
- Eliminated operator: token fractures into line segments that drift apart and fade
- Surviving operator: brief stabilization pulse

**Card Play Resolution:**
- Card dissolves into energy lines that flow into the target turnpoint
- Turnpoint flickers and reconfigures
- Ripple propagates up the tree background

---

### 3.6 Deck Builder

**Layout:**
- Top: List of your saved decks (horizontal scroll of deck "cards" / nodes)
  - Each deck node shows: name, card count, validity indicator
  - "+" to create new deck
- Bottom: Tap a deck to enter Deck Editor

**Workflow:**
```
Deck Builder
  ├── View deck list
  ├── Tap deck → Deck Editor
  ├── Tap "+" → Name new deck → Deck Editor (empty)
  ├── Long-press deck → Rename / Duplicate / Delete
  └── Back → Main Hub
```

---

### 3.7 Deck Editor

**Layout:**
- Top half: Current deck contents (scrollable grid of card thumbnails)
  - Card count / limit indicator (e.g., 30/30)
  - Deck validity status (meets rules requirements)
- Bottom half: Card collection browser
  - Filter bar: by type (Operator, Tactic, Event, Equipment), by cost, by faction
  - Search field
  - Scrollable grid of all owned cards
- Tap a card in collection → adds to deck (if valid)
- Tap a card in deck → removes from deck
- Tap and hold any card → Card Detail overlay

**Workflow:**
```
Deck Editor
  ├── Browse collection (filter, search)
  ├── Tap card in collection → Add to deck
  ├── Tap card in deck → Remove from deck
  ├── Tap-hold any card → Card Detail overlay
  ├── Save → Validate deck → Return to Deck Builder
  └── Back (unsaved changes) → Confirm discard dialog
```

---

### 3.8 Card Detail (Overlay)

**Layout (modal overlay on a darkened background):**
- Full card art (angular frame, not rounded)
- Card name, type, cost
- Card text / ability description
- Flavor text (dim, small)
- Stats (if operator: HP, ATK, abilities)
- "Close" — tap outside or X node

This overlay is accessible from: hand, board (tap operator), deck editor, collection.

---

### 3.9 Friends List

**Layout:**
- Search bar at top (find by username)
- Sections:
  - "Online" — friends currently active (subtle green dot on their node)
  - "Offline" — all others
- Each friend entry: name, last seen, win/loss record against them
- Tap friend → Friend Profile

**Friend Profile (overlay or sub-screen):**
- Name, rank, avatar
- Head-to-head stats
- "Challenge" button → New Game Setup (pre-filled with this friend)
- "Remove Friend"

**Workflow:**
```
Friends List
  ├── Search → Send friend request
  ├── Tap friend → Friend Profile
  │     ├── Challenge → New Game Setup
  │     └── Remove → Confirm dialog
  ├── Incoming requests section (if any)
  │     ├── Accept → Added to list
  │     └── Decline → Removed
  └── Back → Main Hub
```

---

### 3.10 Settings

**Layout — simple list of angular toggle rows:**
- **Account:** Display name, email, sign out, delete account
- **Notifications:** Push notifications toggle, turn reminders
- **Audio:** Music volume, SFX volume
- **Visual:** Reduce motion toggle (accessibility), tree density slider
- **Game:** Auto-end turn when no actions remain (toggle), confirm before ending turn
- **About:** Version, credits, rules PDF link, support/contact

---

## 4. Core Workflows

### 4.1 First-Time User Journey

```
1. Download & Launch
2. Splash screen (tree assembles)
3. Create Account / Sign In
4. Brief Onboarding (3–4 screens explaining the lore and core mechanic)
     - "You are broken. The AI offers redemption."
     - "6 operators. 6 centuries. 2 streams."
     - "Eliminate the rival — or destroy their Controller."
     - "Build your deck. Enter the stream."
5. Receive starter deck (auto-assigned)
6. Tutorial game (vs AI) — guided first match
7. Main Hub unlocked
```

### 4.2 Standard Game Session

```
1. Enter Active Games
2. Start new game or resume existing
3. Game Board loads → your stream visible
4. If your turn:
     a. Review board state (scroll to opponent stream if needed)
     b. Play cards, move operators, use abilities, attack
     c. End turn
5. If opponent's turn:
     a. View board (read-only)
     b. Optionally review game log
     c. Wait or leave (push notification when it's your turn)
6. Game ends when:
     a. All enemy operators eliminated → Victory
     b. Enemy Controller destroyed → Victory
     c. Your operators eliminated → Defeat
     d. Your Controller destroyed → Defeat
     e. Concession by either player
7. Post-game summary screen:
     - Win/Loss result
     - Key moments replay (optional)
     - XP / rewards earned
     - "Rematch" / "Return to Hub"
```

### 4.3 Deck Building Session

```
1. Enter Deck Builder from Hub
2. Create new or edit existing deck
3. Use filters and search to find cards
4. Add/remove cards until the deck meets validity rules
5. Save
6. Deck is now selectable when starting a new game
```

### 4.4 Social / Challenge Flow

```
1. Enter Friends List
2. Tap a friend → Profile
3. Tap "Challenge"
4. Select your deck
5. Challenge sent (opponent receives push notification)
6. Opponent accepts → Game created → Appears in Active Games for both
7. Opponent declines → Notification sent back
```

---

## 5. Game State Machine

```
┌─────────────┐
│  GAME_INIT  │  Setting up board, dealing hands, placing operators
└──────┬──────┘
       ▼
┌─────────────┐
│ TURN_START  │  Determine active player, refresh action points
└──────┬──────┘
       ▼
┌─────────────────┐
│  ACTION_PHASE   │◄──────────────────────┐
│                 │  Player performs       │
│  - play_card    │  actions until AP = 0  │
│  - move_op      │  or manually ends     │
│  - use_ability  │                       │
│  - attack       │───────────────────────┘
│  - end_turn     │
└──────┬──────────┘
       ▼
┌─────────────┐
│  TURN_END   │  Resolve end-of-turn effects, check win conditions
└──────┬──────┘
       │
       ├── Win condition met? ──► [GAME_OVER]
       │
       └── No ──► Switch active player ──► [TURN_START]

┌─────────────┐
│  GAME_OVER  │  Display results, archive game
└─────────────┘
```

### Substates during ACTION_PHASE:

```
IDLE → (tap card) → CARD_SELECTED → (tap target) → TARGETING → (confirm) → RESOLVING → IDLE
IDLE → (tap operator) → OPERATOR_SELECTED → (choose action) → TARGETING → (confirm) → RESOLVING → IDLE
```

---

## 6. Data Models

### 6.1 Player

```
Player {
  id: string
  display_name: string
  email: string
  avatar_id: string
  rank: int
  xp: int
  created_at: timestamp
  decks: Deck[]
  friends: string[]           // player IDs
  active_games: string[]      // game IDs
}
```

### 6.2 Deck

```
Deck {
  id: string
  owner_id: string
  name: string
  cards: CardEntry[]          // { card_id, quantity }
  is_valid: bool
  created_at: timestamp
  updated_at: timestamp
}
```

### 6.3 Card

```
Card {
  id: string
  name: string
  type: enum [OPERATOR, TACTIC, EVENT, EQUIPMENT]
  cost: int                   // action points to play
  rarity: enum [COMMON, RARE, EPIC, LEGENDARY]
  text: string                // ability description
  flavor_text: string
  art_asset_id: string
  stats: {                    // only for OPERATOR type
    hp: int
    attack: int
    abilities: Ability[]
  }
}
```

### 6.4 Game

```
Game {
  id: string
  player_1: { player_id, deck_id, stream: Turnpoint[6] }
  player_2: { player_id, deck_id, stream: Turnpoint[6] }
  current_turn: int
  active_player: string       // player_id
  status: enum [ACTIVE, COMPLETED, ABANDONED]
  winner: string | null
  action_log: Action[]
  created_at: timestamp
  last_action_at: timestamp
}
```

### 6.5 Turnpoint

```
Turnpoint {
  century: int                // 2100, 2200, etc.
  terrain_type: string
  operators: OperatorInstance[]
  active_effects: Effect[]
  controller_present: bool    // true if this is the controller's position
}
```

### 6.6 OperatorInstance

```
OperatorInstance {
  operator_card_id: string
  owner_id: string
  current_hp: int
  max_hp: int
  attack: int
  position: { stream: 0|1, century_index: 0-5 }
  status_effects: StatusEffect[]
  has_acted_this_turn: bool
}
```

### 6.7 Action (for game log)

```
Action {
  turn: int
  player_id: string
  type: enum [PLAY_CARD, MOVE, ATTACK, ABILITY, END_TURN]
  source: { type, id, position }
  target: { type, id, position } | null
  result: { damage?, healed?, status_applied?, eliminated? }
  timestamp: timestamp
}
```

---

## 7. UI Component Library

All components follow the "Time Tree" design language. No rounded corners except for anomaly/singularity indicators.

### 7.1 Primitive Components

| Component | Description |
|---|---|
| `TreeButton` | Angular button with thin border, subtle pulse on hover/focus. Yellow highlight on press. |
| `TreeInput` | Text input styled as a branch segment. Cursor is a thin vertical line pulse. |
| `TreeToggle` | On/off switch as a node that slides along a branch segment. |
| `TreeCard` | Card container with angular corners, thin border, dark fill. |
| `TreeNode` | Small square or diamond marker, used as list bullets, indicators, avatar frames. |
| `TreeBranch` | Horizontal or vertical line connector between elements. Animated with subtle wave. |
| `TreeModal` | Overlay panel anchored to a branch point. Angular shape. |
| `TreeBadge` | Small angular label attached to a branch. For counts, status. |
| `TreeDivider` | Thin horizontal line with a node in the center. |

### 7.2 Composite Components

| Component | Composition |
|---|---|
| `GameListItem` | TreeBranch + TreeNode (status) + text labels + TreeBadge (turn indicator) |
| `TurnpointCell` | TreeCard containing terrain icon + operator tokens + effect icons |
| `OperatorToken` | Small angular avatar with HP bar (thin line underneath) |
| `CardThumbnail` | Miniature TreeCard with art, cost badge, name |
| `CardFull` | Full-size TreeCard with all card info (used in Card Detail overlay) |
| `FriendEntry` | TreeNode (avatar) + name + status dot + stats |
| `DeckSlot` | TreeCard showing deck name + card count + validity indicator |
| `ActionPointBar` | Row of small nodes (filled = available, empty = spent) |
| `ResourceCounter` | TreeNode with number label |

### 7.3 Background Layer

The Time Tree background is rendered as a **separate layer** behind all UI:
- Technology: Canvas 2D, or a lightweight WebGL shader (if using a web-based framework), or SpriteKit/SceneKit overlay for native
- The tree is procedurally generated with straight-line segments, node points, and subtle animated gradients
- Responds to app interactions with ripple animations
- Density and motion adjustable in Settings

---

## 8. Animation & Motion System

### 8.1 Easing Curves

```
standard:    cubic-bezier(0.25, 0.1, 0.25, 1.0)   // restrained ease-out
subtle:      cubic-bezier(0.33, 0.0, 0.67, 1.0)    // barely perceptible
sharp:       cubic-bezier(0.4, 0.0, 1.0, 1.0)      // quick start, slow end
linear:      linear                                  // for wave propagation
```

**Forbidden:** spring physics, bounce, overshoot, elastic.

### 8.2 Animation Catalog

| Trigger | Animation | Duration |
|---|---|---|
| Screen transition | Branch energy flows in direction of nav, panel slides in | 300–400ms |
| Tap button | Node flashes yellow, single ripple upward | 150ms |
| Play card | Card dissolves into line particles flowing to target | 500ms |
| Move operator | Token slides along branch path, leaving fading trail | 400ms |
| Attack | Lines between combatants intensify, flicker 3× | 600ms |
| Operator eliminated | Token fractures into segments that drift and fade | 800ms |
| Turn start (your turn) | Yellow pulse from bottom to top of your stream | 500ms |
| Turn start (opponent) | Blue pulse on opponent stream | 500ms |
| End turn | Lines briefly dim, then opponent stream brightens | 400ms |
| Win | All branches in your stream illuminate fully, steady glow | 1500ms |
| Lose | Your stream's branches fade and fragment | 1500ms |
| Idle background | Continuous micro-oscillation of tree branches (amplitude: 0.5–1px) | Infinite loop |

### 8.3 Ripple System

Every user interaction triggers a ripple on the tree background:

```
Ripple {
  origin: {x, y}          // where the interaction happened
  intensity: float         // 0.1 (small tap) to 1.0 (major game action)
  speed: float             // pixels per frame
  direction: "up"          // always propagates upward (power flows up)
  decay: float             // how quickly intensity drops
  affected_branches: int   // how many branches react
}
```

**Intensity scale:**
- 0.1 — button tap, menu navigation
- 0.3 — card played, operator moved
- 0.5 — attack, ability used
- 0.8 — operator eliminated
- 1.0 — game over (win or lose)

---

## 9. Multiplayer & Networking

### 9.1 Architecture

Asynchronous turn-based with optional real-time spectating.

```
Client ←→ REST API (game actions, auth, social)
Client ←→ WebSocket (real-time turn notifications, presence)
Server ←→ Database (game state, player data)
Server ←→ Push Service (FCM/APNs for turn notifications)
```

### 9.2 API Endpoints (Key)

```
POST   /auth/register
POST   /auth/login
GET    /games                        // list active games
POST   /games                        // create new game
GET    /games/:id                    // get game state
POST   /games/:id/actions            // submit action
POST   /games/:id/concede            // concede game
GET    /decks                        // list player decks
POST   /decks                        // create deck
PUT    /decks/:id                    // update deck
DELETE /decks/:id                    // delete deck
GET    /cards                        // get all cards in collection
GET    /friends                      // list friends
POST   /friends/request              // send friend request
POST   /friends/accept               // accept request
DELETE /friends/:id                  // remove friend
GET    /players/:id/profile          // public profile
```

### 9.3 WebSocket Events

```
// Server → Client
turn_started      { game_id, active_player }
action_performed   { game_id, action }
game_over         { game_id, winner, reason }
challenge_received { from_player, game_config }
friend_online     { player_id }

// Client → Server
subscribe_game    { game_id }
unsubscribe_game  { game_id }
```

### 9.4 Turn Flow (Network)

```
1. Client submits action → POST /games/:id/actions
2. Server validates action against game rules
3. Server updates game state
4. Server checks win conditions
5. Server broadcasts action via WebSocket to opponent
6. If turn ends → Server sends push notification to next player
7. Client receives updated state and animates
```

### 9.5 Conflict Resolution

- Server is authoritative — all game logic validated server-side
- Client performs optimistic rendering (animate immediately, rollback on rejection)
- Actions are idempotent (retry-safe with action IDs)
- Simultaneous actions impossible (turn-based, only active player can act)

---

## 10. Tech Stack Recommendations

### Option A: Flutter (Cross-Platform)

```
UI Framework:     Flutter
Game Background:  Flutter CustomPainter + Rive animations
State Management: Riverpod or Bloc
Networking:       Dio (REST) + web_socket_channel
Backend:          NestJS (TypeScript)
Database:         PostgreSQL + Redis (for sessions/matchmaking)
Push:             Firebase Cloud Messaging
Auth:             Firebase Auth or custom JWT
Hosting:          Railway / Fly.io / AWS
```

### Option B: Native (iOS-first, Swift)

```
UI Framework:     SwiftUI
Game Background:  SpriteKit (tree rendering) + SwiftUI overlay
State Management: SwiftUI @Observable + TCA (The Composable Architecture)
Networking:       URLSession + NWConnection (WebSocket)
Backend:          NestJS or Vapor (Swift server)
Database:          PostgreSQL + Redis
Push:             APNs
Auth:             Sign in with Apple + custom JWT
Hosting:          Railway / Fly.io / AWS
```

### Option C: React Native + Canvas

```
UI Framework:     React Native
Game Background:  react-native-skia or Expo GL
State Management: Zustand or Redux Toolkit
Networking:       Axios + native WebSocket
Backend:          NestJS
Database:         PostgreSQL + Redis
Push:             FCM / APNs via Expo Notifications
Auth:             Supabase Auth or Firebase
Hosting:          Supabase / Railway / AWS
```

### Backend Architecture (Any Option)

```
/server
  /modules
    /auth          — registration, login, JWT
    /games         — game CRUD, action processing, rules engine
    /matchmaking   — random opponent pairing
    /decks         — deck CRUD, validation
    /cards         — card catalog, collection management
    /social        — friends, challenges
    /notifications — push notification dispatch
  /engine
    /rules         — game rules validator
    /state         — game state machine
    /combat        — combat resolution logic
    /effects       — card effect processor
  /websocket       — real-time event broadcasting
```

---

## Appendix A: Screen Wireframe Notes

### Game Board — Spatial Layout

```
┌──────────────────────────────────┐
│         OPPONENT STREAM          │ ← scroll left to see
│  ┌──────┐                        │
│  │ 2600 │  [turnpoint content]   │
│  ├──────┤                        │
│  │ 2500 │  [turnpoint content]   │
│  ├──────┤                        │
│  │ 2400 │  [turnpoint content]   │
│  ├──────┤                        │
│  │ 2300 │  [turnpoint content]   │
│  ├──────┤                        │
│  │ 2200 │  [turnpoint content]   │
│  ├──────┤                        │
│  │ 2100 │  [turnpoint content]   │
│  └──────┘                        │
│  [CONTROLLER]                    │
└──────────────────────────────────┘

┌──────────────────────────────────┐
│          YOUR STREAM             │ ← default view
│  [CONTROLLER]                    │
│  ┌──────┐                        │
│  │ 2100 │  [turnpoint content]   │
│  ├──────┤                        │
│  │ 2200 │  [turnpoint content]   │
│  ├──────┤                        │
│  │ 2300 │  [turnpoint content]   │
│  ├──────┤                        │
│  │ 2400 │  [turnpoint content]   │
│  ├──────┤                        │
│  │ 2500 │  [turnpoint content]   │
│  ├──────┤                        │
│  │ 2600 │  [turnpoint content]   │
│  └──────┘                        │
│  [STATUS BAR: AP, turn, phase]   │
└──────────────────────────────────┘

┌──────────────────────────────────┐
│         HAND + MENU              │ ← scroll right to see
│                                  │
│  ┌─────┐ ┌─────┐ ┌─────┐       │
│  │Card │ │Card │ │Card │ ...    │
│  │  1  │ │  2  │ │  3  │       │
│  └─────┘ └─────┘ └─────┘       │
│                                  │
│  AP: ■ ■ ■ □ □                  │
│                                  │
│  ┌──────────────────┐           │
│  │    END TURN       │           │
│  └──────────────────┘           │
│  [Game Log] [Concede] [Rules]   │
└──────────────────────────────────┘
```

---

## Appendix B: Implementation Priority

### Phase 1 — Playable Prototype
1. Auth (basic email/password)
2. Game Board (core gameplay with local pass-and-play)
3. Basic card set (10–15 cards)
4. Game state machine and rules engine
5. Turn resolution and win conditions

### Phase 2 — Online Multiplayer
6. Backend API and database
7. Online game creation and turn submission
8. Push notifications for turn reminders
9. Active Games list

### Phase 3 — Deck Building & Collection
10. Full card catalog
11. Deck Builder and Deck Editor
12. Deck validation rules

### Phase 4 — Social Features
13. Friends list and friend requests
14. Challenge system
15. Player profiles and stats

### Phase 5 — Polish & Launch
16. Time Tree background animation system
17. Full animation catalog (ripples, transitions, combat)
18. Onboarding tutorial
19. Settings screen
20. Audio (ambient + SFX)
21. App Store / Play Store submission

---

## Appendix C: File & Folder Structure (Flutter Example)

```
/lib
  /app
    main.dart
    routes.dart
    theme.dart
  /core
    /models             — Player, Game, Card, Deck, etc.
    /engine             — GameStateMachine, RulesValidator, CombatResolver
    /services           — ApiService, WebSocketService, AuthService
    /providers           — Riverpod providers
  /ui
    /components         — TreeButton, TreeCard, TreeNode, etc.
    /background         — TimeTreePainter, RippleEngine
    /screens
      /auth             — LoginScreen, RegisterScreen
      /hub              — MainHubScreen
      /games            — ActiveGamesScreen, NewGameSetup
      /board            — GameBoardScreen, StreamPanel, HandPanel
      /deck             — DeckBuilderScreen, DeckEditorScreen
      /social           — FriendsScreen, FriendProfileScreen
      /settings         — SettingsScreen
    /overlays           — CardDetailOverlay, TargetingOverlay, CombatOverlay
    /animations         — AnimationCatalog, EasingCurves
/assets
  /images
  /audio
  /data
    cards.json
/server                 — NestJS backend (separate repo recommended)
```

---

*This guide should serve as the single reference for implementing EndStream. Each section can be expanded into detailed tickets and assigned to implementation sprints following the Phase priorities in Appendix B.*
