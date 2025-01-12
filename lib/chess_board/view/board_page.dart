// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ChessBoard extends StatelessWidget {
  final List<List<Piece?>> boardState;
  const ChessBoard({required this.boardState, super.key});

  List<String> get boardLetters => ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            8,
            (index) => Text(
              (index + 1).toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  boardLetters.length,
                  (index) => Text(
                    boardLetters[index],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Row(
                  children: List.generate(8, (col) {
                    return Expanded(
                      child: Column(
                        children: List.generate(8, (row) {
                          final piece = boardState[row][col];
                          final isLightSquare = (row + col).isEven;
                          if (col == 0 || col == 7) {
                            return Expanded(
                              child: ChessSquare(
                                row: row,
                                col: col,
                                piece: piece,
                                isLight: isLightSquare,
                              ),
                            );
                          }
                          return Expanded(
                            child: ChessSquare(
                              row: row,
                              col: col,
                              piece: piece,
                              isLight: isLightSquare,
                            ),
                          );
                        }),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  boardLetters.length,
                  (index) => Text(
                    boardLetters[index],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            8,
            (index) => Text(
              (index + 1).toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ChessSquare extends StatelessWidget {
  final int row;
  final int col;
  final Piece? piece;
  final bool isLight;

  const ChessSquare({
    required this.row,
    required this.col,
    required this.piece,
    required this.isLight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<Piece>(
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: double.maxFinite,
          color: isLight ? Colors.brown[300] : Colors.brown[700],
          child: piece != null
              ? Draggable<Piece>(
                  data: piece,
                  feedback: PieceWidget(piece: piece!),
                  childWhenDragging: Container(), // Empty square while dragging
                  child: PieceWidget(piece: piece!),
                )
              : Text('$row, $col'),
        );
      },
      onAcceptWithDetails: (piece) {
        // Handle move validation and state updates here
      },
    );
  }
}

class PieceWidget extends StatelessWidget {
  final Piece piece;

  const PieceWidget({required this.piece, super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/pieces/${piece.color}_${piece.type}.png',
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
