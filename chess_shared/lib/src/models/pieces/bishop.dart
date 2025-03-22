import 'dart:math';

import 'package:chess_shared/chess_shared.dart';

/// Represents a Bishop chess piece.
///
/// The Bishop can move diagonally in any direction (northwest, northeast, southwest, southeast)
/// as long as the path is not blocked by another piece. It cannot move to a square
/// occupied by a piece of the same side, but it can capture an opponent's piece.
class Bishop extends ChessPiece {
  /// Creates a [Bishop] chess piece with the given [side].
  ///
  /// [side] determines whether the Bishop belongs to the white or black side.
  Bishop({required super.side});

  /// Calculates all potential moves for the Bishop from the given [originCoordinate].
  ///
  /// [gamePosition] The current state of the chess board.
  /// [originCoordinate] The coordinate of the Bishop on the board.
  ///
  /// Returns a list of [Coordinate] objects representing all valid moves
  /// the Bishop can make. The Bishop moves diagonally in any direction
  /// until it encounters another piece or the edge of the board.
  ///
  /// If the Bishop encounters a piece of the same side, it cannot move further
  /// in that direction. If it encounters an opponent's piece, it can capture it
  /// but cannot move beyond that square.
  @override
  List<Coordinate> getPotientialTargetCoordinate(GamePosition gamePosition, Coordinate originCoordinate) {
    final board = gamePosition.squareGrid;

    // Lists to store potential moves in each diagonal direction
    final northWest = <SquareData>[];
    final northEast = <SquareData>[];
    final southWest = <SquareData>[];
    final southEast = <SquareData>[];
    final posibleMoves = <Coordinate>[];

    /**
     * I think this code can be smaller and cleaner by reusing the looking
     * function with vectors to define directions.
     * It may be worth it to research that later.
     */

    // Looking northwest
    if (originCoordinate.rank > 0 && originCoordinate.file > 0) {
      int smallestIndex = min(originCoordinate.file, originCoordinate.rank);
      var counter = 0;
      var isOccupied = false;
      while (smallestIndex > 0 && !isOccupied) {
        counter += 1;
        smallestIndex -= 1;
        final nextSquare = board[(originCoordinate.rank - counter).clamp(0, 7)]
            [(originCoordinate.file - counter).clamp(0, 7)];

        if (nextSquare.piece != null) {
          isOccupied = true;
          if (nextSquare.piece?.side != side) {
            northWest.add(nextSquare);
            posibleMoves.add(nextSquare.coordinate);
          }
          continue;
        }

        northWest.add(nextSquare);
        posibleMoves.add(nextSquare.coordinate);
      }
    }

    // Looking northeast
    if (originCoordinate.rank > 0 && originCoordinate.file < 7) {
      var fileIndex = originCoordinate.file;
      var rankIndex = originCoordinate.rank;
      var counter = 0;
      var isOccupied = false;
      while (rankIndex > 0 && fileIndex < 7 && !isOccupied) {
        counter += 1;
        fileIndex += 1;
        rankIndex -= 1;
        final nextSquare = board[(originCoordinate.rank - counter).clamp(0, 7)]
            [(originCoordinate.file + counter).clamp(0, 7)];

        if (nextSquare.piece != null) {
          isOccupied = true;
          if (nextSquare.piece?.side != side) {
            northEast.add(nextSquare);
            posibleMoves.add(nextSquare.coordinate);
          }
          continue;
        }

        northEast.add(nextSquare);
        posibleMoves.add(nextSquare.coordinate);
      }
    }

    // Looking southwest
    if (originCoordinate.rank < 7 && originCoordinate.file > 0) {
      var fileIndex = originCoordinate.file;
      var rankIndex = originCoordinate.rank;
      var counter = 0;
      var isOccupied = false;
      while (fileIndex > 0 && rankIndex < 7 && !isOccupied) {
        counter += 1;
        fileIndex -= 1;
        rankIndex += 1;
        final nextSquare = board[(originCoordinate.rank + counter).clamp(0, 7)]
            [(originCoordinate.file - counter).clamp(0, 7)];

        if (nextSquare.piece != null) {
          isOccupied = true;
          if (nextSquare.piece?.side != side) {
            southWest.add(nextSquare);
            posibleMoves.add(nextSquare.coordinate);
          }
          continue;
        }

        southWest.add(nextSquare);
        posibleMoves.add(nextSquare.coordinate);
      }
    }

    // Looking southeast
    if (originCoordinate.rank < 7 && originCoordinate.file < 7) {
      var fileIndex = originCoordinate.file;
      var rankIndex = originCoordinate.rank;
      var counter = 0;
      var isOccupied = false;
      while (fileIndex < 7 && rankIndex < 7 && !isOccupied) {
        counter += 1;
        fileIndex += 1;
        rankIndex += 1;
        final nextSquare = board[(originCoordinate.rank + counter).clamp(0, 7)]
            [(originCoordinate.file + counter).clamp(0, 7)];

        if (nextSquare.piece != null) {
          isOccupied = true;
          if (nextSquare.piece?.side != side) {
            southEast.add(nextSquare);
            posibleMoves.add(nextSquare.coordinate);
          }
          continue;
        }

        southEast.add(nextSquare);
        posibleMoves.add(nextSquare.coordinate);
      }
    }

    return posibleMoves;
  }

  @override
  String getSingleCharRepresentation() {
    return 'B';
  }
}
