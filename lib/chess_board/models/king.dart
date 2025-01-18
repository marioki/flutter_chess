import 'package:flutter_chess/chess_board/models/coordinate.dart';
import 'package:flutter_chess/chess_board/models/piece.dart';
import 'package:flutter_chess/chess_board/models/square.dart';

class King extends ChessPiece {
  King({
    required super.type,
    required super.color,
    required super.currentPosition,
  });

  @override
  (List<List<SquareData>>, List<Coordinate>) generatePossibleMoves(
    List<List<SquareData>> cleanBoard,
  ) {
    final posibleMoves = <Coordinate>[];

    SquareData? north;
    SquareData? south;
    SquareData? west;
    SquareData? east;
    SquareData? northWest;
    SquareData? northEast;
    SquareData? southWest;
    SquareData? southEast;

    //Look north
    if (currentPosition.rank > 0) {
      north = cleanBoard[currentPosition.rank - 1][currentPosition.file];
    }
    //Look south
    if (currentPosition.rank < 7) {
      south = cleanBoard[currentPosition.rank + 1][currentPosition.file];
    }

    //Look west
    if (currentPosition.file > 0) {
      west = cleanBoard[currentPosition.rank][currentPosition.file - 1];
    }
    //Look east
    if (currentPosition.file < 7) {
      print('Rank: ${currentPosition.rank} File: ${currentPosition.file}');
      east = cleanBoard[currentPosition.rank][currentPosition.file + 1];
    }

    //Look northWest
    if (currentPosition.rank > 0 && currentPosition.file > 0) {
      //print('Rank: ${currentPosition.rank} File: ${currentPosition.file}');
      northWest = cleanBoard[currentPosition.rank - 1][currentPosition.file - 1];
    }
    //Look northEast
    if (currentPosition.rank > 0 && currentPosition.file < 7) {
      northEast = cleanBoard[currentPosition.rank - 1][currentPosition.file + 1];
    }
    //Look southWest
    if (currentPosition.rank < 7 && currentPosition.file > 0) {
      southWest = cleanBoard[currentPosition.rank + 1][currentPosition.file - 1];
    }
    //Look southEast
    if (currentPosition.rank < 7 && currentPosition.file < 7) {
      southEast = cleanBoard[currentPosition.rank + 1][currentPosition.file + 1];
    }

    if (north != null && north.piece?.color != color) {
      posibleMoves.add(north.coordinate);
    }
    if (south != null && south.piece?.color != color) {
      posibleMoves.add(south.coordinate);
    }

    if (west != null && west.piece?.color != color) {
      posibleMoves.add(west.coordinate);
    }
    if (east != null && east.piece?.color != color) {
      posibleMoves.add(east.coordinate);
    }

    if (northWest != null && northWest.piece?.color != color) {
      posibleMoves.add(northWest.coordinate);
    }
    if (northEast != null && northEast.piece?.color != color) {
      posibleMoves.add(northEast.coordinate);
    }
    if (southWest != null && southWest.piece?.color != color) {
      posibleMoves.add(southWest.coordinate);
    }
    if (southEast != null && southEast.piece?.color != color) {
      posibleMoves.add(southEast.coordinate);
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
    return King(
      type: type ?? this.type,
      color: color ?? this.color,
      currentPosition: currentPosition ?? this.currentPosition,
    );
  }
}
