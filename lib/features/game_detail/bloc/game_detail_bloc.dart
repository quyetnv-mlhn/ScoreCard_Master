import 'dart:async';

import 'package:calculate_card_score/data/models/round_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_detail_event.dart';
part 'game_detail_state.dart';

class GameDetailBloc extends Bloc<GameDetailEvent, GameDetailState> {
  GameDetailBloc() : super(const GameDetailInitial(rounds: [])) {
    on<GameDetailAddRound>(_onGameDetailAddRound);
  }

  FutureOr<void> _onGameDetailAddRound(
    GameDetailAddRound event,
    Emitter<GameDetailState> emit,
  ) {
    final rounds = List.of(state.rounds);
    rounds.insert(0, event.round);
    emit(GameDetailAddedRound(rounds: rounds));
  }
}
