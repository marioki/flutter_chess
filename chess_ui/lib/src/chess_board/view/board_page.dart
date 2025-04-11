// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:chess_shared/chess_shared.dart';
import 'package:chess_ui/src/chess_board/widgets/widgets.dart';

import 'package:flutter/material.dart';

class ChessBoard extends StatelessWidget {
  static const _defaultStartingPosition =
      'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR b KQkq - 0 0';

  final String fen;
  final void Function(String) onMove;
  final void Function(String) onSelectPiece;
  final List<String> possibleMoves;
  const ChessBoard({
    required this.onMove,
    required this.onSelectPiece,
    required this.possibleMoves,
    super.key,
    this.fen = _defaultStartingPosition,
  });

  @override
  Widget build(BuildContext context) {
    final gameState = GamePosition.fromFEN(fen);

    return Container(
      constraints: const BoxConstraints(
        maxWidth: 1000,
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(border: Border.all()),
                      child: Row(
                        children: List.generate(8, (col) {
                          return Expanded(
                            child: Column(
                              children: List.generate(8, (row) {
                                final isLightSquare = (row + col).isOdd;
                                return Expanded(
                                  child: BoardSquare(
                                    squareData: gameState.squareGrid[(row - 7).abs()][col],
                                    isLight: isLightSquare,
                                    onMove: onMove,
                                    sideToMove: gameState.sideToMove,
                                    onSelectPiece: onSelectPiece,
                                    isHighLighted: possibleMoves.contains(
                                      gameState
                                          .squareGrid[(row - 7).abs()][col].coordinate.algebraic,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
