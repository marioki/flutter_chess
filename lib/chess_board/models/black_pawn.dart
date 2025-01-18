import 'package:flutter_chess/chess_board/models/coordinate.dart';
import 'package:flutter_chess/chess_board/models/piece.dart';
import 'package:flutter_chess/chess_board/models/square.dart';

class BlackPawn extends ChessPiece {
  BlackPawn({
    required super.type,
    required super.color,
    required super.currentPosition,
  });

  @override
  (List<List<SquareData>> board, List<Coordinate> moves) generatePossibleMoves(
    List<List<SquareData>> cleanBoard,
  ) {
    final posibleMoves = <Coordinate>[];
    final coordinate = currentPosition;
    final isFirstMove = coordinate.rank == 1;

    // For White Pawns
    if (coordinate.rank > 6) {
      return (cleanBoard, []);
    }

    SquareData? ahead;
    SquareData? ahead2Steps;
    SquareData? diagonalLeft;
    SquareData? diagonalRight;

    //Check ahead
    if (coordinate.rank < 7) {
      ahead = cleanBoard[coordinate.rank + 1][coordinate.file];
    }

    //Check ahead two steps
    if (isFirstMove) {
      ahead2Steps = cleanBoard[coordinate.rank + 2][coordinate.file];
    }

    //Check diagonalLeft
    if (coordinate.file > 0) {
      diagonalLeft = cleanBoard[coordinate.rank + 1][coordinate.file - 1];
    }
    //Check diagonalRight
    if (coordinate.file < 7) {
      diagonalRight = cleanBoard[coordinate.rank + 1][coordinate.file + 1];
    }

    if (diagonalLeft?.piece?.color == 'white') {
      posibleMoves.add(
        Coordinate(
          file: diagonalLeft!.coordinate.file,
          rank: diagonalLeft.coordinate.rank,
        ),
      );
    }

    if (diagonalRight?.piece?.color == 'white') {
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
    //Highlight all possible moves
    for (final move in posibleMoves) {
      cleanBoard[move.rank][move.file] = SquareData(
        isHighLighted: true,
        cleanBoard[move.rank][move.file].piece,
        coordinate: cleanBoard[move.rank][move.file].coordinate,
      );
    }
    return (cleanBoard, posibleMoves);
  }

  @override
  ChessPiece copyWith({String? type, String? color, Coordinate? currentPosition}) {
    return BlackPawn(
      type: type ?? this.type,
      color: color ?? this.color,
      currentPosition: currentPosition ?? this.currentPosition,
    );
  }
}
