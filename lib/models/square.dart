import 'package:flutter_chess/models/coordinate.dart';
import 'package:flutter_chess/models/piece.dart';

class SquareData {
  SquareData(
    this.piece, {
    required this.coordinate,
    this.isHighLighted = false,
  });
  final Coordinate coordinate;
  final bool isHighLighted;
  final Piece? piece;
}
