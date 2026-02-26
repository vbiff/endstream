import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cubits/decks/deck_list_cubit.dart';
import '../../components/components.dart';
import '../shared/shared.dart';

/// Deck selector showing the player's valid decks.
class NewGameDeckSelector extends StatelessWidget {
  const NewGameDeckSelector({
    super.key,
    required this.selectedDeckId,
    required this.onSelected,
  });

  final String? selectedDeckId;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeckListCubit, DeckListState>(
      builder: (context, state) {
        if (state is DeckListLoading || state is DeckListInitial) {
          return const ScreenLoadingIndicator();
        }
        if (state is DeckListError) {
          return ScreenErrorDisplay(
            message: state.message,
            onRetry: () => context.read<DeckListCubit>().loadDecks(),
          );
        }
        if (state is DeckListLoaded) {
          if (state.decks.isEmpty) {
            return const ScreenEmptyDisplay(message: 'No decks available');
          }
          return Column(
            children: state.decks.map((deck) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: DeckSlot(
                  name: deck.name,
                  cardCount: deck.cards.length,
                  isValid: deck.isValid,
                  onTap: () => onSelected(deck.id),
                ),
              );
            }).toList(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
