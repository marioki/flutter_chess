import 'package:chess_shared/src/models/coordinate.dart';
import 'package:chess_shared/src/models/pieces/pawn.dart';
import 'package:chess_shared/src/models/piece.dart';
import 'package:chess_shared/src/models/pieces/pieces.dart';
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
/// Throws an [ArgumentError] if the character is not a valid FEN piece.
ChessPiece createChessPieceFromFen(String char) {
  switch (char) {
    case 'p':
      return Pawn(side: Side.black);
    case 'r':
      return Rook(side: Side.black);
    case 'n':
      return Knight(side: Side.black);
    case 'b':
      return Bishop(side: Side.black);
    case 'q':
      return Queen(side: Side.black);
    case 'k':
      return King(side: Side.black);
    case 'P':
      return Pawn(side: Side.white);
    case 'R':
      return Rook(side: Side.white);
    case 'N':
      return Knight(side: Side.white);
    case 'B':
      return Bishop(side: Side.white);
    case 'Q':
      return Queen(side: Side.white);
    case 'K':
      return King(side: Side.white);
    default:
      throw ArgumentError('Invalid FEN character: $char');
  }
}
