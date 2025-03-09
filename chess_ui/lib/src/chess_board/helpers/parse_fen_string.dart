import '../models/coordinate.dart';
import '../models/piece.dart';
import '../models/square.dart';

///takes in a single square in long algebraic notation and returns a Coordinate Object.
Coordinate? coordinateFromAnSquare(String an) {
  if (an == '-') {
    return null;
  }
  const boardLetters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];
  final file = boardLetters.indexOf(an[0]);
  final rank = int.parse(an[1]) - 1;
  return Coordinate(file: file, rank: rank);
}

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
