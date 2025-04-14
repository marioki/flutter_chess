import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chess_shared/chess_shared.dart';
import 'package:core_chess/core_chess.dart';
import 'package:equatable/equatable.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  static const String initialFen = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 0';
  GameBloc()
      : super(
          const GameState(
            fen: initialFen,
            gameStatus: GameStatus.playing,
          ),
        ) {
    on<ChessPieceMoved>(_onChessPieceMoved);
    on<ChessPieceSelected>(onChessPieceSelected);
    on<ChessGameRestart>(onChessGameRestart);
  }
  final CoreChess _coreChess = CoreChess();

  void _onChessPieceMoved(ChessPieceMoved event, Emitter<GameState> emit) {
    try {
      final gameData = _coreChess.makeMove(state.fen, event.lanMove);

      emit(
        state.copyWith(
          fen: gameData.fen,
          possibleMoves: [],
          gameStatus: gameData.status,
        ),
      );
    } catch (exception) {
      print('Error: $exception');
      return;
    }
  }

  void onChessPieceSelected(ChessPieceSelected event, Emitter<GameState> emit) {
    final moves = _coreChess.getLegalMovesForPiece(state.fen, event.anSquare);
    print('*Handler* Calculated moves: $moves');
    emit(state.copyWith(possibleMoves: moves));
  }

  FutureOr<void> onChessGameRestart(ChessGameRestart event, Emitter<GameState> emit) {
    emit(
      const GameState(
        fen: initialFen,
        gameStatus: GameStatus.playing,
      ),
    );
  }
}
