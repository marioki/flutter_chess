// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'game_bloc.dart';

class GameState extends Equatable {
  const GameState({
    required this.fen,
    required this.gameStatus,
    this.possibleMoves = const [],
  });

  final String fen;
  final List<String> possibleMoves;
  final GameStatus gameStatus;

  @override
  List<Object?> get props => [fen, possibleMoves, gameStatus];

  GameState copyWith({
    String? fen,
    List<String>? possibleMoves,
    GameStatus? gameStatus,
  }) {
    return GameState(
      fen: fen ?? this.fen,
      possibleMoves: possibleMoves ?? this.possibleMoves,
      gameStatus: gameStatus ?? this.gameStatus,
    );
  }
}
