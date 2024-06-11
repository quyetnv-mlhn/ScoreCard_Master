import 'dart:async';

import 'package:score_card_master/data/models/score_board_model.dart';
import 'package:score_card_master/domain/repositories/board_game_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc({required this.boardGameRepository}) : super(HistoryInitial()) {
    on<FetchHistoryEvent>(_onFetchHistory);
  }

  final BoardGameRepository boardGameRepository;

  Future<void> _onFetchHistory(
    FetchHistoryEvent event,
    Emitter<HistoryState> emit,
  ) async {
    emit(HistoryLoadInProgress());
    try {
      final games = await boardGameRepository.getAllGames();
      emit(HistoryLoadSuccess(games as List<ScoreBoard>));
    } catch (e) {
      emit(HistoryLoadFailure());
    }
  }
}
