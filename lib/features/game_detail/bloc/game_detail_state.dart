part of 'game_detail_bloc.dart';

sealed class GameDetailState extends Equatable {
  const GameDetailState();
  
  @override
  List<Object> get props => [];
}

final class GameDetailInitial extends GameDetailState {}
