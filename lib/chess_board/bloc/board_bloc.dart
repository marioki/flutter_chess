import 'dart:async';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chess/models/coordinate.dart';
import 'package:flutter_chess/models/piece.dart';
import 'package:meta/meta.dart';

part 'board_event.dart';
part 'board_state.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  BoardBloc() : super(BoardState(boardStatus: BoardStatus.initial, pieces: gameInitialPieces)) {
    on<BoardPieceMoved>(onBoardPieceMoved);
  }

  FutureOr<void> onBoardPieceMoved(BoardPieceMoved event, Emitter<BoardState> emit) {
    final origin = event.origin;
    final target = event.target;
    if (origin == target) {
      print('Ignore same square move');
      return Void;
    }
    final newPieces = state.pieces;
    print(
        'Moving ${event.piece.color} ${event.piece.type} from \nold ${event.origin.file} ${event.origin.rank}\nnew ${event.target.file} ${event.target.rank}');

    
    //Move Piece to Target square.
    newPieces[event.origin.rank][event.origin.file] = null;
    newPieces[event.target.rank][event.target.file] = event.piece
        .copyWith(currentPosition: Coordinate(file: event.target.file, rank: event.target.rank));
    emit(state.copyWith(pieces: newPieces));

    // for (final row in state.pieces) {
    //   if (kDebugMode) {
    //     print(row.map((piece) => piece?.type ?? '[     ]').toList());
    //   }
    // }
  }
}

List<List<Piece?>> gameInitialPieces = List.generate(8, (row) {
  return List.generate(8, (col) {
    if (row == 1) {
      return Piece(type: 'pawn', color: 'black', currentPosition: Coordinate(file: col, rank: row));
    }
    if (row == 6) {
      return Piece(type: 'pawn', color: 'white', currentPosition: Coordinate(file: col, rank: row));
    }
    if (row == 0) return blackPrimaryPieces[col];
    if (row == 7) return whitePrimaryPieces[col];
    return null;
  });
});

final List<Piece> whitePrimaryPieces = [
  Piece(type: 'rook', color: 'white', currentPosition: Coordinate(file: 0, rank: 7)),
  Piece(type: 'knight', color: 'white', currentPosition: Coordinate(file: 1, rank: 7)),
  Piece(type: 'bishop', color: 'white', currentPosition: Coordinate(file: 2, rank: 7)),
  Piece(type: 'queen', color: 'white', currentPosition: Coordinate(file: 3, rank: 7)),
  Piece(type: 'king', color: 'white', currentPosition: Coordinate(file: 4, rank: 7)),
  Piece(type: 'bishop', color: 'white', currentPosition: Coordinate(file: 5, rank: 7)),
  Piece(type: 'knight', color: 'white', currentPosition: Coordinate(file: 6, rank: 7)),
  Piece(type: 'rook', color: 'white', currentPosition: Coordinate(file: 7, rank: 7)),
];

final List<Piece> blackPrimaryPieces = [
  Piece(type: 'rook', color: 'black', currentPosition: Coordinate(file: 0, rank: 0)),
  Piece(type: 'knight', color: 'black', currentPosition: Coordinate(file: 1, rank: 0)),
  Piece(type: 'bishop', color: 'black', currentPosition: Coordinate(file: 2, rank: 0)),
  Piece(type: 'queen', color: 'black', currentPosition: Coordinate(file: 3, rank: 0)),
  Piece(type: 'king', color: 'black', currentPosition: Coordinate(file: 4, rank: 0)),
  Piece(type: 'bishop', color: 'black', currentPosition: Coordinate(file: 5, rank: 0)),
  Piece(type: 'knight', color: 'black', currentPosition: Coordinate(file: 6, rank: 0)),
  Piece(type: 'rook', color: 'black', currentPosition: Coordinate(file: 7, rank: 0)),
];
