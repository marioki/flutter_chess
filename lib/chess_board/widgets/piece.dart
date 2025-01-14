import 'package:flutter/material.dart';
import 'package:flutter_chess/models/piece.dart';

class PieceWidget extends StatelessWidget {
  const PieceWidget({required this.piece, super.key});
  final Piece piece;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/pieces/${piece.color}_${piece.type}.png',
    );
  }
}
