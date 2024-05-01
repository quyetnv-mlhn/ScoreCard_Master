import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'game_result_event.dart';
part 'game_result_state.dart';

class GameResultBloc extends Bloc<GameResultEvent, GameResultState> {
  GameResultBloc() : super(GameResultInitial()) {
    on<GameResultEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
