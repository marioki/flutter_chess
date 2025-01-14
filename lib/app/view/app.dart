import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chess/chess_board/bloc/board_bloc.dart';
import 'package:flutter_chess/chess_board/view/view.dart';
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
      home: BlocProvider(
        create: (context) => BoardBloc(),
        child: Scaffold(
          body: Container(
            margin: const EdgeInsets.all(16),
            child: BlocBuilder<BoardBloc, BoardState>(
              builder: (context, state) {
                return ChessBoard(
                  boardState: state.pieces,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
