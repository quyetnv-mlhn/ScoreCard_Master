import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'new_game_event.dart';
part 'new_game_state.dart';

class NewGameBloc extends Bloc<NewGameEvent, NewGameState> {
  NewGameBloc() : super(const NewGameState(playerQuantity: 4)) {
    on<NewGameChangeQuantityPlayer>(_onNewGameChangeQuantityPlayer);
    on<NewGameSelectGameRule>(_onNewGameSelectGameRule);
    on<NewGameUpdateRuleValue>(_onNewGameUpdateRuleValue);
  }

  FutureOr<void> _onNewGameChangeQuantityPlayer(
    NewGameChangeQuantityPlayer event,
    Emitter<NewGameState> emit,
  ) {
    emit(NewGameState(playerQuantity: event.playerQuantity));
  }

  Future<void> _onNewGameSelectGameRule(
    NewGameSelectGameRule event,
    Emitter<NewGameState> emit,
  ) async {
    emit(state.copyWith(gameRule: event.gameRule));
  }

  Future<void> _onNewGameUpdateRuleValue(
    NewGameUpdateRuleValue event,
    Emitter<NewGameState> emit,
  ) async {
    emit(state.copyWith(gameRuleValue: event.value));
  }
}
