import 'package:flutter_chess/chess_board/helpers/parse_fen_string.dart';
import 'package:flutter_chess/chess_board/models/coordinate.dart';
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
  factory GameState.fromFEN(String fen) {
    final fenSegments = fen.split(' ');
    final piecesSegment = fenSegments[0];
    final sideToMoveSegment = fenSegments[1];
    final castleSegment = fenSegments[2];
    final enPassantSegment = fenSegments[3];
    final halfMoveClockSegment = fenSegments[4];
    final fullMoveClockSegment = fenSegments[5];

    return GameState(
      pieceMatrix: generatePieceMatrix(piecesSegment),
      sideToMove: sideToMoveSegment == 'w' ? Side.white : Side.black,
      whiteQueenSideCasttle: castleSegment.contains('Q'),
      whiteKingSideCasttle: castleSegment.contains('K'),
      blackQueenSideCasttle: castleSegment.contains('q'),
      blackKingSideCasttle: castleSegment.contains('k'),
      halfMoveClock: int.parse(halfMoveClockSegment),
      fullMoveNumber: int.parse(fullMoveClockSegment),
      enPassant: coordinateFromAnSquare(enPassantSegment),
    );
  }

  Side sideToMove;
  bool whiteQueenSideCasttle;
  bool whiteKingSideCasttle;
  bool blackQueenSideCasttle;
  bool blackKingSideCasttle;
  Coordinate? enPassant;
  int halfMoveClock;
  int fullMoveNumber;
  List<List<SquareData>> pieceMatrix;
}
