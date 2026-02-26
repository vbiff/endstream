part of 'card_collection_cubit.dart';

sealed class CardCollectionState extends Equatable {
  const CardCollectionState();

  @override
  List<Object?> get props => [];
}

final class CardCollectionInitial extends CardCollectionState {
  const CardCollectionInitial();
}

final class CardCollectionLoading extends CardCollectionState {
  const CardCollectionLoading();
}

final class CardCollectionLoaded extends CardCollectionState {
  const CardCollectionLoaded(this.cards);
  final List<GameCard> cards;

  List<GameCard> get operators =>
      cards.where((c) => c.type == CardType.operatorCard).toList();

  List<GameCard> get tactics =>
      cards.where((c) => c.type == CardType.tactic).toList();

  List<GameCard> get events =>
      cards.where((c) => c.type == CardType.event).toList();

  List<GameCard> get equipment =>
      cards.where((c) => c.type == CardType.equipment).toList();

  @override
  List<Object?> get props => [cards];
}

final class CardCollectionError extends CardCollectionState {
  const CardCollectionError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
