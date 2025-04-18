import 'package:chess_shared/chess_shared.dart';
import 'package:chess_ui/chess_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chess/app/bloc/game_bloc.dart';
import 'package:flutter_chess/app/widgets/small_view.dart';

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
                Expanded(
                  child: Row(
                    children: [
                      MoveHistorySection(lanMoves: state.moveHistory),
                      GameStatusSection(
                        fen: state.fen,
                        gameStatus: state.gameStatus.name,
                        possibleMoves: state.possibleMoves,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class MoveHistorySection extends StatelessWidget {
  const MoveHistorySection({
    required this.lanMoves,
    super.key,
  });

  final List<String> lanMoves;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
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
              itemCount: lanMoves.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Move ${index + 1}'),
                  subtitle: Text(lanMoves[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
