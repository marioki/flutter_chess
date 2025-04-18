// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'game_bloc.dart';

class GameState extends Equatable {
  const GameState({
    required this.fen,
    required this.gameStatus,
    this.possibleMoves = const [],
    this.promotionMove,
    this.promotionPiece,
  });

  final String fen;
  final List<String> possibleMoves;
  final GameStatus gameStatus;
  final Move? promotionMove;
  final String? promotionPiece;

  @override
  List<Object?> get props => [fen, possibleMoves, gameStatus, promotionMove, promotionPiece];

  GameState copyWith({
    required GameStatus gameStatus,
    String? fen,
    List<String>? possibleMoves,
    Move? promotionMove,
    String? promotionPiece,
  }) {
    return GameState(
      fen: fen ?? this.fen,
      possibleMoves: possibleMoves ?? this.possibleMoves,
      gameStatus: gameStatus,
      promotionMove: promotionMove,
      promotionPiece: promotionPiece,
    );
  }
}
