import 'package:flutter/material.dart';
import 'package:flutter_chess/app/widgets/widgets.dart';
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
      home: const ChessGameLayout(),
    );
  }
}

class ChessGameLayout extends StatelessWidget {
  const ChessGameLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1600) {
          return const BigLayout();
        } else if (constraints.maxWidth > 800) {
          return const MediumLayout();
        } else {
          return const SmallLayout();
        }
      },
    );
  }
}
