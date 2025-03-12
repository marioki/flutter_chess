part of 'game_bloc.dart';

class GameState extends Equatable {
  const GameState(this.fen);

  final String fen;

  @override
  List<Object?> get props => [fen];
}
