import 'package:chess_shared/chess_shared.dart';
import 'package:chess_ui/chess_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chess/app/bloc/game_bloc.dart';

class BigLayout extends StatelessWidget {
  const BigLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
            if (state.gameStatus == GameStatus.checkmate) {
              return const Center(
                child: Text('Checkmate!'),
              );
            } else if (state.gameStatus == GameStatus.draw) {
              return const Center(
                child: Text('Draw!'),
              );
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  child: Center(
                    child: ChessBoard(
                      fen: state.fen,
                      possibleMoves: state.possibleMoves,
                      onMove: (lanMove) {
                        BlocProvider.of<GameBloc>(context).add(ChessPieceMoved(lanMove));
                      },
                      onSelectPiece: (anSquare) {
                        BlocProvider.of<GameBloc>(context).add(ChessPieceSelected(anSquare));
                      },
                      onPromotePawn: (lanMove) {
                        print('Promote Pawn from UI Big Layout');
                        BlocProvider.of<GameBloc>(context).add(PawnPromotionRequest(lanMove));
                      },
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 300,
                        maxHeight: 1000,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Move History',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Flexible(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text('Move ${index + 1}'),
                                  subtitle: const Text('Move details here'),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 600,
                        maxHeight: 1000,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              'Game Status',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            ListTile(
                              title: const Text('FEN'),
                              subtitle: Text(state.fen),
                            ),
                            ListTile(
                              title: const Text('Possible Moves'),
                              subtitle: Text(state.possibleMoves.toString()),
                            ),
                            const ListTile(
                              title: Text('Captured Pieces'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
