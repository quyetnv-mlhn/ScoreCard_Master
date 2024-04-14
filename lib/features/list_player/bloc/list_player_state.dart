part of 'list_player_bloc.dart';

sealed class ListPlayerState extends Equatable {
  const ListPlayerState();
}

final class ListPlayerInitial extends ListPlayerState {
  @override
  List<Object> get props => [];
}
