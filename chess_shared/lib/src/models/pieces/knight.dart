import 'package:chess_shared/chess_shared.dart';

/// Represents a Knight chess piece.
///
/// The Knight moves in an "L" shape: two squares in one direction and one square
/// perpendicular to that direction. It can jump over other pieces and can capture
/// opponent pieces but cannot move to a square occupied by a piece of the same side.
class Knight extends ChessPiece {
  /// Creates a [Knight] chess piece with the given [side].
  ///
  /// [side] determines whether the Knight belongs to the white or black side.
  Knight({super.side}) : super(pieceType: PieceType.knight);

  /// Calculates all potential moves for the Knight from the given [originCoordinate].
  ///
  /// [gamePosition] The current state of the chess board.
  /// [originCoordinate] The coordinate of the Knight on the board.
  ///
  /// Returns a list of [Coordinate] objects representing all valid moves
  /// the Knight can make. The Knight moves in an "L" shape and can jump over
  /// other pieces.
  @override
  List<Coordinate> getPotientialTargetCoordinate(
      GamePosition gamePosition, Coordinate originCoordinate) {
    final board = gamePosition.squareGrid;
    final posibleMoves = <Coordinate>[];

    const knightMoves = [
      [-2, -1],
      [-2, 1],
      [-1, -2],
      [-1, 2],
      [1, -2],
      [1, 2],
      [2, -1],
      [2, 1],
    ];

    for (final move in knightMoves) {
      final newRank = originCoordinate.rank + move[0];
      final newFile = originCoordinate.file + move[1];

      if (newRank >= 0 && newRank <= 7 && newFile >= 0 && newFile <= 7) {
        final targetSquare = board[newRank][newFile];
        if (targetSquare.piece?.side != side) {
          posibleMoves.add(targetSquare.coordinate);
        }
      }
    }

    return posibleMoves;
  }

  @override
  String getSingleCharRepresentation({bool? explicit}) {
    return 'N';
  }
}
