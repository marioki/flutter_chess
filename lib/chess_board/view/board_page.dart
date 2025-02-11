// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_chess/chess_board/helpers/parse_fen_string.dart';
import 'package:flutter_chess/chess_board/models/game_state.dart';
import 'package:flutter_chess/chess_board/widgets/board_square.dart';

class ChessBoard extends StatelessWidget {
  final String fen;
  late final GameState gameState;
  static const _defaultStartingPosition =
      'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR b KQkq - 0 1';
  static const _boardLetters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];

  ChessBoard({
    Key? key,
    this.fen = _defaultStartingPosition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    gameState = parseFenString(fen);
    print('Rebuilding Chess Board Widget');
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
                        _boardLetters.length,
                        (index) => Text(
                          _boardLetters[index],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(border: Border.all()),
                        child: Row(
                          children: List.generate(8, (col) {
                            return Expanded(
                              child: Column(
                                children: List.generate(8, (row) {
                                  final isLightSquare = (row + col).isEven;
                                  if (col == 0 || col == 7) {
                                    return Expanded(
                                      child: BoardSquare(
                                        squareData: gameState.pieceMatrix[row][col],
                                        isLight: isLightSquare,
                                      ),
                                    );
                                  }
                                  return Expanded(
                                    child: BoardSquare(
                                      squareData: gameState.pieceMatrix[row][col],
                                      isLight: isLightSquare,
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
