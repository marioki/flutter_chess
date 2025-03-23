import 'package:chess_shared/chess_shared.dart';
import 'package:flutter/material.dart';

class PieceWidget extends StatelessWidget {
  const PieceWidget({required this.piece, super.key});
  final ChessPiece piece;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/pieces/${piece.side.name}_${piece.runtimeType}.png',
    );
  }
}
