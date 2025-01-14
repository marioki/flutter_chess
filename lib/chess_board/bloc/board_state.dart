part of 'board_bloc.dart';

enum BoardStatus { initial, loading, success, failed }

final class BoardState {
  BoardState({
    required this.boardStatus,
    required this.pieces,
  });

  final BoardStatus boardStatus;
  final List<List<Piece?>> pieces;
}
