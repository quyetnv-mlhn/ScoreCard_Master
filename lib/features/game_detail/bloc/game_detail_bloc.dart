import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'game_detail_event.dart';
part 'game_detail_state.dart';

class GameDetailBloc extends Bloc<GameDetailEvent, GameDetailState> {
  GameDetailBloc() : super(GameDetailInitial()) {
    on<GameDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
