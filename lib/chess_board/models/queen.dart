import 'package:flutter_chess/chess_board/models/coordinate.dart';
import 'package:flutter_chess/chess_board/models/piece.dart';
import 'package:flutter_chess/chess_board/models/square.dart';

class Queen extends ChessPiece {
  Queen({required super.type, required super.color, required super.currentPosition});
  @override
  ChessPiece copyWith({String? type, String? color, Coordinate? currentPosition}) {
    return Queen(
      type: type ?? this.type,
      color: color ?? this.color,
      currentPosition: currentPosition ?? this.currentPosition,
    );
  }

  @override
  (List<List<SquareData>>, List<Coordinate>) generatePossibleMoves(
    List<List<SquareData>> cleanBoard,
  ) {
    return ([[]], []);
  }
}
