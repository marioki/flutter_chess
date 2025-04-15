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
      body: LayoutBuilder(
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
    );
  }
}
