// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_chess/chess_board/widgets/square.dart';
import 'package:flutter_chess/models/piece.dart';

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
                              child: BoardSquare(
                                row: row,
                                col: col,
                                piece: piece,
                                isLight: isLightSquare,
                              ),
                            );
                          }
                          return Expanded(
                            child: BoardSquare(
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
