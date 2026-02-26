part of 'deck_editor_cubit.dart';

enum SaveStatus { idle, saving, saved, error }

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
    this.validationErrors = const [],
    this.saveStatus = SaveStatus.idle,
  });

  final Deck deck;
  final List<GameCard> allCards;
  final bool hasUnsavedChanges;
  final CardType? filterType;
  final String? searchQuery;
  final List<String> validationErrors;
  final SaveStatus saveStatus;

  int get totalCards => deck.cards.fold(0, (sum, c) => sum + c.quantity);
  bool get isAtLimit => totalCards >= 30;
  bool get hasValidationErrors => validationErrors.isNotEmpty;

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
    List<String>? validationErrors,
    SaveStatus? saveStatus,
  }) =>
      DeckEditorLoaded(
        deck: deck ?? this.deck,
        allCards: allCards ?? this.allCards,
        hasUnsavedChanges: hasUnsavedChanges ?? this.hasUnsavedChanges,
        filterType: filterType ?? this.filterType,
        searchQuery: searchQuery ?? this.searchQuery,
        validationErrors: validationErrors ?? this.validationErrors,
        saveStatus: saveStatus ?? this.saveStatus,
      );

  @override
  List<Object?> get props =>
      [deck, allCards, hasUnsavedChanges, filterType, searchQuery, validationErrors, saveStatus];
}

final class DeckEditorError extends DeckEditorState {
  const DeckEditorError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
