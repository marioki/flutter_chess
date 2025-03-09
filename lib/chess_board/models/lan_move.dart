import 'package:flutter_chess/chess_board/models/coordinate.dart';
import 'package:flutter_chess/chess_board/models/piece.dart';

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
