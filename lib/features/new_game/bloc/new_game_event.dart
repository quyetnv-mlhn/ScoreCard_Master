part of 'new_game_bloc.dart';

sealed class NewGameEvent extends Equatable {
  const NewGameEvent();
}

class NewGameChangeQuantityPlayer extends NewGameEvent {
  final int playerQuantity;

  const NewGameChangeQuantityPlayer(this.playerQuantity);

  @override
  List<Object> get props => [playerQuantity];
}

class NewGameSelectGameRule extends NewGameEvent {
  final GameRule gameRule;

  const NewGameSelectGameRule(this.gameRule);

  @override
  List<Object> get props => [gameRule];
}

class NewGameUpdateRuleValue extends NewGameEvent {
  final String value;

  const NewGameUpdateRuleValue(this.value);

  @override
  List<Object> get props => [value];
}
