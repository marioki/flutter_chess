// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:chess_ui/src/chess_board/models/coordinate.dart';
import 'package:chess_ui/src/chess_board/models/game_state.dart';
import 'package:chess_ui/src/chess_board/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ChessBoard extends StatelessWidget {
  static const _defaultStartingPosition =
      'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR b KQkq - 0 0';
  static const _boardLetters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];

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
    print('fen from board page');
    print(fen);
    final gameState = GameState.fromFEN(fen);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Row(
            children: [
              //Building the rank labels
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  8,
                  (index) => Text(
                    (8 - index).toString(),
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

                    const SizedBox(height: 16),
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
                    const SizedBox(height: 16),
                    //Building the file labels
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                        _boardLetters.length,
                        (index) => Text(
                          _boardLetters[index],
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
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${gameState.sideToMove.name}'s turn"),
            Text('Half move clock: ${gameState.halfMoveClock}'),
            Text('Full move clock: ${gameState.fullMoveNumber}'),
            Text('En Passant: ${gameState.enPassant}'),
            Text('Black King Side Casstle: ${gameState.blackKingSideCasttle}'),
            Text('Black Queen Side Casstle: ${gameState.blackQueenSideCasttle}'),
            Text('White King Side Casstle: ${gameState.whiteKingSideCasttle}'),
            Text('White Queen Side Casstle: ${gameState.whiteQueenSideCasttle}'),
          ],
        ),
      ],
    );
  }
}
