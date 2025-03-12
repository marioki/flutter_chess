import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(const GameState('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR b KQkq - 0 0')) {
    on<ChessPieceMoved>(_onChessPieceMoved);
    on<ChessPieceSelected>(onChessPieceSelected);
  }

  void _onChessPieceMoved(ChessPieceMoved event, Emitter<GameState> emit) {}

  void onChessPieceSelected(ChessPieceSelected event, Emitter<GameState> emit) {}
}
