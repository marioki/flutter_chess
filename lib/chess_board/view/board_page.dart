// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ChessBoard extends StatelessWidget {
  final List<List<Piece?>> boardState; // 8x8 matrix representing pieces

  ChessBoard({required this.boardState});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(8, (row) {
        return Row(
          children: List.generate(8, (col) {
            final piece = boardState[row][col];
            final isLightSquare = (row + col) % 2 == 0;
            return ChessSquare(
              row: row,
              col: col,
              piece: piece,
              isLight: isLightSquare,
            );
          }),
        );
      }),
    );
  }
}

class ChessSquare extends StatelessWidget {
  final int row;
  final int col;
  final Piece? piece;
  final bool isLight;

  ChessSquare({
    required this.row,
    required this.col,
    required this.piece,
    required this.isLight,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<Piece>(
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: 50,
          height: 50,
          color: isLight ? Colors.brown[300] : Colors.brown[700],
          child: piece != null
              ? Draggable<Piece>(
                  data: piece,
                  feedback: PieceWidget(piece: piece!),
                  childWhenDragging: Container(), // Empty square while dragging
                  child: PieceWidget(piece: piece!),
                )
              : Container(),
        );
      },
      onAccept: (piece) {
        // Handle move validation and state updates here
      },
    );
  }
}

class PieceWidget extends StatelessWidget {
  final Piece piece;

  PieceWidget({required this.piece});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/pieces/Piece=${piece.type}, Side=${piece.color}.png',
      width: 40,
      height: 40,
    );
  }
}

class Piece {
  final String type;
  final String color;

  Piece({
    required this.type,
    required this.color,
  });
}
