part of 'deck_editor_cubit.dart';

sealed class DeckEditorState extends Equatable {
  const DeckEditorState();

  @override
  List<Object?> get props => [];
}

final class DeckEditorInitial extends DeckEditorState {
  const DeckEditorInitial();
}

final class DeckEditorLoading extends DeckEditorState {
  const DeckEditorLoading();
}

final class DeckEditorLoaded extends DeckEditorState {
  const DeckEditorLoaded({
    required this.deck,
    required this.allCards,
    required this.hasUnsavedChanges,
    this.filterType,
    this.searchQuery,
  });

  final Deck deck;
  final List<GameCard> allCards;
  final bool hasUnsavedChanges;
  final CardType? filterType;
  final String? searchQuery;

  int get totalCards => deck.cards.fold(0, (sum, c) => sum + c.quantity);
  bool get isAtLimit => totalCards >= 30;

  List<GameCard> get filteredCards {
    var cards = allCards;
    if (filterType != null) {
      cards = cards.where((c) => c.type == filterType).toList();
    }
    if (searchQuery != null && searchQuery!.isNotEmpty) {
      final query = searchQuery!.toLowerCase();
      cards = cards
          .where((c) => c.name.toLowerCase().contains(query))
          .toList();
    }
    return cards;
  }

  DeckEditorLoaded copyWith({
    Deck? deck,
    List<GameCard>? allCards,
    bool? hasUnsavedChanges,
    CardType? filterType,
    String? searchQuery,
  }) =>
      DeckEditorLoaded(
        deck: deck ?? this.deck,
        allCards: allCards ?? this.allCards,
        hasUnsavedChanges: hasUnsavedChanges ?? this.hasUnsavedChanges,
        filterType: filterType ?? this.filterType,
        searchQuery: searchQuery ?? this.searchQuery,
      );

  @override
  List<Object?> get props =>
      [deck, allCards, hasUnsavedChanges, filterType, searchQuery];
}

final class DeckEditorError extends DeckEditorState {
  const DeckEditorError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
