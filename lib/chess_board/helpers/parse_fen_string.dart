import 'package:flutter_chess/chess_board/models/coordinate.dart';
import 'package:flutter_chess/chess_board/models/game_state.dart';
import 'package:flutter_chess/chess_board/models/piece.dart';
import 'package:flutter_chess/chess_board/models/square.dart';

GameState parseFenString(String fen) {
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
  );
}

List<List<SquareData>> generatePieceMatrix(String piecesSegment) {
  final pieceMatrix = <List<SquareData>>[[], [], [], [], [], [], [], []];
  var file = 0;
  var rank = 0;

  for (var index = 0; index < piecesSegment.length; index++) {
    final char = piecesSegment[index];
    if (char == '/') {
      file = 0;
      rank++;
      continue;
    }
    if (int.tryParse(char) != null) {
      for (var num = int.parse(char); num > 0; num--) {
        pieceMatrix[rank].add(SquareData(null, coordinate: Coordinate(file: file, rank: rank)));
        file++;
      }
    } else {
      pieceMatrix[rank].add(
        SquareData(pieceFromFenCharacter(char), coordinate: Coordinate(file: file, rank: rank)),
      );
      file++;
    }
  }
  return pieceMatrix;
}

ChessPiece pieceFromFenCharacter(String char) {
  Side color;
  PieceType type;

  switch (char) {
    case 'p':
      color = Side.black;
      type = PieceType.pawn;
    case 'r':
      color = Side.black;
      type = PieceType.rook;
    case 'n':
      color = Side.black;
      type = PieceType.knight;
    case 'b':
      color = Side.black;
      type = PieceType.bishop;
    case 'q':
      color = Side.black;
      type = PieceType.queen;
    case 'k':
      color = Side.black;
      type = PieceType.king;
    case 'P':
      color = Side.white;
      type = PieceType.pawn;
    case 'R':
      color = Side.white;
      type = PieceType.rook;
    case 'N':
      color = Side.white;
      type = PieceType.knight;
    case 'B':
      color = Side.white;
      type = PieceType.bishop;
    case 'Q':
      color = Side.white;
      type = PieceType.queen;
    case 'K':
      color = Side.white;
      type = PieceType.king;
    default:
      color = Side.black;
      type = PieceType.pawn;
  }

  return ChessPiece(color: color, type: type);
}
