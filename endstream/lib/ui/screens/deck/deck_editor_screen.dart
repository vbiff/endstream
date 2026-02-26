import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../../../core/cubits/decks/deck_editor_cubit.dart';
import '../../../core/models/models.dart';
import '../../components/components.dart';
import '../../overlays/card_detail_overlay.dart';
import '../shared/shared.dart';
import 'deck_editor_collection_grid.dart';
import 'deck_editor_contents_grid.dart';
import 'deck_editor_filter_bar.dart';
import 'deck_editor_top_bar.dart';

/// Deck editor screen with split layout: deck contents and card collection.
class DeckEditorScreen extends StatefulWidget {
  const DeckEditorScreen({super.key, required this.deckId});

  final String deckId;

  @override
  State<DeckEditorScreen> createState() => _DeckEditorScreenState();
}

class _DeckEditorScreenState extends State<DeckEditorScreen> {
  final _searchController = TextEditingController();
  CardType? _selectedFilterType;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showCardDetail(GameCard card) {
    showDialog(
      context: context,
      builder: (_) => CardDetailOverlay(
        card: card,
        onClose: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<DeckEditorCubit, DeckEditorState>(
          builder: (context, state) {
            if (state is DeckEditorLoading || state is DeckEditorInitial) {
              return const ScreenLoadingIndicator();
            }
            if (state is DeckEditorError) {
              return ScreenErrorDisplay(
                message: state.message,
                onRetry: () => context
                    .read<DeckEditorCubit>()
                    .loadDeck(widget.deckId),
              );
            }
            if (state is DeckEditorLoaded) {
              return _DeckEditorBody(
                state: state,
                searchController: _searchController,
                selectedFilterType: _selectedFilterType,
                onSearchChanged: (query) {
                  setState(() {});
                  context.read<DeckEditorCubit>().setSearchQuery(query);
                },
                onTypeSelected: (type) {
                  setState(() => _selectedFilterType = type);
                  context.read<DeckEditorCubit>().setFilterType(type);
                },
                onCardTap: _showCardDetail,
                onCancel: () => context.pop(),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _DeckEditorBody extends StatelessWidget {
  const _DeckEditorBody({
    required this.state,
    required this.searchController,
    required this.selectedFilterType,
    required this.onSearchChanged,
    required this.onTypeSelected,
    required this.onCardTap,
    required this.onCancel,
  });

  final DeckEditorLoaded state;
  final TextEditingController searchController;
  final CardType? selectedFilterType;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<CardType?> onTypeSelected;
  final ValueChanged<GameCard> onCardTap;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DeckEditorCubit>();

    return Column(
      children: [
        DeckEditorTopBar(
          deckName: state.deck.name,
          totalCards: state.totalCards,
          hasChanges: state.hasUnsavedChanges,
          saveStatus: state.saveStatus,
          onSave: cubit.saveDeck,
          onCancel: onCancel,
        ),
        if (state.hasValidationErrors)
          _ValidationErrorBanner(errors: state.validationErrors),
        const TreeDivider(),
        Expanded(
          flex: 2,
          child: DeckEditorContentsGrid(
            deckCards: state.deck.cards,
            allCards: state.allCards,
            onRemove: cubit.removeCard,
            onCardTap: onCardTap,
          ),
        ),
        const TreeDivider(),
        const SizedBox(height: 8),
        DeckEditorFilterBar(
          searchController: searchController,
          selectedType: selectedFilterType,
          onSearchChanged: onSearchChanged,
          onTypeSelected: onTypeSelected,
        ),
        const SizedBox(height: 8),
        Expanded(
          flex: 3,
          child: DeckEditorCollectionGrid(
            cards: state.filteredCards,
            onAdd: cubit.addCard,
            onCardTap: onCardTap,
          ),
        ),
      ],
    );
  }
}

class _ValidationErrorBanner extends StatelessWidget {
  const _ValidationErrorBanner({required this.errors});

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: TreeColors.error.withValues(alpha: 0.15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: errors
            .map((e) => Text(
                  e,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: TreeColors.error,
                      ),
                ))
            .toList(),
      ),
    );
  }
}
