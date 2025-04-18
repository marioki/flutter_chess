import 'package:chess_shared/chess_shared.dart';

class Pawn extends ChessPiece {
  Pawn(Side side) : super(pieceType: PieceType.pawn, side: side);

  @override
  List<Coordinate> getPotientialTargetCoordinate(
      GamePosition gamePosition, Coordinate originCoordinate) {
    {
      if (side == Side.white && originCoordinate.rank < 1 ||
          side == Side.white && originCoordinate.rank > 6) {
        return [];
      }
      if (side == Side.black && originCoordinate.rank > 6 ||
          side == Side.black && originCoordinate.rank < 1) {
        return [];
      }

      final posibleMoves = <Coordinate>[];
      final bool isFirstMove;
      final board = gamePosition.squareGrid;
      final int direction;
      SquareData? ahead;
      SquareData? ahead2Steps;
      SquareData? diagonalWest;
      SquareData? diagonalEast;

      if (side == Side.white) {
        isFirstMove = originCoordinate.rank == 1;
        direction = 1;
      } else {
        isFirstMove = originCoordinate.rank == 6;
        direction = -1;
      }

      //Check ahead
      if (originCoordinate.rank > 0) {
        ahead = board[originCoordinate.rank + direction][originCoordinate.file];
      }

      //Check ahead two steps
      if (isFirstMove) {
        ahead2Steps = board[originCoordinate.rank + (direction * 2)][originCoordinate.file];
      }

      //Check diagonalWest
      if (originCoordinate.file > 0) {
        diagonalWest = board[originCoordinate.rank + direction][originCoordinate.file - 1];

        if (diagonalWest.piece?.side != null && diagonalWest.piece?.side != side ||
            diagonalWest.coordinate == gamePosition.enPassant) {
          posibleMoves.add(
            Coordinate(
              file: diagonalWest.coordinate.file,
              rank: diagonalWest.coordinate.rank,
            ),
          );
        }
      }
      //Check diagonalEast
      if (originCoordinate.file < 7) {
        diagonalEast = board[originCoordinate.rank + direction][originCoordinate.file + 1];

        if (diagonalEast.piece?.side != null && diagonalEast.piece?.side != side ||
            diagonalEast.coordinate == gamePosition.enPassant) {
          posibleMoves.add(
            Coordinate(
              file: diagonalEast.coordinate.file,
              rank: diagonalEast.coordinate.rank,
            ),
          );
        }
      }

      if (ahead?.piece == null) {
        posibleMoves.add(
          Coordinate(
            file: ahead!.coordinate.file,
            rank: ahead.coordinate.rank,
          ),
        );

        if (isFirstMove && ahead2Steps!.piece == null) {
          posibleMoves.add(
            Coordinate(
              file: ahead2Steps.coordinate.file,
              rank: ahead2Steps.coordinate.rank,
            ),
          );
        }
      }

      return posibleMoves;
    }
  }

  @override
  String getSingleCharRepresentation({bool? explicit}) {
    return explicit == true ? 'P' : '';
  }
}
