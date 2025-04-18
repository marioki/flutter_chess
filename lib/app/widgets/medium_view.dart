import 'package:chess_shared/chess_shared.dart';
import 'package:chess_ui/chess_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chess/app/bloc/game_bloc.dart';
import 'package:flutter_chess/app/widgets/big_view.dart';
import 'package:flutter_chess/app/widgets/small_view.dart';

class MediumLayout extends StatelessWidget {
  const MediumLayout({super.key});

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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Padding(
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
