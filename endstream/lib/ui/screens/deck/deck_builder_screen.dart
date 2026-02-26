import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../../../core/cubits/decks/deck_list_cubit.dart';
import '../../../core/models/models.dart';
import '../../components/components.dart';
import '../shared/shared.dart';
import 'deck_builder_create_modal.dart';
import 'deck_builder_detail_panel.dart';
import 'deck_builder_list.dart';

/// Deck builder screen showing deck list and detail panel.
class DeckBuilderScreen extends StatefulWidget {
  const DeckBuilderScreen({super.key});

  @override
  State<DeckBuilderScreen> createState() => _DeckBuilderScreenState();
}

class _DeckBuilderScreenState extends State<DeckBuilderScreen> {
  String? _selectedDeckId;

  void _showCreateModal() {
    showDialog(
      context: context,
      builder: (dialogContext) => DeckBuilderCreateModal(
        onCreate: (name) {
          Navigator.of(dialogContext).pop();
          context.read<DeckListCubit>().createDeck(name);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const _DeckBuilderTopBar(),
            Expanded(
              child: BlocBuilder<DeckListCubit, DeckListState>(
                builder: (context, state) {
                  if (state is DeckListLoading || state is DeckListInitial) {
                    return const ScreenLoadingIndicator();
                  }
                  if (state is DeckListError) {
                    return ScreenErrorDisplay(
                      message: state.message,
                      onRetry: () =>
                          context.read<DeckListCubit>().loadDecks(),
                    );
                  }
                  if (state is DeckListLoaded) {
                    return _DeckBuilderBody(
                      decks: state.decks,
                      selectedDeckId: _selectedDeckId,
                      onSelect: (id) =>
                          setState(() => _selectedDeckId = id),
                      onEdit: (id) => context.push('/decks/$id'),
                      onDuplicate: (deck) => context
                          .read<DeckListCubit>()
                          .duplicateDeck(deck.id, '${deck.name} (copy)'),
                      onDelete: (id) =>
                          context.read<DeckListCubit>().deleteDeck(id),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: TreeButton(
                onPressed: _showCreateModal,
                label: '+ NEW DECK',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeckBuilderTopBar extends StatelessWidget {
  const _DeckBuilderTopBar();

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
            'DECK BUILDER',
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

class _DeckBuilderBody extends StatelessWidget {
  const _DeckBuilderBody({
    required this.decks,
    required this.selectedDeckId,
    required this.onSelect,
    required this.onEdit,
    required this.onDuplicate,
    required this.onDelete,
  });

  final List<Deck> decks;
  final String? selectedDeckId;
  final ValueChanged<String> onSelect;
  final ValueChanged<String> onEdit;
  final ValueChanged<Deck> onDuplicate;
  final ValueChanged<String> onDelete;

  @override
  Widget build(BuildContext context) {
    if (decks.isEmpty) {
      return const ScreenEmptyDisplay(message: 'No decks yet');
    }

    final selected = selectedDeckId != null
        ? decks.where((d) => d.id == selectedDeckId).firstOrNull
        : null;

    return Column(
      children: [
        const SizedBox(height: 8),
        DeckBuilderList(
          decks: decks,
          selectedDeckId: selectedDeckId,
          onSelect: onSelect,
        ),
        const SizedBox(height: 16),
        if (selected != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: DeckBuilderDetailPanel(
              deck: selected,
              onEdit: () => onEdit(selected.id),
              onDuplicate: () => onDuplicate(selected),
              onDelete: () => onDelete(selected.id),
            ),
          ),
      ],
    );
  }
}
