import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show RealtimeChannel;

import '../../models/models.dart';
import '../../services/game_service.dart';

part 'game_board_event.dart';
part 'game_board_state.dart';

/// Full BLoC (not Cubit) for the game board — uses events for action traceability.
class GameBoardBloc extends Bloc<GameBoardEvent, GameBoardState> {
  GameBoardBloc(this._gameService) : super(const GameBoardInitial()) {
    on<LoadGame>(_onLoadGame);
    on<SelectCard>(_onSelectCard);
    on<SelectOperator>(_onSelectOperator);
    on<SelectTarget>(_onSelectTarget);
    on<ConfirmAction>(_onConfirmAction);
    on<CancelAction>(_onCancelAction);
    on<EndTurn>(_onEndTurn);
    on<ConcedeGame>(_onConcedeGame);
    on<ReceiveOpponentAction>(_onReceiveOpponentAction);
    on<GameStateUpdated>(_onGameStateUpdated);
    on<ReconnectGame>(_onReconnectGame);
  }

  final GameService _gameService;
  RealtimeChannel? _gameChannel;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  bool _reconnecting = false;
  bool _wasDisconnected = false;
  String? _currentGameId;

  Future<void> _onLoadGame(LoadGame event, Emitter<GameBoardState> emit) async {
    emit(const GameBoardLoading());
    _currentGameId = event.gameId;
    try {
      final gameState = await _gameService.getGameState(event.gameId);

      // Subscribe to real-time updates
      _gameChannel = _gameService.subscribeToGame(
        event.gameId,
        onGameUpdate: (payload) {
          if (!isClosed) add(GameStateUpdated(payload));
        },
        onActionPerformed: (payload) {
          if (!isClosed) {
            add(ReceiveOpponentAction(GameAction.fromJson(payload)));
          }
        },
      );

      // Subscribe to connectivity changes
      _connectivitySubscription?.cancel();
      _connectivitySubscription =
          Connectivity().onConnectivityChanged.listen((results) {
        if (isClosed) return;
        final hasConnection =
            results.any((r) => r != ConnectivityResult.none);
        if (!hasConnection) {
          _wasDisconnected = true;
        } else if (_wasDisconnected) {
          _wasDisconnected = false;
          add(const ReconnectGame());
        }
      });

      emit(GameBoardLoaded(
        gameState: gameState,
        selection: SelectionState.none,
      ));
    } catch (e) {
      emit(GameBoardError(e.toString()));
    }
  }

  Future<void> _onReconnectGame(
      ReconnectGame event, Emitter<GameBoardState> emit) async {
    if (_reconnecting || _currentGameId == null) return;
    _reconnecting = true;
    try {
      final newState = await _gameService.getGameState(_currentGameId!);

      // Re-subscribe to realtime
      if (_gameChannel != null) {
        await _gameService.unsubscribeFromGame(_gameChannel!);
      }
      _gameChannel = _gameService.subscribeToGame(
        _currentGameId!,
        onGameUpdate: (payload) {
          if (!isClosed) add(GameStateUpdated(payload));
        },
        onActionPerformed: (payload) {
          if (!isClosed) {
            add(ReceiveOpponentAction(GameAction.fromJson(payload)));
          }
        },
      );

      if (newState.game.status == GameStatus.completed) {
        emit(GameBoardGameOver(
          gameState: newState,
          winnerId: newState.game.winnerId,
        ));
      } else {
        emit(GameBoardLoaded(
          gameState: newState,
          selection: SelectionState.none,
        ));
      }
    } catch (e) {
      debugPrint('GameBoardBloc: reconnect failed: $e');
    } finally {
      _reconnecting = false;
    }
  }

  void _onSelectCard(SelectCard event, Emitter<GameBoardState> emit) {
    final current = state;
    if (current is! GameBoardLoaded) return;

    emit(current.copyWith(
      selection: SelectionState.cardSelected(event.card),
    ));
  }

  void _onSelectOperator(SelectOperator event, Emitter<GameBoardState> emit) {
    final current = state;
    if (current is! GameBoardLoaded) return;

    emit(current.copyWith(
      selection: SelectionState.operatorSelected(event.operator),
    ));
  }

  void _onSelectTarget(SelectTarget event, Emitter<GameBoardState> emit) {
    final current = state;
    if (current is! GameBoardLoaded) return;
    final sel = current.selection;

    if (sel is CardSelectedState) {
      emit(current.copyWith(
        selection: SelectionState.targeting(
          sourceCard: sel.card,
          targetPosition: event.position,
        ),
      ));
    } else if (sel is OperatorSelectedState) {
      emit(current.copyWith(
        selection: SelectionState.targeting(
          sourceOperator: sel.operator,
          targetPosition: event.position,
        ),
      ));
    }
  }

