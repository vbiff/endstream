import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/models.dart';
import '../../services/card_service.dart';

part 'card_collection_state.dart';

class CardCollectionCubit extends Cubit<CardCollectionState> {
  CardCollectionCubit(this._cardService)
      : super(const CardCollectionInitial());

  final CardService _cardService;

  /// Load the full card catalog.
  Future<void> loadCards() async {
    emit(const CardCollectionLoading());
    try {
      final cards = await _cardService.getAllCards();
      emit(CardCollectionLoaded(cards));
    } catch (e) {
      emit(CardCollectionError(e.toString()));
    }
  }
}
