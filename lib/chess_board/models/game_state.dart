import 'package:flutter_chess/chess_board/models/piece.dart';
import 'package:flutter_chess/chess_board/models/square.dart';

class GameState {
  GameState({
    required this.pieceMatrix,
    required this.sideToMove,
    required this.whiteQueenSideCasttle,
    required this.whiteKingSideCasttle,
    required this.blackQueenSideCasttle,
    required this.blackKingSideCasttle,
    required this.halfMoveClock,
    required this.fullMoveNumber,
    this.enPassant,
  });
  Side sideToMove;
  bool whiteQueenSideCasttle;
  bool whiteKingSideCasttle;
  bool blackQueenSideCasttle;
  bool blackKingSideCasttle;
  SquareData? enPassant;
  int halfMoveClock;
  int fullMoveNumber;
  List<List<SquareData>> pieceMatrix;
}
