-- ============================================================
-- EndStream Seed Data
-- Starter Card Catalog (15 cards) + Starter Deck Template
-- ============================================================
-- Run with: supabase db seed
-- Or manually: psql -f seed.sql
--
-- This seed is idempotent — uses ON CONFLICT to skip existing rows.
-- ============================================================

-- ========================
-- OPERATORS (6)
-- ========================
-- Archetype spread: Scout, Support, Tank, Damage, Controller, Balanced
-- Cost range: 2–4 AP | HP range: 2–6 | ATK range: 1–4

INSERT INTO cards (id, name, type, cost, rarity, text, flavor_text, art_asset_path, hp, attack) VALUES
  ('10000000-0000-4000-a000-000000000001', 'Kael, the Deserter', 'operator', 2, 'common',
   'Deploy: Kael may immediately move to an adjacent turnpoint.',
   'He left his unit in century 2400. The silence that followed was louder than any order.',
   NULL, 3, 2),

  ('10000000-0000-4000-a000-000000000002', 'Mira, the Forger', 'operator', 3, 'common',
   'Activate: Heal an adjacent friendly operator for 2 HP.',
   'She rewrote a thousand identities before the streams found her own.',
   NULL, 4, 1),

  ('10000000-0000-4000-a000-000000000003', 'Voss, the Warden', 'operator', 4, 'rare',
   'Activate: Prevent an adjacent enemy operator from moving next turn.',
   'He kept the gates sealed for three centuries. Some of the prisoners were innocent.',
   NULL, 6, 2),

  ('10000000-0000-4000-a000-000000000004', 'Ash, the Burner', 'operator', 3, 'common',
   'Activate: Deal 1 damage to ALL operators in the same turnpoint, including friendlies.',
   E'Century 2200\'s archives burned for eleven days. Nobody asked what was in them.',
   NULL, 3, 4),

  ('10000000-0000-4000-a000-000000000005', 'Sable, the Witness', 'operator', 2, 'rare',
   E'Activate: Reduce target operator\'s ATK by 1 until end of turn (minimum 0).',
   'She saw everything. Reported to everyone. Trusted by none.',
   NULL, 2, 2),

  ('10000000-0000-4000-a000-000000000006', 'Thane, the Anchor', 'operator', 3, 'common',
   'Activate: Remove one negative status effect from Thane.',
   'When timeline 7R collapsed, he held it open for nine seconds. Enough for twelve people. Not thirteen.',
   NULL, 4, 3)
ON CONFLICT (id) DO NOTHING;

-- ========================
-- TACTICS (4)
-- ========================
-- Direct-effect cards: damage, heal, buff, premium removal

INSERT INTO cards (id, name, type, cost, rarity, text, flavor_text, art_asset_path, hp, attack) VALUES
  ('20000000-0000-4000-a000-000000000001', 'Temporal Fracture', 'tactic', 2, 'common',
   'Deal 3 damage to target operator.',
   'A crack in the century. Brief, precise, irreversible.',
   NULL, NULL, NULL),

  ('20000000-0000-4000-a000-000000000002', 'Stream Mending', 'tactic', 2, 'common',
   'Restore 3 HP to target friendly operator.',
   'The timeline stitches itself shut. For now.',
   NULL, NULL, NULL),

  ('20000000-0000-4000-a000-000000000003', 'Surge Protocol', 'tactic', 1, 'common',
   'Target friendly operator gains +2 ATK until end of turn.',
   'Override accepted. Consequences deferred.',
   NULL, NULL, NULL),

  ('20000000-0000-4000-a000-000000000004', 'Chrono Severance', 'tactic', 4, 'rare',
   'Deal 5 damage to target operator. If this eliminates the target, gain 1 AP.',
   'Some threads are not meant to continue.',
   NULL, NULL, NULL)
ON CONFLICT (id) DO NOTHING;

-- ========================
-- EVENTS (3)
-- ========================
-- Turnpoint modifiers: persistent effects placed on board locations

