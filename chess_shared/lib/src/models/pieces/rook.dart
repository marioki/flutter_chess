import 'package:chess_shared/chess_shared.dart';

/// Represents a Rook chess piece.
///
/// The Rook can move any number of squares horizontally or vertically
/// as long as the path is not blocked by another piece. It cannot move
/// to a square occupied by a piece of the same side but can capture opponent pieces.
class Rook extends ChessPiece {
  /// Creates a [Rook] chess piece with the given [side].
  ///
  /// [side] determines whether the Rook belongs to the white or black side.
  Rook({super.side}) : super(pieceType: PieceType.rook);

  /// Calculates all potential moves for the Rook from the given [originCoordinate].
  ///
  /// [gamePosition] The current state of the chess board.
  /// [originCoordinate] The coordinate of the Rook on the board.
  ///
  /// Returns a list of [Coordinate] objects representing all valid moves
  /// the Rook can make. The Rook moves horizontally or vertically until
  /// it encounters another piece or the edge of the board.
  ///
  /// If the Rook encounters a piece of the same side, it cannot move further
  /// in that direction. If it encounters an opponent's piece, it can capture it
  /// but cannot move beyond that square.
  @override
  List<Coordinate> getPotientialTargetCoordinate(
      GamePosition gamePosition, Coordinate originCoordinate) {
    final board = gamePosition.squareGrid;
    final posibleMoves = <Coordinate>[];
    final posibleSquares = <SquareData>[];

    // Looking north
    int rankIndex = originCoordinate.rank;
    bool isOccupied = false;
    while (rankIndex > 0 && !isOccupied) {
      rankIndex -= 1;
      final nextSquare = board[rankIndex][originCoordinate.file];
      if (nextSquare.piece != null) {
        isOccupied = true;
        if (nextSquare.piece?.side != side) {
          posibleSquares.add(nextSquare);
          posibleMoves.add(nextSquare.coordinate);
        }
        continue;
      }

      posibleSquares.add(nextSquare);
      posibleMoves.add(nextSquare.coordinate);
    }

    // Looking south
    rankIndex = originCoordinate.rank;
    isOccupied = false;
    while (rankIndex < 7 && !isOccupied) {
      rankIndex += 1;
      final nextSquare = board[rankIndex][originCoordinate.file];
      if (nextSquare.piece != null) {
        isOccupied = true;
        if (nextSquare.piece?.side != side) {
          posibleSquares.add(nextSquare);
          posibleMoves.add(nextSquare.coordinate);
        }
        continue;
      }

      posibleSquares.add(nextSquare);
      posibleMoves.add(nextSquare.coordinate);
    }

    // Looking west
    int fileIndex = originCoordinate.file;
    isOccupied = false;
    while (fileIndex > 0 && !isOccupied) {
      fileIndex -= 1;
      final nextSquare = board[originCoordinate.rank][fileIndex];
      if (nextSquare.piece != null) {
        isOccupied = true;
        if (nextSquare.piece?.side != side) {
          posibleSquares.add(nextSquare);
          posibleMoves.add(nextSquare.coordinate);
        }
        continue;
      }

      posibleSquares.add(nextSquare);
      posibleMoves.add(nextSquare.coordinate);
    }

    // Looking east
    fileIndex = originCoordinate.file;
    isOccupied = false;
    while (fileIndex < 7 && !isOccupied) {
      fileIndex += 1;
      final nextSquare = board[originCoordinate.rank][fileIndex];
      if (nextSquare.piece != null) {
        isOccupied = true;
        if (nextSquare.piece?.side != side) {
          posibleSquares.add(nextSquare);
          posibleMoves.add(nextSquare.coordinate);
        }
        continue;
      }

      posibleSquares.add(nextSquare);
      posibleMoves.add(nextSquare.coordinate);
    }

    return posibleMoves;
  }

  @override
  String getSingleCharRepresentation({bool? explicit}) {
    return 'R';
  }
}
