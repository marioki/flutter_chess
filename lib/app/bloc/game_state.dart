// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'game_bloc.dart';

class GameState extends Equatable {
  const GameState({
    required this.fen,
    required this.gameStatus,
    this.possibleMoves = const [],
    this.winner,
    this.promotionMove,
    this.promotionPiece,
    this.moveHistory = const [],
  });

  final String fen;
  final List<String> possibleMoves;
  final GameStatus gameStatus;
  final Side? winner;
  final Move? promotionMove;
  final String? promotionPiece;
  final List<String> moveHistory;

  @override
  List<Object?> get props => [fen, possibleMoves, gameStatus, promotionMove, promotionPiece];

  GameState copyWith({
    required GameStatus gameStatus,
    Side? winner,
    String? fen,
    List<String>? possibleMoves,
    Move? promotionMove,
    String? promotionPiece,
    List<String>? moveHistory,
  }) {
    return GameState(
      fen: fen ?? this.fen,
      possibleMoves: possibleMoves ?? this.possibleMoves,
      gameStatus: gameStatus,
      winner: winner ?? this.winner,
      promotionMove: promotionMove,
      promotionPiece: promotionPiece,
      moveHistory: moveHistory ?? this.moveHistory,
    );
  }
}
