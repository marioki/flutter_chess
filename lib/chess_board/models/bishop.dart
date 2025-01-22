import 'dart:math';

import 'package:flutter_chess/chess_board/models/coordinate.dart';
import 'package:flutter_chess/chess_board/models/piece.dart';
import 'package:flutter_chess/chess_board/models/square.dart';

class Bishop extends ChessPiece {
  Bishop({required super.type, required super.color, required super.currentPosition});

  @override
  (List<List<SquareData>>, List<Coordinate>) generatePossibleMoves(
    List<List<SquareData>> cleanBoard,
  ) {
    /**
     * I think this code can be smaller and cleaner by reusing the looking function with vectors to define directions.
     * It may be worth it to research that later.
     */

    final northWest = <SquareData>[];
    final northEast = <SquareData>[];
    final southWest = <SquareData>[];
    final southEast = <SquareData>[];
    final posibleMoves = <Coordinate>[];

    //Looking northWest
    if (currentPosition.rank > 0 && currentPosition.file > 0) {
      int smallestIndex = min(currentPosition.file, currentPosition.rank);
      int counter = 0;
      bool isOccupied = false;
      while (smallestIndex > 0 && !isOccupied) {
        counter += 1;
        smallestIndex -= 1;
        final nextSquare = cleanBoard[(currentPosition.rank - counter).clamp(0, 7)]
            [(currentPosition.file - counter).clamp(0, 7)];

        if (nextSquare.piece != null) {
          isOccupied = true;
          if (nextSquare.piece?.color != color) {
            northWest.add(nextSquare);
            posibleMoves.add(nextSquare.coordinate);
          }
          continue;
        }

        northWest.add(nextSquare);
        posibleMoves.add(nextSquare.coordinate);
      }
    }

    //Looking northEast
    if (currentPosition.rank > 0 && currentPosition.file < 7) {
      int fileIndex = currentPosition.file;
      int rankIndex = currentPosition.rank;
      int counter = 0;
      bool isOccupied = false;
      while (rankIndex > 0 && fileIndex < 7 && !isOccupied) {
        counter += 1;
        fileIndex += 1;
        rankIndex -= 1;
        final nextSquare = cleanBoard[(currentPosition.rank - counter).clamp(0, 7)]
            [(currentPosition.file + counter).clamp(0, 7)];

        if (nextSquare.piece != null) {
          isOccupied = true;
          if (nextSquare.piece?.color != color) {
            northEast.add(nextSquare);
            posibleMoves.add(nextSquare.coordinate);
          }
          continue;
        }

        northEast.add(nextSquare);
        posibleMoves.add(nextSquare.coordinate);
      }
    }
    //Looking southWest
    if (currentPosition.rank < 7 && currentPosition.file > 0) {
      int fileIndex = currentPosition.file;
      int rankIndex = currentPosition.rank;
      int counter = 0;
      bool isOccupied = false;
      while (fileIndex > 0 && rankIndex < 7 && !isOccupied) {
        counter += 1;
        fileIndex -= 1;
        rankIndex += 1;
        final nextSquare = cleanBoard[(currentPosition.rank + counter).clamp(0, 7)]
            [(currentPosition.file - counter).clamp(0, 7)];

        if (nextSquare.piece != null) {
          isOccupied = true;
          if (nextSquare.piece?.color != color) {
            southWest.add(nextSquare);
            posibleMoves.add(nextSquare.coordinate);
          }
          continue;
        }

        southWest.add(nextSquare);
        posibleMoves.add(nextSquare.coordinate);
      }
    }

    //Looking southEast
    if (currentPosition.rank < 7 && currentPosition.file < 7) {
      int fileIndex = currentPosition.file;
      int rankIndex = currentPosition.rank;
      int counter = 0;
      bool isOccupied = false;
      while (fileIndex < 7 && rankIndex < 7 && !isOccupied) {
        counter += 1;
        fileIndex += 1;
        rankIndex += 1;
        final nextSquare = cleanBoard[(currentPosition.rank + counter).clamp(0, 7)]
            [(currentPosition.file + counter).clamp(0, 7)];

        if (nextSquare.piece != null) {
          isOccupied = true;
          if (nextSquare.piece?.color != color) {
            southEast.add(nextSquare);
            posibleMoves.add(nextSquare.coordinate);
          }
          continue;
        }

        southEast.add(nextSquare);
        posibleMoves.add(nextSquare.coordinate);
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
    return Bishop(
      type: type ?? this.type,
      color: color ?? this.color,
      currentPosition: currentPosition ?? this.currentPosition,
    );
  }
}
