import 'package:flutter_chess/chess_board/models/coordinate.dart';
import 'package:flutter_chess/chess_board/models/piece.dart';
import 'package:flutter_chess/chess_board/models/square.dart';

class Rook extends ChessPiece {
  Rook({required super.type, required super.color, required super.currentPosition});
  @override
  ChessPiece copyWith({String? type, String? color, Coordinate? currentPosition}) {
    return Rook(
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

    //Looking north
    int rankIndex = currentPosition.rank;
    bool isOccupied = false;
    while (rankIndex > 0 && !isOccupied) {
      rankIndex -= 1;
      final nextSquare = cleanBoard[rankIndex][currentPosition.file];
      if (nextSquare.piece != null) {
        isOccupied = true;
        if (nextSquare.piece?.color != color) {
          posibleSquares.add(nextSquare);
          posibleMoves.add(nextSquare.coordinate);
        }
        continue;
      }

      posibleSquares.add(nextSquare);
      posibleMoves.add(nextSquare.coordinate);
    }

    //Looking South
    rankIndex = currentPosition.rank;
    isOccupied = false;
    while (rankIndex < 7 && !isOccupied) {
      rankIndex += 1;
      final nextSquare = cleanBoard[rankIndex][currentPosition.file];
      if (nextSquare.piece != null) {
        isOccupied = true;
        if (nextSquare.piece?.color != color) {
          posibleSquares.add(nextSquare);
          posibleMoves.add(nextSquare.coordinate);
        }
        continue;
      }

      posibleSquares.add(nextSquare);
      posibleMoves.add(nextSquare.coordinate);
    }

    //Looking west
    int fileIndex = currentPosition.file;
    isOccupied = false;
    while (fileIndex > 0 && !isOccupied) {
      fileIndex -= 1;
      final nextSquare = cleanBoard[currentPosition.rank][fileIndex];
      if (nextSquare.piece != null) {
        isOccupied = true;
        if (nextSquare.piece?.color != color) {
          posibleSquares.add(nextSquare);
          posibleMoves.add(nextSquare.coordinate);
        }
        continue;
      }

      posibleSquares.add(nextSquare);
      posibleMoves.add(nextSquare.coordinate);
    }

    //Looking east
    fileIndex = currentPosition.file;
    isOccupied = false;
    while (fileIndex < 7 && !isOccupied) {
      fileIndex += 1;
      final nextSquare = cleanBoard[currentPosition.rank][fileIndex];
      if (nextSquare.piece != null) {
        isOccupied = true;
        if (nextSquare.piece?.color != color) {
          posibleSquares.add(nextSquare);
          posibleMoves.add(nextSquare.coordinate);
        }
        continue;
      }

      posibleSquares.add(nextSquare);
      posibleMoves.add(nextSquare.coordinate);
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
}
