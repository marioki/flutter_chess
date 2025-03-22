import 'package:chess_shared/chess_shared.dart';

/// Represents a Black Pawn chess piece.
///
/// The Black Pawn moves forward one square, or two squares on its first move,
/// as long as the path is not blocked. It captures diagonally and can perform
/// an en passant capture under specific conditions.
class BlackPawn extends ChessPiece {
  /// Creates a [BlackPawn] chess piece with the given [side].
  ///
  /// [side] determines whether the Pawn belongs to the black side.
  BlackPawn({required super.side});

  /// Calculates all potential moves for the Black Pawn from the given [originCoordinate].
  ///
  /// [gamePosition] The current state of the chess board.
  /// [originCoordinate] The coordinate of the Black Pawn on the board.
  ///
  /// Returns a list of [Coordinate] objects representing all valid moves
  /// the Black Pawn can make. The Pawn moves forward one square, or two squares
  /// on its first move, as long as the path is not blocked. It captures diagonally
  /// and can perform an en passant capture under specific conditions.
  @override
  List<Coordinate> getPotientialTargetCoordinate(GamePosition gamePosition, Coordinate originCoordinate) {
    final board = gamePosition.squareGrid;
    final posibleMoves = <Coordinate>[];
    final isFirstMove = originCoordinate.rank == 1;

    // For Black Pawns, if the pawn is already at the last rank, it cannot move.
    if (originCoordinate.rank > 6) {
      return [];
    }

    SquareData? ahead;
    SquareData? ahead2Steps;
    SquareData? diagonalLeft;
    SquareData? diagonalRight;

    // Check the square directly ahead
    if (originCoordinate.rank < 7) {
      ahead = board[originCoordinate.rank + 1][originCoordinate.file];
    }

    // Check the square two steps ahead (only on the first move)
    if (isFirstMove) {
      ahead2Steps = board[originCoordinate.rank + 2][originCoordinate.file];
    }

    // Check the diagonal left square
    if (originCoordinate.file > 0) {
      diagonalLeft = board[originCoordinate.rank + 1][originCoordinate.file - 1];
    }

    // Check the diagonal right square
    if (originCoordinate.file < 7) {
      diagonalRight = board[originCoordinate.rank + 1][originCoordinate.file + 1];
    }

    // Add diagonal left move if it is a valid capture or en passant
    if (diagonalLeft?.piece?.side == Side.white || (diagonalLeft?.enPassant ?? false)) {
      posibleMoves.add(diagonalLeft!.coordinate);
    }

    // Add diagonal right move if it is a valid capture or en passant
    if (diagonalRight?.piece?.side == Side.white || (diagonalRight?.enPassant ?? false)) {
      posibleMoves.add(diagonalRight!.coordinate);
    }

    // Add the square directly ahead if it is empty
    if (ahead?.piece == null) {
      posibleMoves.add(ahead!.coordinate);

      // Add the square two steps ahead if it is empty and the first move
      if (isFirstMove && ahead2Steps?.piece == null) {
        posibleMoves.add(ahead2Steps!.coordinate);
      }
    }

    return posibleMoves;
  }

  @override
  String getSingleCharRepresentation() {
    return '';
  }
}
