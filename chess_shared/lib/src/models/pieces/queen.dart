import 'package:chess_shared/chess_shared.dart';

/// Represents a Queen chess piece.
///
/// The Queen can move any number of squares in any direction (horizontally, vertically,
/// or diagonally) as long as the path is not blocked by another piece. It cannot move
/// to a square occupied by a piece of the same side but can capture opponent pieces.
class Queen extends ChessPiece {
  /// Creates a [Queen] chess piece with the given [side].
  ///
  /// [side] determines whether the Queen belongs to the white or black side.
  Queen(Side side) : super(pieceType: PieceType.queen, side: side);

  /// Calculates all potential moves for the Queen from the given [originCoordinate].
  ///
  /// [gamePosition] The current state of the chess board.
  /// [originCoordinate] The coordinate of the Queen on the board.
  ///
  /// Returns a list of [Coordinate] objects representing all valid moves
  /// the Queen can make. The Queen combines the movement abilities of the
  /// Rook (horizontal and vertical moves) and the Bishop (diagonal moves).
  ///
  /// The Queen cannot move to a square occupied by a piece of the same side,
  /// but it can capture opponent pieces.
  @override
  List<Coordinate> getPotientialTargetCoordinate(
      GamePosition gamePosition, Coordinate originCoordinate) {
    final posibleMoves = <Coordinate>[];
    final board = gamePosition.squareGrid;

    // Looking north
    int rankIndex = originCoordinate.rank;
    bool isOccupied = false;
    while (rankIndex > 0 && !isOccupied) {
      rankIndex -= 1;
      final nextSquare = board[rankIndex][originCoordinate.file];
      if (nextSquare.piece != null) {
        isOccupied = true;
        if (nextSquare.piece?.side != side) {
          posibleMoves.add(nextSquare.coordinate);
        }
        continue;
      }
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
          posibleMoves.add(nextSquare.coordinate);
        }
        continue;
      }
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
          posibleMoves.add(nextSquare.coordinate);
        }
        continue;
      }
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
          posibleMoves.add(nextSquare.coordinate);
        }
        continue;
      }
      posibleMoves.add(nextSquare.coordinate);
    }

    // Looking northwest
    if (originCoordinate.rank > 0 && originCoordinate.file > 0) {
      int fileIndex = originCoordinate.file;
      int rankIndex = originCoordinate.rank;
      int counter = 0;
      bool isOccupied = false;
      while (fileIndex > 0 && rankIndex > 0 && !isOccupied) {
        counter += 1;
        fileIndex -= 1;
        rankIndex -= 1;
        final nextSquare = board[(originCoordinate.rank - counter).clamp(0, 7)]
            [(originCoordinate.file - counter).clamp(0, 7)];

        if (nextSquare.piece != null) {
          isOccupied = true;
          if (nextSquare.piece?.side != side) {
            posibleMoves.add(nextSquare.coordinate);
          }
          continue;
        }
        posibleMoves.add(nextSquare.coordinate);
      }
    }

    // Looking northeast
    if (originCoordinate.rank > 0 && originCoordinate.file < 7) {
      int fileIndex = originCoordinate.file;
      int rankIndex = originCoordinate.rank;
      int counter = 0;
      bool isOccupied = false;
      while (rankIndex > 0 && fileIndex < 7 && !isOccupied) {
        counter += 1;
        fileIndex += 1;
        rankIndex -= 1;
        final nextSquare = board[(originCoordinate.rank - counter).clamp(0, 7)]
            [(originCoordinate.file + counter).clamp(0, 7)];

        if (nextSquare.piece != null) {
          isOccupied = true;
          if (nextSquare.piece?.side != side) {
            posibleMoves.add(nextSquare.coordinate);
          }
          continue;
        }
        posibleMoves.add(nextSquare.coordinate);
      }
    }

    // Looking southwest
    if (originCoordinate.rank < 7 && originCoordinate.file > 0) {
      int fileIndex = originCoordinate.file;
      int rankIndex = originCoordinate.rank;
      int counter = 0;
      bool isOccupied = false;
      while (fileIndex > 0 && rankIndex < 7 && !isOccupied) {
        counter += 1;
        fileIndex -= 1;
        rankIndex += 1;
        final nextSquare = board[(originCoordinate.rank + counter).clamp(0, 7)]
            [(originCoordinate.file - counter).clamp(0, 7)];

        if (nextSquare.piece != null) {
          isOccupied = true;
          if (nextSquare.piece?.side != side) {
            posibleMoves.add(nextSquare.coordinate);
          }
          continue;
        }
        posibleMoves.add(nextSquare.coordinate);
      }
    }

    // Looking southeast
    if (originCoordinate.rank < 7 && originCoordinate.file < 7) {
      int fileIndex = originCoordinate.file;
      int rankIndex = originCoordinate.rank;
      int counter = 0;
      bool isOccupied = false;
      while (fileIndex < 7 && rankIndex < 7 && !isOccupied) {
        counter += 1;
        fileIndex += 1;
        rankIndex += 1;
        final nextSquare = board[(originCoordinate.rank + counter).clamp(0, 7)]
            [(originCoordinate.file + counter).clamp(0, 7)];

        if (nextSquare.piece != null) {
          isOccupied = true;
          if (nextSquare.piece?.side != side) {
            posibleMoves.add(nextSquare.coordinate);
          }
          continue;
        }
        posibleMoves.add(nextSquare.coordinate);
      }
    }

    return posibleMoves;
  }

  @override
  String getSingleCharRepresentation({bool? explicit}) {
    return 'Q';
  }
}
