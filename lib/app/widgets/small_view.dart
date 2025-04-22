// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chess_shared/chess_shared.dart';
import 'package:chess_ui/chess_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_chess/app/bloc/game_bloc.dart';
import 'package:flutter_chess/app/widgets/big_view.dart';

class SmallLayout extends StatelessWidget {
  const SmallLayout({super.key});

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
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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

class GameStatusSection extends StatelessWidget {
  const GameStatusSection({
    required this.gameStatus,
    required this.fen,
    required this.possibleMoves,
    Key? key,
  }) : super(key: key);

  final String gameStatus;
  final String fen;
  final List<String> possibleMoves;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Game Status'),
            subtitle: Text(gameStatus),
          ),
          ListTile(
            title: const Text('FEN'),
            subtitle: Text(fen),
            onTap: () {
              Clipboard.setData(ClipboardData(text: fen));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('FEN copied to clipboard!'),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Possible Moves'),
            subtitle: Text(possibleMoves.toString()),
          ),
          const ListTile(
            title: Text('Captured Pieces'),
          ),
        ],
      ),
    );
  }
}
