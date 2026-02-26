part of 'deck_list_cubit.dart';

sealed class DeckListState extends Equatable {
  const DeckListState();

  @override
  List<Object?> get props => [];
}

final class DeckListInitial extends DeckListState {
  const DeckListInitial();
}

final class DeckListLoading extends DeckListState {
  const DeckListLoading();
}

final class DeckListLoaded extends DeckListState {
  const DeckListLoaded(this.decks);
  final List<Deck> decks;

  @override
  List<Object?> get props => [decks];
}

final class DeckListError extends DeckListState {
  const DeckListError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
