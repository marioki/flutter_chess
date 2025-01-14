part of 'board_bloc.dart';

@immutable
sealed class BoardEvent {}

class BoardPieceMoved extends BoardEvent {
  BoardPieceMoved();

  @override
  List<Object> get props => [];
}

class BoardPieceSelected extends BoardEvent {
  BoardPieceSelected();

  @override
  List<Object> get props => [];
}
