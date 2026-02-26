import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/models.dart';
import '../../services/deck_service.dart';

part 'deck_list_state.dart';

class DeckListCubit extends Cubit<DeckListState> {
  DeckListCubit(this._deckService) : super(const DeckListInitial());

  final DeckService _deckService;

  /// Load all decks for the current player.
  Future<void> loadDecks() async {
    emit(const DeckListLoading());
    try {
      final decks = await _deckService.getDecks();
      emit(DeckListLoaded(decks));
    } catch (e) {
      emit(DeckListError(e.toString()));
    }
  }

  /// Create a new empty deck.
  Future<Deck?> createDeck(String name) async {
    try {
      final deck = await _deckService.createDeck(name);
      await loadDecks();
      return deck;
    } catch (e) {
      emit(DeckListError(e.toString()));
      return null;
    }
  }

  /// Delete a deck.
  Future<void> deleteDeck(String deckId) async {
    try {
      await _deckService.deleteDeck(deckId);
      await loadDecks();
    } catch (e) {
      emit(DeckListError(e.toString()));
    }
  }

  /// Rename a deck.
  Future<void> renameDeck(String deckId, String name) async {
    try {
      await _deckService.renameDeck(deckId, name);
      await loadDecks();
    } catch (e) {
      emit(DeckListError(e.toString()));
    }
  }

  /// Duplicate a deck.
  Future<void> duplicateDeck(String deckId, String newName) async {
    try {
      await _deckService.duplicateDeck(deckId, newName);
      await loadDecks();
    } catch (e) {
      emit(DeckListError(e.toString()));
    }
  }
}
