// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'board_bloc.dart';

enum BoardStatus { initial, loading, success, failed }

@immutable
class BoardState {
  const BoardState({
    required this.boardStatus,
    required this.board,
    this.selectedPiece,
  });

  final BoardStatus boardStatus;
  final List<List<SquareData>> board;
  final Piece? selectedPiece;

  BoardState copyWith({
    BoardStatus? boardStatus,
    List<List<SquareData>>? board,
    Piece? selectedPiece,
  }) {
    return BoardState(
      boardStatus: boardStatus ?? this.boardStatus,
      board: board ?? this.board,
      selectedPiece: selectedPiece ?? this.selectedPiece,
    );
  }
}
