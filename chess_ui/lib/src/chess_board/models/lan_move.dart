import 'coordinate.dart';
import 'piece.dart';

class LANMove {
  LANMove({
    required this.chessPiece,
    required this.origin,
    required this.target,
  });
  ChessPiece chessPiece;
  Coordinate origin;
  Coordinate target;

  @override
  String toString() {
    return '${chessPiece.pieceCharacter}${origin.algebraic}${target.algebraic}';
  }
}
