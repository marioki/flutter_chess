import 'package:flutter_chess/chess_board/models/coordinate.dart';
import 'package:flutter_chess/chess_board/models/piece.dart';
import 'package:flutter_chess/chess_board/widgets/board_square.dart';

class LANMove {
  LANMove({
    required this.pieceType,
    required this.origin,
    required this.target,
  });

  PieceType pieceType;
  Coordinate origin;
  Coordinate target;

  @override
  String toString() {
    return '${pieceCharacterFromType(pieceType)}${origin.algebraic}${target.algebraic}';
  }
}
