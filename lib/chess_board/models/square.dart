// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_chess/chess_board/models/coordinate.dart';
import 'package:flutter_chess/chess_board/models/piece.dart';

class SquareData {
  SquareData(
    this.piece, {
    required this.coordinate,
    this.isHighLighted = false,
    this.enPassant = false,
  });
  final Coordinate coordinate;
  final bool isHighLighted;
  final ChessPiece? piece;
  final bool enPassant;

  SquareData copyWith({
    Coordinate? coordinate,
    bool? isHighLighted,
    ChessPiece? piece,
    bool? enPassant,
  }) {
    return SquareData(
      piece ?? this.piece,
      coordinate: coordinate ?? this.coordinate,
      isHighLighted: isHighLighted ?? this.isHighLighted,
      enPassant: enPassant ?? this.enPassant,
    );
  }

  @override
  String toString() {
    return piece?.type ?? '[$enPassant]';
  }
}
