import 'package:chess_ui/src/chess_board/models/coordinate.dart';
import 'package:chess_ui/src/chess_board/models/piece.dart';
import 'package:chess_ui/src/chess_board/models/square.dart';

/// Creates a grid of [SquareData] objects from the pieces segment of a FEN string.
///
/// [piecesSegment] The pieces segment of a FEN string.
List<List<SquareData>> createSquareGrid(String piecesSegment) {
  final pieceMatrix = <List<SquareData>>[[], [], [], [], [], [], [], []];
  var file = 0;
  var rank = 7;

  for (var index = 0; index < piecesSegment.length; index++) {
    final char = piecesSegment[index];
    if (char == '/') {
      file = 0;
      rank--;
      continue;
    }
    if (int.tryParse(char) != null) {
      for (var num = int.parse(char); num > 0; num--) {
        pieceMatrix[rank].add(SquareData(null, coordinate: Coordinate(file: file, rank: rank)));
        file++;
      }
    } else {
      pieceMatrix[rank].add(
        SquareData(createChessPieceFromFen(char), coordinate: Coordinate(file: file, rank: rank)),
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
      break;
    case 'r':
      color = Side.black;
      type = PieceType.rook;
      break;
    case 'n':
      color = Side.black;
      type = PieceType.knight;
      break;
    case 'b':
      color = Side.black;
      type = PieceType.bishop;
      break;
    case 'q':
      color = Side.black;
      type = PieceType.queen;
      break;
    case 'k':
      color = Side.black;
      type = PieceType.king;
      break;
    case 'P':
      color = Side.white;
      type = PieceType.pawn;
      break;
    case 'R':
      color = Side.white;
      type = PieceType.rook;
      break;
    case 'N':
      color = Side.white;
      type = PieceType.knight;
      break;
    case 'B':
      color = Side.white;
      type = PieceType.bishop;
      break;
    case 'Q':
      color = Side.white;
      type = PieceType.queen;
      break;
    case 'K':
      color = Side.white;
      type = PieceType.king;
      break;
    default:
      color = Side.black;
      type = PieceType.pawn;
  }

  return ChessPiece(color: color, type: type);
}
