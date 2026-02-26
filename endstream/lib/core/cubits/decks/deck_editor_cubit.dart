import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/models.dart';
import '../../services/card_service.dart';
import '../../services/deck_service.dart';

part 'deck_editor_state.dart';

class DeckEditorCubit extends Cubit<DeckEditorState> {
  DeckEditorCubit({
    required DeckService deckService,
    required CardService cardService,
  })  : _deckService = deckService,
        _cardService = cardService,
        super(const DeckEditorInitial());

  final DeckService _deckService;
  final CardService _cardService;

  /// Load a deck and the full card collection for editing.
  Future<void> loadDeck(String deckId) async {
    emit(const DeckEditorLoading());
    try {
      final deck = await _deckService.getDeck(deckId);
      final allCards = await _cardService.getAllCards();
      emit(DeckEditorLoaded(
        deck: deck,
        allCards: allCards,
        hasUnsavedChanges: false,
      ));
    } catch (e) {
      emit(DeckEditorError(e.toString()));
    }
  }

  /// Add a card to the deck.
  void addCard(String cardId) {
    final current = state;
    if (current is! DeckEditorLoaded) return;

    final cards = List<DeckCard>.from(current.deck.cards);
    final existing = cards.indexWhere((c) => c.cardId == cardId);

    if (existing >= 0) {
      if (cards[existing].quantity < 2) {
        cards[existing] = cards[existing].copyWith(
          quantity: cards[existing].quantity + 1,
        );
      }
    } else {
      cards.add(DeckCard(cardId: cardId));
    }

    emit(current.copyWith(
      deck: current.deck.copyWith(cards: cards),
      hasUnsavedChanges: true,
    ));
  }

  /// Remove a card from the deck.
  void removeCard(String cardId) {
    final current = state;
    if (current is! DeckEditorLoaded) return;

    final cards = List<DeckCard>.from(current.deck.cards);
    final existing = cards.indexWhere((c) => c.cardId == cardId);

    if (existing >= 0) {
      if (cards[existing].quantity > 1) {
        cards[existing] = cards[existing].copyWith(
          quantity: cards[existing].quantity - 1,
        );
      } else {
        cards.removeAt(existing);
      }
    }

    emit(current.copyWith(
      deck: current.deck.copyWith(cards: cards),
      hasUnsavedChanges: true,
    ));
  }

  /// Save the deck to the server.
  Future<void> saveDeck() async {
    final current = state;
    if (current is! DeckEditorLoaded) return;

    try {
      final updated = await _deckService.updateDeck(
        current.deck.id,
        current.deck.cards,
      );
      emit(current.copyWith(deck: updated, hasUnsavedChanges: false));
    } catch (e) {
      emit(DeckEditorError(e.toString()));
    }
  }

  /// Total card count in the deck.
  int get totalCards {
    final current = state;
    if (current is! DeckEditorLoaded) return 0;
    return current.deck.cards.fold(0, (sum, c) => sum + c.quantity);
  }
}
