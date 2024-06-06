part of 'new_game_bloc.dart';

sealed class NewGameEvent extends Equatable {
  const NewGameEvent();
}

class NewGameChangeQuantityPlayer extends NewGameEvent {
  const NewGameChangeQuantityPlayer(this.playerQuantity);
  final int playerQuantity;

  @override
  List<Object> get props => [playerQuantity];
}

class NewGameSelectGameRule extends NewGameEvent {
  const NewGameSelectGameRule(this.gameRule);
  final GameRule gameRule;

  @override
  List<Object> get props => [gameRule];
}

class NewGameUpdateRuleValue extends NewGameEvent {
  const NewGameUpdateRuleValue(this.value);
  final String value;

  @override
  List<Object> get props => [value];
}
