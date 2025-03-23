import 'package:bloc/bloc.dart';
import 'package:core_chess/core_chess.dart';
import 'package:equatable/equatable.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc()
      : super(
          const GameState(fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR b KQkq - 0 0'),
        ) {
    on<ChessPieceMoved>(_onChessPieceMoved);
    on<ChessPieceSelected>(onChessPieceSelected);
  }
  final CoreChess _coreChess = CoreChess();

  void _onChessPieceMoved(ChessPieceMoved event, Emitter<GameState> emit) {}

  void onChessPieceSelected(ChessPieceSelected event, Emitter<GameState> emit) {
    List<String> moves = _coreChess.getLegalMoves(state.fen, event.anSquare);
    print('*Handler* Calculated moves: $moves');
    emit(state.copyWith(possibleMoves: moves));
  }
}
