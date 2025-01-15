// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_chess/chess_board/widgets/board_square.dart';
import 'package:flutter_chess/models/square.dart';

class ChessBoard extends StatelessWidget {
  final List<List<SquareData>> boardSquares;

  const ChessBoard({
    required this.boardSquares,
    super.key,
  });

  List<String> get boardLetters => ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //Building the rank labels
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
              //Building the file labels
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
                          final isLightSquare = (row + col).isEven;
                          if (col == 0 || col == 7) {
                            return Expanded(
                              child: BoardSquare(
                                squareData: boardSquares[row][col],
                                isLight: isLightSquare,
                              ),
                            );
                          }
                          return Expanded(
                            child: BoardSquare(
                              squareData: boardSquares[row][col],
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
              //Building the file labels
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
        //Building the rank labels
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
