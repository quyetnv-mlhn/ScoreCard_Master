import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'list_player_event.dart';
part 'list_player_state.dart';

class ListPlayerBloc extends Bloc<ListPlayerEvent, ListPlayerState> {
  ListPlayerBloc() : super(ListPlayerInitial()) {
    on<ListPlayerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
