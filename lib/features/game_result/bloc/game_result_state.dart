part of 'game_result_bloc.dart';

sealed class GameResultState extends Equatable {
  const GameResultState();
  
  @override
  List<Object> get props => [];
}

final class GameResultInitial extends GameResultState {}
