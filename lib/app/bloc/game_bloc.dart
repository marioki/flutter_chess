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
    on<PawnPromotionRequest>(onPawnPromotionRequest);
    on<PawnPromotionConfirmed>(onPawnPromotionConfirmed);
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
          moveHistory: List.from(state.moveHistory)..add(event.lanMove),
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
    emit(
      state.copyWith(
        possibleMoves: moves,
        gameStatus: GameStatus.playing,
      ),
    );
  }

  FutureOr<void> onChessGameRestart(ChessGameRestart event, Emitter<GameState> emit) {
    emit(
      const GameState(
        fen: initialFen,
        gameStatus: GameStatus.playing,
      ),
    );
  }

  FutureOr<void> onPawnPromotionRequest(PawnPromotionRequest event, Emitter<GameState> emit) {
    print('Pawn promotion event triggered');
    final gamePosition = GamePosition.fromFEN(state.fen);
    final move = Move.fromLAN(event.lanMove);

    if (_coreChess.isMoveValid(gamePosition, move) && _coreChess.isMoveLegal(gamePosition, move)) {
      emit(
        state.copyWith(
          gameStatus: GameStatus.pawnPromotion,
          promotionMove: move,
        ),
      );
    } else {
      print('Invalid move for pawn promotion');
      emit(
        state.copyWith(
          gameStatus: GameStatus.playing,
        ),
      );
    }
  }

  FutureOr<void> onPawnPromotionConfirmed(PawnPromotionConfirmed event, Emitter<GameState> emit) {
    final pieceChar = getPieceTypeString(event.pieceType);
    final lanPromotionMove = '${state.promotionMove!.lan}=$pieceChar';

    add(ChessPieceMoved(lanPromotionMove));
  }
}
