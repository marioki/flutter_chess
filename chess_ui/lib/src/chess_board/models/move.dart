import 'package:chess_ui/src/chess_board/models/coordinate.dart';
import 'package:chess_ui/src/chess_board/models/piece.dart';

/// Represents a chess move in Long Algebraic Notation (LAN).
class Move {
  /// Creates a [Move] with the given [chessPiece], [origin], and [target].
  Move({
    required this.chessPiece,
    required this.origin,
    required this.target,
  });

  /// The chess piece being moved.
  final ChessPiece chessPiece;

  /// The origin coordinate of the chess piece.
  final Coordinate origin;

  /// The target coordinate of the chess piece.
  final Coordinate target;

  /// Returns the move in Long Algebraic Notation (LAN).
  String get lan {
    return '${chessPiece.pieceCharacter}${origin.algebraic}${target.algebraic}';
  }

  @override
  String toString() {
    return lan;
  }
}