  Future<void> _onConfirmAction(
      ConfirmAction event, Emitter<GameBoardState> emit) async {
    final current = state;
    if (current is! GameBoardLoaded) return;
    if (current.isSubmitting) return;
    final sel = current.selection;
    if (sel is! TargetingState) return;

    emit(current.copyWith(
      selection: SelectionState.none,
      isSubmitting: true,
      clearActionError: true,
    ));

    try {
      final action = _buildAction(current.gameState, sel);
      if (action == null) {
        emit(current.copyWith(
          selection: SelectionState.none,
          isSubmitting: false,
        ));
        return;
      }

      final newState = await _gameService.submitAction(
        gameId: current.gameState.game.id,
        action: action,
      );
      emit(GameBoardLoaded(
        gameState: newState,
        selection: SelectionState.none,
      ));
    } catch (e) {
      emit(current.copyWith(
        selection: SelectionState.none,
        isSubmitting: false,
        actionError: e.toString(),
      ));
    }
  }

  void _onCancelAction(CancelAction event, Emitter<GameBoardState> emit) {
    final current = state;
    if (current is! GameBoardLoaded) return;
    emit(current.copyWith(selection: SelectionState.none));
  }

  Future<void> _onConcedeGame(
      ConcedeGame event, Emitter<GameBoardState> emit) async {
    final current = state;
    if (current is! GameBoardLoaded) return;

    try {
      await _gameService.concedeGame(current.gameState.game.id);
      emit(GameBoardGameOver(
        gameState: current.gameState,
        winnerId: current.gameState.opponentPlayerId.isEmpty
            ? null
            : current.gameState.opponentPlayerId,
      ));
    } catch (e) {
      emit(current.copyWith(
        isSubmitting: false,
        actionError: 'Concede failed: ${e.toString()}',
      ));
    }
  }

  Future<void> _onEndTurn(EndTurn event, Emitter<GameBoardState> emit) async {
    final current = state;
    if (current is! GameBoardLoaded) return;
    if (current.isSubmitting) return;

    emit(current.copyWith(isSubmitting: true, clearActionError: true));

    try {
      final action = GameAction(
        gameId: current.gameState.game.id,
        turn: current.gameState.game.currentTurn,
        playerId: current.gameState.myPlayerId,
        type: ActionType.endTurn,
      );
      final newState = await _gameService.submitAction(
        gameId: current.gameState.game.id,
        action: action,
      );
      emit(GameBoardLoaded(
        gameState: newState,
        selection: SelectionState.none,
      ));
    } catch (e) {
      emit(current.copyWith(
        isSubmitting: false,
        actionError: e.toString(),
      ));
    }
  }

  Future<void> _onReceiveOpponentAction(
      ReceiveOpponentAction event, Emitter<GameBoardState> emit) async {
    final current = state;
    if (current is! GameBoardLoaded) return;

    // Reload full game state to get the updated board
    try {
      final newState =
          await _gameService.getGameState(current.gameState.game.id);

      if (newState.game.status == GameStatus.completed) {
        emit(GameBoardGameOver(
          gameState: newState,
          winnerId: newState.game.winnerId,
        ));
      } else {
        emit(GameBoardLoaded(
          gameState: newState,
          selection: SelectionState.none,
          lastOpponentAction: event.action,
        ));
      }
    } catch (e) {
      debugPrint('GameBoardBloc: opponent action reload failed: $e');
    }
  }

  void _onGameStateUpdated(
      GameStateUpdated event, Emitter<GameBoardState> emit) {
    // Handle direct game table updates (e.g., status change)
    final current = state;
    if (current is! GameBoardLoaded) return;

    final updatedGame = Game.fromJson(event.payload);
    if (updatedGame.status == GameStatus.completed) {
      emit(GameBoardGameOver(
        gameState: current.gameState.copyWith(game: updatedGame),
        winnerId: updatedGame.winnerId,
      ));
    }
  }

  GameAction? _buildAction(ClientGameState gameState, TargetingState sel) {
    if (sel.sourceCard != null) {
      return GameAction(
        gameId: gameState.game.id,
        turn: gameState.game.currentTurn,
        playerId: gameState.myPlayerId,
        type: ActionType.playCard,
        source: ActionSource(type: 'card', id: sel.sourceCard!.id),
        target: sel.targetPosition != null
            ? ActionTarget(
                type: 'turnpoint',
                id: '${sel.targetPosition!.stream}:${sel.targetPosition!.centuryIndex}',
                position: sel.targetPosition!.toJson(),
              )
            : null,
      );
    }
    if (sel.sourceOperator != null) {
      return GameAction(
        gameId: gameState.game.id,
        turn: gameState.game.currentTurn,
        playerId: gameState.myPlayerId,
        type: ActionType.move,
        source: ActionSource(
          type: 'operator',
          id: sel.sourceOperator!.instanceId ?? sel.sourceOperator!.operatorCardId,
          position: sel.sourceOperator!.position.toJson(),
        ),
        target: sel.targetPosition != null
            ? ActionTarget(
                type: 'turnpoint',
                id: '${sel.targetPosition!.stream}:${sel.targetPosition!.centuryIndex}',
                position: sel.targetPosition!.toJson(),
              )
            : null,
      );
    }
    return null;
  }

  @override
  Future<void> close() async {
    if (_gameChannel != null) {
      await _gameService.unsubscribeFromGame(_gameChannel!);
    }
    await _connectivitySubscription?.cancel();
    return super.close();
  }
}
