import 'package:chess_shared/chess_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chess/app/bloc/game_bloc.dart';
import 'package:flutter_chess/app/widgets/widgets.dart';
import 'package:flutter_chess/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider(
        create: (context) => GameBloc(),
        lazy: false,
        child: const ChessGameLayout(),
      ),
    );
  }
}

class ChessGameLayout extends StatelessWidget {
  const ChessGameLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chess Game'),
        actions: [
          IconButton(
            icon: const Icon(Icons.replay),
            onPressed: () {
              BlocProvider.of<GameBloc>(context).add(const ChessGameRestart());
            },
          ),
        ],
      ),
      body: BlocListener<GameBloc, GameState>(
        bloc: BlocProvider.of<GameBloc>(context),
        listener: (BuildContext gameContext, state) {
          if (state.gameStatus == GameStatus.checkmate) {
            print('Checkmate ui triggered');
            _showCheckmateDialog(gameContext, state.winner!);
          }
          if (state.gameStatus == GameStatus.stalemate) {
            print('Stalemate ui triggered');
            _showStalemateDialog(gameContext);
          }

          if (state.gameStatus == GameStatus.pawnPromotion) {
            print('Pawn Promotion ui triggered');
            _showPawnPromotionDialog(gameContext);
          }
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 1600) {
              return const BigLayout();
            } else if (constraints.maxWidth > 800) {
              return const MediumLayout();
            } else {
              return const SmallLayout();
            }
          },
        ),
      ),
    );
  }

  void _showPawnPromotionDialog(BuildContext dialogContext) {
    showDialog<void>(
      context: dialogContext,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pawn Promotion'),
          content: const Text('Choose a piece to promote to'),
          actions: [
            TextButton(
              onPressed: () {
                BlocProvider.of<GameBloc>(dialogContext).add(
                  const PawnPromotionConfirmed(
                    PieceType.queen,
                  ),
                );
                Navigator.of(context).pop();
              },
              child: const Text('Queen'),
            ),
            TextButton(
              onPressed: () {
                BlocProvider.of<GameBloc>(dialogContext).add(
                  const PawnPromotionConfirmed(
                    PieceType.rook,
                  ),
                );
                Navigator.of(context).pop();
              },
              child: const Text('Rook'),
            ),
            TextButton(
              onPressed: () {
                BlocProvider.of<GameBloc>(dialogContext).add(
                  const PawnPromotionConfirmed(
                    PieceType.bishop,
                  ),
                );
                Navigator.of(context).pop();
              },
              child: const Text('Bishop'),
            ),
            TextButton(
              onPressed: () {
                BlocProvider.of<GameBloc>(dialogContext).add(
                  const PawnPromotionConfirmed(
                    PieceType.knight,
                  ),
                );
                Navigator.of(context).pop();
              },
              child: const Text('Knight'),
            ),
          ],
        );
      },
    );
  }

  void _showCheckmateDialog(BuildContext dialogContext, Side winner) {
    showDialog<void>(
      context: dialogContext,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Checkmate'),
          content: Text('${winner.name} wins!'),
          actions: [
            TextButton(
              onPressed: () {
                BlocProvider.of<GameBloc>(dialogContext).add(const ChessGameRestart());
                Navigator.of(context).pop();
              },
              child: const Text('Restart'),
            ),
          ],
        );
      },
    );
  }

  void _showStalemateDialog(BuildContext dialogContext) {
    showDialog<void>(
      context: dialogContext,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Stalemate'),
          content: const Text(''),
          actions: [
            TextButton(
              onPressed: () {
                BlocProvider.of<GameBloc>(dialogContext).add(const ChessGameRestart());
                Navigator.of(context).pop();
              },
              child: const Text('Restart'),
            ),
          ],
        );
      },
    );
  }
}
