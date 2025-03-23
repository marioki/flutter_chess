import 'package:chess_ui/chess_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chess/app/bloc/game_bloc.dart';
import 'package:flutter_chess/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: SafeArea(
          child: BlocProvider(
            create: (context) => GameBloc(),
            child: Container(
              margin: const EdgeInsets.all(16),
              child: BlocBuilder<GameBloc, GameState>(
                builder: (context, state) {
                  return ChessBoard(
                    fen: state.fen,
                    possibleMoves: state.possibleMoves,
                    onMove: (lanMove) {
                      BlocProvider.of<GameBloc>(context).add(ChessPieceMoved(lanMove));
                    },
                    onSelectPiece: (anSquare) {
                      print('*UI* Selected Piece Square: $anSquare');
                      BlocProvider.of<GameBloc>(context).add(ChessPieceSelected(anSquare));
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
