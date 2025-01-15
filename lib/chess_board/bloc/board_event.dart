// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'board_bloc.dart';

@immutable
sealed class BoardEvent {}

class BoardPieceMoved extends BoardEvent {
  BoardPieceMoved({
    required this.target,
    required this.piece,
  });

  final Coordinate target;
  final Piece piece;
}

class BoardPieceSelected extends BoardEvent {
  BoardPieceSelected({required this.piece});
  final Piece piece;

  @override
  List<Object> get props => [piece];
}
