import 'package:chess_shared/chess_shared.dart';
import 'package:chess_shared/src/models/pieces/pieces.dart';

/// Represents a chess move in Long Algebraic Notation (LAN).
class Move {
  /// Creates a [Move] with the given [chessPiece], [origin], and [target].
  Move({
    required this.chessPiece,
    required this.origin,
    required this.target,
  });

  Move.fromCoordinates({
    required this.chessPiece,
    required Coordinate origin,
    required Coordinate target,
  })  : origin = Coordinate(file: origin.file, rank: origin.rank),
        target = Coordinate(file: target.file, rank: target.rank);

  Move.fromLan({
    required String lan,
  })  : chessPiece = lan.length > 4 ? chessPieceFromLanMove(lan[0]) : Pawn(),
        origin = lan.length > 4 ?  Coordinate.fromAlgebraic(lan.substring(1, 3)): Coordinate.fromAlgebraic(lan.substring(0, 2)),
        target = lan.length > 4 ?  Coordinate.fromAlgebraic(lan.substring(3)): Coordinate.fromAlgebraic(lan.substring(2));

  /// The chess piece being moved.
  final ChessPiece chessPiece;

  /// The origin coordinate of the chess piece.
  final Coordinate origin;

  /// The target coordinate of the chess piece.
  final Coordinate target;

  /// Returns the move in Long Algebraic Notation (LAN).
  String get lan {
    return '${chessPiece.getSingleCharRepresentation()}${origin.algebraic}${target.algebraic}';
  }

  @override
  String toString() {
    return lan;
  }
}
