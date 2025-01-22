import 'package:flutter_chess/chess_board/models/coordinate.dart';
import 'package:flutter_chess/chess_board/models/piece.dart';
import 'package:flutter_chess/chess_board/models/square.dart';

class Knight extends ChessPiece {
  Knight({required super.type, required super.color, required super.currentPosition});
  @override
  ChessPiece copyWith({String? type, String? color, Coordinate? currentPosition}) {
    return Knight(
      type: type ?? this.type,
      color: color ?? this.color,
      currentPosition: currentPosition ?? this.currentPosition,
    );
  }

  @override
  (List<List<SquareData>>, List<Coordinate>) generatePossibleMoves(
    List<List<SquareData>> cleanBoard,
  ) {
    final posibleMoves = <Coordinate>[];
    final posibleSquares = <SquareData>[];

    //Look for northWest Ancor
    final northWestAncor =
        Coordinate(file: currentPosition.file - 1, rank: currentPosition.rank - 1);

    if (northWestAncor.file >= 0 && northWestAncor.rank >= 0) {
      if (northWestAncor.rank - 1 >= 0) {
        posibleSquares.add(cleanBoard[northWestAncor.rank - 1][northWestAncor.file]);
      }
      if (northWestAncor.file - 1 >= 0) {
        posibleSquares.add(cleanBoard[northWestAncor.rank][northWestAncor.file - 1]);
      }
    }

    //Look for northEast Ancor
    final northEastAncor =
        Coordinate(file: currentPosition.file + 1, rank: currentPosition.rank - 1);

    if (northEastAncor.file <= 7 && northEastAncor.rank >= 0) {
      if (northEastAncor.rank - 1 >= 0) {
        posibleSquares.add(cleanBoard[northEastAncor.rank - 1][northEastAncor.file]);
      }
      if (northEastAncor.file + 1 <= 7) {
        posibleSquares.add(cleanBoard[northEastAncor.rank][northEastAncor.file + 1]);
      }
    }

    //Look for southWestAncor Ancor
    final southWestAncor =
        Coordinate(file: currentPosition.file - 1, rank: currentPosition.rank + 1);

    if (southWestAncor.file >= 0 && southWestAncor.rank <= 7) {
      if (southWestAncor.rank + 1 <= 7) {
        posibleSquares.add(cleanBoard[southWestAncor.rank + 1][southWestAncor.file]);
      }
      if (southWestAncor.file - 1 >= 0) {
        posibleSquares.add(cleanBoard[southWestAncor.rank][southWestAncor.file - 1]);
      }
    }

    //Look for southEastAncor Ancor
    final southEastAncor =
        Coordinate(file: currentPosition.file + 1, rank: currentPosition.rank + 1);

    if (southEastAncor.file <= 7 && southEastAncor.rank <= 7) {
      if (southEastAncor.rank + 1 <= 7) {
        posibleSquares.add(cleanBoard[southEastAncor.rank + 1][southEastAncor.file]);
      }
      if (southEastAncor.file + 1 <= 7) {
        posibleSquares.add(cleanBoard[southEastAncor.rank][southEastAncor.file + 1]);
      }
    }

    for (final square in posibleSquares) {
      if (square.piece?.color != color) {
        posibleMoves.add(square.coordinate);
      }
    }

    for (final move in posibleMoves) {
      cleanBoard[move.rank][move.file] = SquareData(
        isHighLighted: true,
        cleanBoard[move.rank][move.file].piece,
        coordinate: cleanBoard[move.rank][move.file].coordinate,
      );
    }
    return (cleanBoard, posibleMoves);
  }
}
