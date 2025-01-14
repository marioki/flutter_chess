import 'package:bloc/bloc.dart';
import 'package:flutter_chess/models/piece.dart';
import 'package:meta/meta.dart';

part 'board_event.dart';
part 'board_state.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  BoardBloc()
      : super(
          BoardState(boardStatus: BoardStatus.initial, pieces: gameInitialPieces),
        ) {
    on<BoardEvent>((event, emit) {});
  }
}

List<List<Piece?>> gameInitialPieces = List.generate(8, (row) {
  return List.generate(8, (col) {
    if (row == 1) return Piece(type: 'pawn', color: 'black');
    if (row == 6) return Piece(type: 'pawn', color: 'white');
    if (row == 0) return blackPrimaryPieces[col];
    if (row == 7) return whitePrimaryPieces[col];
    return null;
  });
});

final List<Piece> whitePrimaryPieces = [
  Piece(type: 'rook', color: 'white'),
  Piece(type: 'knight', color: 'white'),
  Piece(type: 'bishop', color: 'white'),
  Piece(type: 'queen', color: 'white'),
  Piece(type: 'king', color: 'white'),
  Piece(type: 'bishop', color: 'white'),
  Piece(type: 'knight', color: 'white'),
  Piece(type: 'rook', color: 'white'),
];

final List<Piece> blackPrimaryPieces = [
  Piece(type: 'rook', color: 'black'),
  Piece(type: 'knight', color: 'black'),
  Piece(type: 'bishop', color: 'black'),
  Piece(type: 'queen', color: 'black'),
  Piece(type: 'king', color: 'black'),
  Piece(type: 'bishop', color: 'black'),
  Piece(type: 'knight', color: 'black'),
  Piece(type: 'rook', color: 'black'),
];
