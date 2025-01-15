// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'board_bloc.dart';

@immutable
sealed class BoardEvent {}

class BoardPieceMoved extends BoardEvent {
  BoardPieceMoved({
    required this.origin,
    required this.target,
    required this.piece,
  });

  final Coordinate origin;
  final Coordinate target;
  final Piece piece;
}

class BoardPieceSelected extends BoardEvent {
  BoardPieceSelected();

  @override
  List<Object> get props => [];
}
