# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-02-26

### Added
- Two-player tactical card game with turn-based combat
- Game board with dual-timeline (2x6 grid) and three-panel PageView layout
- 15 unique cards across 4 types: Operator, Tactic, Event, Equipment
- 6 card abilities with targeted and passive effects
- Action Point system limiting actions per turn
- Win conditions: eliminate all enemy operators or destroy enemy Controller
- Deck builder with collection grid, deck editor, and server-side validation
- Online multiplayer via Supabase Realtime with optimistic rendering
- Rank-based matchmaking queue (±200 rank range)
- Friend challenges with accept/decline flow
- Local pass-and-play mode
- Friends list with search, add, and profile viewing
- Push notifications for turn reminders via Firebase Cloud Messaging
- Supabase Auth (email, Google, Apple Sign-In)
- Time Tree procedural background with micro-oscillation and ripple effects
- Board animations: combat lines, elimination fractures, move trails, card play particles
- Victory/defeat cascade overlays with staggered reveal
- Animated game board components (action points, operator tokens, hand cards)
- Drift SQLite offline cache for cards and decks
- Sentry error tracking and analytics
- Audio system with 12 SFX and 3 music tracks
- Settings screen with reduce-motion accessibility toggle
- Scheduled jobs for stale game cleanup and turn reminders