INSERT INTO cards (id, name, type, cost, rarity, text, flavor_text, art_asset_path, hp, attack) VALUES
  ('30000000-0000-4000-a000-000000000001', 'Dead Century', 'event', 3, 'rare',
   'Place on a turnpoint. All operators here take 1 damage at the end of each turn. Lasts 3 turns.',
   E'Century 2300 went dark. Nothing survived there \u2014 nothing should.',
   NULL, NULL, NULL),

  ('30000000-0000-4000-a000-000000000002', 'Temporal Haven', 'event', 3, 'common',
   'Place on a turnpoint. Friendly operators here restore 1 HP at the start of your turn. Lasts 3 turns.',
   'A stable pocket. Rare. Temporary. Enough.',
   NULL, NULL, NULL),

  ('30000000-0000-4000-a000-000000000003', 'Stream Collapse', 'event', 2, 'common',
   'Place on a turnpoint. No operator may move into or out of this turnpoint. Lasts 2 turns.',
   'The path folds inward. Those inside are trapped. Those outside are spared.',
   NULL, NULL, NULL)
ON CONFLICT (id) DO NOTHING;

-- ========================
-- EQUIPMENT (2)
-- ========================
-- Permanent buffs attached to operators, destroyed on elimination

INSERT INTO cards (id, name, type, cost, rarity, text, flavor_text, art_asset_path, hp, attack) VALUES
  ('40000000-0000-4000-a000-000000000001', 'Null Blade', 'equipment', 2, 'rare',
   'Attach to a friendly operator. That operator gains +2 ATK permanently. Destroyed if the operator is eliminated.',
   E'Forged from a severed timeline. It cuts what shouldn\'t exist.',
   NULL, NULL, NULL),

  ('40000000-0000-4000-a000-000000000002', 'Phase Armor', 'equipment', 3, 'rare',
   'Attach to a friendly operator. That operator gains +3 max HP and +3 current HP. Destroyed if the operator is eliminated.',
   'Woven from overlapping realities. Each layer is a timeline that almost was.',
   NULL, NULL, NULL)
ON CONFLICT (id) DO NOTHING;

-- ========================
-- OPERATOR ABILITIES (6)
-- ========================

INSERT INTO abilities (id, card_id, name, description, cost) VALUES
  ('a0000000-0000-4000-a000-000000000001', '10000000-0000-4000-a000-000000000001',
   'Temporal Dash',
   'Move Kael to any adjacent turnpoint. Does not cost a move action.',
   1),

  ('a0000000-0000-4000-a000-000000000002', '10000000-0000-4000-a000-000000000002',
   'Reconstruct',
   'Restore 2 HP to a friendly operator in the same or adjacent turnpoint.',
   1),

  ('a0000000-0000-4000-a000-000000000003', '10000000-0000-4000-a000-000000000003',
   'Lockdown',
   'Target enemy operator in the same or adjacent turnpoint cannot move until end of next turn.',
   1),

  ('a0000000-0000-4000-a000-000000000004', '10000000-0000-4000-a000-000000000004',
   'Ignite',
   E'Deal 1 damage to every operator in Ash\'s current turnpoint, including friendly operators.',
   2),

  ('a0000000-0000-4000-a000-000000000005', '10000000-0000-4000-a000-000000000005',
   'Expose',
   E'Reduce target enemy operator\'s ATK by 1 until end of turn. Minimum 0. Target must be in same or adjacent turnpoint.',
   1),

  ('a0000000-0000-4000-a000-000000000006', '10000000-0000-4000-a000-000000000006',
   'Stabilize',
   'Remove one negative status effect from Thane. If Thane has no negative effects, gain 1 HP instead (up to max).',
   1)
ON CONFLICT (id) DO NOTHING;

