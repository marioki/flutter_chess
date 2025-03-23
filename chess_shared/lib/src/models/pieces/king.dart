import 'package:chess_shared/chess_shared.dart';

/// Represents a King chess piece.
///
/// The King can move one square in any direction (horizontally, vertically, or diagonally),
/// as long as the destination square is not occupied by a piece of the same side.
class King extends ChessPiece {
  /// Creates a [King] chess piece with the given [side].
  ///
  /// [side] determines whether the King belongs to the white or black side.
  King({required super.side});

  /// Calculates all potential moves for the King from the given [originCoordinate].
  ///
  /// [gamePosition] The current state of the chess board.
  /// [originCoordinate] The coordinate of the King on the board.
  ///
  /// Returns a list of [Coordinate] objects representing all valid moves
  /// the King can make. The King can move one square in any direction
  /// (north, south, east, west, or diagonally). It cannot move to a square
  /// occupied by a piece of the same side.
  @override
  List<Coordinate> getPotientialTargetCoordinate(GamePosition gamePosition, Coordinate originCoordinate) {
    final posibleMoves = <Coordinate>[];
    final board = gamePosition.squareGrid;

    SquareData? north;
    SquareData? south;
    SquareData? west;
    SquareData? east;
    SquareData? northWest;
    SquareData? northEast;
    SquareData? southWest;
    SquareData? southEast;

    // Look north
    if (originCoordinate.rank > 0) {
      north = board[originCoordinate.rank - 1][originCoordinate.file];
    }
    // Look south
    if (originCoordinate.rank < 7) {
      south = board[originCoordinate.rank + 1][originCoordinate.file];
    }
    // Look west
    if (originCoordinate.file > 0) {
      west = board[originCoordinate.rank][originCoordinate.file - 1];
    }
    // Look east
    if (originCoordinate.file < 7) {
      east = board[originCoordinate.rank][originCoordinate.file + 1];
    }
    // Look northWest
    if (originCoordinate.rank > 0 && originCoordinate.file > 0) {
      northWest = board[originCoordinate.rank - 1][originCoordinate.file - 1];
    }
    // Look northEast
    if (originCoordinate.rank > 0 && originCoordinate.file < 7) {
      northEast = board[originCoordinate.rank - 1][originCoordinate.file + 1];
    }
    // Look southWest
    if (originCoordinate.rank < 7 && originCoordinate.file > 0) {
      southWest = board[originCoordinate.rank + 1][originCoordinate.file - 1];
    }
    // Look southEast
    if (originCoordinate.rank < 7 && originCoordinate.file < 7) {
      southEast = board[originCoordinate.rank + 1][originCoordinate.file + 1];
    }

    // Add valid moves if the destination square is empty or occupied by an opponent's piece
    if (north != null && north.piece?.side != side) {
      posibleMoves.add(north.coordinate);
    }
    if (south != null && south.piece?.side != side) {
      posibleMoves.add(south.coordinate);
    }
    if (west != null && west.piece?.side != side) {
      posibleMoves.add(west.coordinate);
    }
    if (east != null && east.piece?.side != side) {
      posibleMoves.add(east.coordinate);
    }
    if (northWest != null && northWest.piece?.side != side) {
      posibleMoves.add(northWest.coordinate);
    }
    if (northEast != null && northEast.piece?.side != side) {
      posibleMoves.add(northEast.coordinate);
    }
    if (southWest != null && southWest.piece?.side != side) {
      posibleMoves.add(southWest.coordinate);
    }
    if (southEast != null && southEast.piece?.side != side) {
      posibleMoves.add(southEast.coordinate);
    }

    return posibleMoves;
  }
  
  @override
  String getSingleCharRepresentation() {
    return 'K';
  }
}
