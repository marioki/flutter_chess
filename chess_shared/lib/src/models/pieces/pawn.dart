import 'package:chess_shared/chess_shared.dart';

class Pawn extends ChessPiece {
  Pawn({required super.side});

  @override
  List<Coordinate> getPotientialTargetCoordinate(GamePosition gamePosition, Coordinate originCoordinate) {
    {
      final posibleMoves = <Coordinate>[];
      final isFirstMove = originCoordinate.rank == 6;
      final board = gamePosition.squareGrid;

      // For White Pawns
      if (side == Side.white && originCoordinate.rank < 1) {
        return [];
      }
      // For Black Pawns
      if (side == Side.black && originCoordinate.rank > 6) {
        return [];
      }

      SquareData? ahead;
      SquareData? ahead2Steps;
      SquareData? diagonalLeft;
      SquareData? diagonalRight;

      //Check ahead
      if (originCoordinate.rank > 0) {
        ahead = board[originCoordinate.rank - 1][originCoordinate.file];
      }

      //Check ahead two steps
      if (isFirstMove) {
        ahead2Steps = board[originCoordinate.rank - 2][originCoordinate.file];
      }

      //Check diagonalLeft
      if (originCoordinate.file > 0) {
        diagonalLeft = board[originCoordinate.rank - 1][originCoordinate.file - 1];
      }
      //Check diagonalRight
      if (originCoordinate.file < 7) {
        diagonalRight = board[originCoordinate.rank - 1][originCoordinate.file + 1];
      }

      if (diagonalLeft?.piece?.side != side) {
        posibleMoves.add(
          Coordinate(
            file: diagonalLeft!.coordinate.file,
            rank: diagonalLeft.coordinate.rank,
          ),
        );
      }

      if (diagonalRight?.piece?.side != side) {
        posibleMoves.add(
          Coordinate(
            file: diagonalRight!.coordinate.file,
            rank: diagonalRight.coordinate.rank,
          ),
        );
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
  String getSingleCharRepresentation() {
    return '';
  }
}