-- ============================================================
-- STARTER DECK TEMPLATE
-- ============================================================
-- This is the deck composition automatically assigned to new players.
-- Deck is created per-player via Edge Function on first login.
--
-- 30 cards total (15 unique x 2 copies each)
-- Operators: 12 cards (6 unique x 2) — provides redundancy for draws
-- Tactics:    8 cards (4 unique x 2) — direct actions
-- Events:     6 cards (3 unique x 2) — board control
-- Equipment:  4 cards (2 unique x 2) — operator buffs
--
-- Cost curve:
--   1 AP: 2 cards  (Surge Protocol x2)
--   2 AP: 12 cards (Kael x2, Sable x2, Temporal Fracture x2, Stream Mending x2, Stream Collapse x2, Null Blade x2)
--   3 AP: 12 cards (Mira x2, Ash x2, Thane x2, Dead Century x2, Temporal Haven x2, Phase Armor x2)
--   4 AP: 4 cards  (Voss x2, Chrono Severance x2)
--
-- Average cost: 2.53 AP per card
-- Assumes 3 AP per turn → ~1-2 cards playable per turn
--
-- The starter deck template is stored here as reference.
-- Actual deck creation happens in the create-game or onboarding Edge Function:
--
-- INSERT INTO decks (owner_id, name, is_valid) VALUES ($player_id, 'Starter Deck', true);
-- INSERT INTO deck_cards (deck_id, card_id, quantity) VALUES
--   ($deck_id, '10000000-0000-4000-a000-000000000001', 2),  -- Kael x2
--   ($deck_id, '10000000-0000-4000-a000-000000000002', 2),  -- Mira x2
--   ($deck_id, '10000000-0000-4000-a000-000000000003', 2),  -- Voss x2
--   ($deck_id, '10000000-0000-4000-a000-000000000004', 2),  -- Ash x2
--   ($deck_id, '10000000-0000-4000-a000-000000000005', 2),  -- Sable x2
--   ($deck_id, '10000000-0000-4000-a000-000000000006', 2),  -- Thane x2
--   ($deck_id, '20000000-0000-4000-a000-000000000001', 2),  -- Temporal Fracture x2
--   ($deck_id, '20000000-0000-4000-a000-000000000002', 2),  -- Stream Mending x2
--   ($deck_id, '20000000-0000-4000-a000-000000000003', 2),  -- Surge Protocol x2
--   ($deck_id, '20000000-0000-4000-a000-000000000004', 2),  -- Chrono Severance x2
--   ($deck_id, '30000000-0000-4000-a000-000000000001', 2),  -- Dead Century x2
--   ($deck_id, '30000000-0000-4000-a000-000000000002', 2),  -- Temporal Haven x2
--   ($deck_id, '30000000-0000-4000-a000-000000000003', 2),  -- Stream Collapse x2
--   ($deck_id, '40000000-0000-4000-a000-000000000001', 2),  -- Null Blade x2
--   ($deck_id, '40000000-0000-4000-a000-000000000002', 2);  -- Phase Armor x2

-- ============================================================
-- STARTER DECK CONFIGURATION (JSON reference for Edge Functions)
-- ============================================================
-- This can be loaded by the onboarding Edge Function to create
-- a player's first deck automatically.

CREATE TABLE IF NOT EXISTS starter_deck_template (
  card_id UUID REFERENCES cards(id),
  quantity INTEGER NOT NULL DEFAULT 2 CHECK (quantity >= 1 AND quantity <= 2),
  PRIMARY KEY (card_id)
);

INSERT INTO starter_deck_template (card_id, quantity) VALUES
  ('10000000-0000-4000-a000-000000000001', 2),  -- Kael, the Deserter
  ('10000000-0000-4000-a000-000000000002', 2),  -- Mira, the Forger
  ('10000000-0000-4000-a000-000000000003', 2),  -- Voss, the Warden
  ('10000000-0000-4000-a000-000000000004', 2),  -- Ash, the Burner
  ('10000000-0000-4000-a000-000000000005', 2),  -- Sable, the Witness
  ('10000000-0000-4000-a000-000000000006', 2),  -- Thane, the Anchor
  ('20000000-0000-4000-a000-000000000001', 2),  -- Temporal Fracture
  ('20000000-0000-4000-a000-000000000002', 2),  -- Stream Mending
  ('20000000-0000-4000-a000-000000000003', 2),  -- Surge Protocol
  ('20000000-0000-4000-a000-000000000004', 2),  -- Chrono Severance
  ('30000000-0000-4000-a000-000000000001', 2),  -- Dead Century
  ('30000000-0000-4000-a000-000000000002', 2),  -- Temporal Haven
  ('30000000-0000-4000-a000-000000000003', 2),  -- Stream Collapse
  ('40000000-0000-4000-a000-000000000001', 2),  -- Null Blade
  ('40000000-0000-4000-a000-000000000002', 2)   -- Phase Armor
ON CONFLICT (card_id) DO NOTHING;
