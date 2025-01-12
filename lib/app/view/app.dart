import 'package:flutter/material.dart';
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
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(32),
          child: ChessBoard(
            boardState: boardState,
          ),
        ),
      ),
    );
  }
}

List<List<Piece?>> boardState = List.generate(8, (row) {
  return List.generate(8, (col) {
    if (row == 1) return Piece(type: 'pawn', color: 'white');
    if (row == 6) return Piece(type: 'pawn', color: 'black');
    return null;
  });
});
