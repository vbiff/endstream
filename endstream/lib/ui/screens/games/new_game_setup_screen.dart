import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../../../core/cubits/games/game_list_cubit.dart';
import '../../../core/models/enums.dart';
import '../../components/components.dart';
import 'new_game_action_buttons.dart';
import 'new_game_deck_selector.dart';
import 'new_game_opponent_selector.dart';

/// New game setup screen for selecting opponent type and deck.
class NewGameSetupScreen extends StatefulWidget {
  const NewGameSetupScreen({super.key, this.friendId});

  final String? friendId;

  @override
  State<NewGameSetupScreen> createState() => _NewGameSetupScreenState();
}

class _NewGameSetupScreenState extends State<NewGameSetupScreen> {
  late OpponentType? _selectedOpponentType;
  String? _selectedDeckId;

  @override
  void initState() {
    super.initState();
    _selectedOpponentType =
        widget.friendId != null ? OpponentType.friend : null;
  }

  bool get _canStart =>
      _selectedOpponentType != null && _selectedDeckId != null;

  Future<void> _handleStart() async {
    if (!_canStart) return;

    if (_selectedOpponentType == OpponentType.random) {
      context.push('/games/matchmaking', extra: _selectedDeckId!);
      return;
    }

    final cubit = context.read<GameListCubit>();
    final game = await cubit.createGame(
      opponentType: _selectedOpponentType!,
      deckId: _selectedDeckId!,
      friendId: widget.friendId,
    );
    if (game != null && mounted) {
      context.go('/games/${game.id}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const _NewGameTopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const _SectionLabel(text: 'OPPONENT'),
                    const SizedBox(height: 12),
                    NewGameOpponentSelector(
                      selected: _selectedOpponentType,
                      onSelected: (type) =>
                          setState(() => _selectedOpponentType = type),
                    ),
                    const SizedBox(height: 24),
                    const TreeDivider(),
                    const SizedBox(height: 16),
                    const _SectionLabel(text: 'SELECT DECK'),
                    const SizedBox(height: 12),
                    NewGameDeckSelector(
                      selectedDeckId: _selectedDeckId,
                      onSelected: (id) =>
                          setState(() => _selectedDeckId = id),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: NewGameActionButtons(
                canStart: _canStart,
                onStart: _handleStart,
                onCancel: () => context.pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NewGameTopBar extends StatelessWidget {
  const _NewGameTopBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: const Text(
              '<',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 18,
                color: TreeColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'NEW GAME',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 15,
              fontWeight: FontWeight.w400,
              letterSpacing: 2.0,
              color: TreeColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 2.0,
        color: TreeColors.textSecondary,
      ),
    );
  }
}
