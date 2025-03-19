import 'package:chess_shared/src/models/coordinate.dart';
import 'package:chess_shared/src/models/piece.dart';
import 'package:chess_shared/src/models/square.dart';

/// Creates a grid of [SquareData] objects from the pieces segment of a FEN string.
///
/// [fenPiecesSegment] The pieces segment of a FEN string.
List<List<SquareData>> createSquareGrid(String fenPiecesSegment) {
  final pieceMatrix = <List<SquareData>>[[], [], [], [], [], [], [], []];
  var file = 0;
  var rank = 7;

  for (var index = 0; index < fenPiecesSegment.length; index++) {
    final char = fenPiecesSegment[index];
    if (char == '/') {
      file = 0;
      rank--;
      continue;
    }
    if (int.tryParse(char) != null) {
      for (var num = int.parse(char); num > 0; num--) {
        pieceMatrix[rank].add(
          SquareData(
            null,
            coordinate: Coordinate(file: file, rank: rank),
          ),
        );
        file++;
      }
    } else {
      pieceMatrix[rank].add(
        SquareData(
          createChessPieceFromFen(char),
          coordinate: Coordinate(file: file, rank: rank),
        ),
      );
      file++;
    }
  }
  return pieceMatrix;
}

/// Creates a [ChessPiece] object from a FEN character.
///
/// [char] The FEN character representing a chess piece.
ChessPiece createChessPieceFromFen(String char) {
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
