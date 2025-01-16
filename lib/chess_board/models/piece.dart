// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_chess/chess_board/models/coordinate.dart';

class Piece {
  Piece({
    required this.type,
    required this.color,
    required this.currentPosition,
  });
  final String type;
  final String color;
  final Coordinate currentPosition;

  Piece copyWith({
    String? type,
    String? color,
    Coordinate? currentPosition,
  }) {
    return Piece(
      type: type ?? this.type,
      color: color ?? this.color,
      currentPosition: currentPosition ?? this.currentPosition,
    );
  }
}
