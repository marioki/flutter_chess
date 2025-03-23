// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'game_bloc.dart';

sealed class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class ChessPieceMoved extends GameEvent {
  const ChessPieceMoved(
    this.lanMove,
  );
  final String lanMove;

  @override
  List<Object> get props => [lanMove];
}

class ChessPieceSelected extends GameEvent {
  const ChessPieceSelected(
    this.anSquare,
  );
  final String anSquare;

  @override
  List<Object> get props => [anSquare];
}
