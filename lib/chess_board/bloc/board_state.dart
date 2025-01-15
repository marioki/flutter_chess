// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'board_bloc.dart';

enum BoardStatus { initial, loading, success, failed }

@immutable
class BoardState {
  const BoardState({
    required this.boardStatus,
    required this.pieces,
  });

  final BoardStatus boardStatus;
  final List<List<Piece?>> pieces;
  

  BoardState copyWith({
    BoardStatus? boardStatus,
    List<List<Piece?>>? pieces,
  }) {
    return BoardState(
      boardStatus: boardStatus ?? this.boardStatus,
      pieces: pieces ?? this.pieces,
    );
  }
}
