// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_chess/chess_board/models/coordinate.dart';
import 'package:flutter_chess/chess_board/models/square.dart';

abstract class ChessPiece {
  ChessPiece({
    required this.type,
    required this.color,
    required this.currentPosition,
  });
  final String type;
  final String color;
  final Coordinate currentPosition;

  (List<List<SquareData>> board, List<Coordinate> moves) generatePossibleMoves(
    List<List<SquareData>> cleanBoard,
  );

  ChessPiece copyWith({
    String? type,
    String? color,
    Coordinate? currentPosition,
  });
}
