import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/cubits/decks/deck_editor_cubit.dart';
import '../../components/components.dart';

/// Top bar for deck editor with name, card count, save, and cancel.
class DeckEditorTopBar extends StatelessWidget {
  const DeckEditorTopBar({
    super.key,
    required this.deckName,
    required this.totalCards,
    required this.hasChanges,
    required this.onSave,
    required this.onCancel,
    this.saveStatus = SaveStatus.idle,
  });

  final String deckName;
  final int totalCards;
  final bool hasChanges;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final SaveStatus saveStatus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Semantics(
            button: true,
            label: 'Go back',
            child: GestureDetector(
              onTap: onCancel,
              child: const Text(
                '<',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 18,
                  color: TreeColors.textSecondary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              deckName.toUpperCase(),
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.0,
                color: TreeColors.textPrimary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          TreeBadge(
            text: '$totalCards/30',
            color: totalCards >= 30
                ? TreeColors.activation
                : TreeColors.dormant,
          ),
          const SizedBox(width: 8),
          _SaveStatusIndicator(
            saveStatus: saveStatus,
            hasChanges: hasChanges,
            onSave: onSave,
          ),
        ],
      ),
    );
  }
}

class _SaveStatusIndicator extends StatelessWidget {
  const _SaveStatusIndicator({
    required this.saveStatus,
    required this.hasChanges,
    required this.onSave,
  });

  final SaveStatus saveStatus;
  final bool hasChanges;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return switch (saveStatus) {
      SaveStatus.saving => const SizedBox(
        width: 60,
        child: Text(
          'SAVING...',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10,
            letterSpacing: 1.0,
            color: TreeColors.textSecondary,
          ),
        ),
      ),
      SaveStatus.saved when !hasChanges => const SizedBox(
        width: 60,
        child: Text(
          'SAVED',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10,
            letterSpacing: 1.0,
            color: TreeColors.activation,
          ),
        ),
      ),
      SaveStatus.error => TreeButton(
        onPressed: onSave,
        label: 'RETRY',
        variant: TreeButtonVariant.danger,
      ),
      _ =>
        hasChanges
            ? TreeButton(onPressed: onSave, label: 'SAVE')
            : const SizedBox.shrink(),
    };
  }
}
