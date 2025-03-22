import 'package:chess_shared/chess_shared.dart';

/// Represents the side (color) of a chess piece.
enum Side {
  /// The white side.
  white,

  /// The black side.
  black
}

/// Represents the type of a chess piece.
enum PieceType {
  /// The pawn piece.
  pawn,

  /// The rook piece.
  rook,

  /// The knight piece.
  knight,

  /// The bishop piece.
  bishop,

  /// The queen piece.
  queen,

  /// The king piece.
  king
}

/// Represents a chess piece on the board.
abstract class ChessPiece {
  /// Creates a [ChessPiece] with the given [side].
  ///
  /// [side] determines whether the chess piece belongs to the white or black side.

  ChessPiece({
    required this.side,
  });

  /// The color of the chess piece (e.g., white, black).
  final Side side;

  /// Calculates all potential moves for the chess piece from the given [originCoordinate].
  List<Coordinate> getPotientialTargetCoordinate(
    GamePosition gamePosition,
    Coordinate originCoordinate,
  );

  /// Returns a single-character representation of the chess piece.
  String getSingleCharRepresentation();
}
