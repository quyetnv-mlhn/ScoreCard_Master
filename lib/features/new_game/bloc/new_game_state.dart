part of 'new_game_bloc.dart';

enum GameRule { normal, limitGame, limitScore }

extension GameRuleExt on GameRule {
  String get title {
    switch (this) {
      case GameRule.normal:
        return 'Normal rule';
      case GameRule.limitGame:
        return 'Limit number of matches';
      case GameRule.limitScore:
        return 'Limit number of score';
    }
  }
}

final class NewGameState extends Equatable {
  final int playerQuantity;
  final GameRule gameRule;
  final String gameRuleValue;

  const NewGameState({
    required this.playerQuantity,
    this.gameRule = GameRule.normal,
    this.gameRuleValue = '',
  });

  NewGameState copyWith({
    int? playerQuantity,
    GameRule? gameRule,
    String? gameRuleValue,
  }) {
    return NewGameState(
      playerQuantity: playerQuantity ?? this.playerQuantity,
      gameRule: gameRule ?? this.gameRule,
      gameRuleValue: gameRuleValue ?? this.gameRuleValue,
    );
  }

  @override
  List<Object> get props => [playerQuantity, gameRule, gameRuleValue];
}
