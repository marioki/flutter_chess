import 'dart:async';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chess/models/coordinate.dart';
import 'package:flutter_chess/models/piece.dart';
import 'package:flutter_chess/models/square.dart';
import 'package:meta/meta.dart';

part 'board_event.dart';
part 'board_state.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  BoardBloc() : super(BoardState(boardStatus: BoardStatus.initial, board: gameInitialPieces)) {
    on<BoardPieceMoved>(onBoardPieceMoved);
    on<BoardPieceSelected>(onBoardPieceSelected);
  }

  FutureOr<void> onBoardPieceMoved(BoardPieceMoved event, Emitter<BoardState> emit) {
    final origin = event.piece.currentPosition;
    final target = event.target;
    if (origin == target) {
      print('Ignore same square move');
      return Void;
    }
    final newBoard = resetBoardHighlights(state.board);

    print(
      'Moving ${event.piece.color} ${event.piece.type} from \nold ${origin.file} ${origin.rank}\nnew ${event.target.file} ${event.target.rank}',
    );

    //Move Piece to Target square.
    newBoard[origin.rank][origin.file] =
        SquareData(null, coordinate: Coordinate(file: origin.file, rank: origin.rank));
    newBoard[target.rank][target.file] = SquareData(
      event.piece.copyWith(currentPosition: Coordinate(file: target.file, rank: target.rank)),
      coordinate: Coordinate(file: target.file, rank: target.rank),
    );

    emit(state.copyWith(board: newBoard));

    // for (final row in state.pieces) {
    //   if (kDebugMode) {
    //     print(row.map((piece) => piece?.type ?? '[     ]').toList());
    //   }
    // }
  }

  FutureOr<void> onBoardPieceSelected(BoardPieceSelected event, Emitter<BoardState> emit) {
    /* 
      - Need to save in state what piece was selected.
      - Calculate all posible moves for that piece.
        a. Calculate moves based on piece moveset. And Occupied Squares (ally or foe)
        b. Eliminate iligal moves. (Moves that generate an Own Check Mate)
      - Emit Selected piece and highlighted squares to show available moves.
     */
    final piece = event.piece;

    final newBoard = generateAvailableMoves(state.board, event.piece);
    emit(state.copyWith(selectedPiece: piece, board: newBoard));
  }
}

List<List<SquareData>> resetBoardHighlights(List<List<SquareData>> oldBoard) {
  final newBoard = oldBoard.map((rank) {
    return rank.map((squareData) => squareData.copyWith(isHighLighted: false)).toList();
  }).toList();
  return newBoard;
}

List<List<SquareData>> generateAvailableMoves(List<List<SquareData>> board, Piece selectedPiece) {
  final posibleMoves = <Coordinate>[];
  final cleanBoard = resetBoardHighlights(board);
  final coordinate = selectedPiece.currentPosition;
  final isFirstMove = coordinate.rank == 6;

  // For White Pawns
  if (coordinate.rank < 1) {
    return cleanBoard;
  }

  SquareData? ahead;
  SquareData? ahead2Steps;
  SquareData? diagonalLeft;
  SquareData? diagonalRight;

  //Check ahead
  if (coordinate.rank > 0) {
    ahead = board[coordinate.rank - 1][coordinate.file];
  }

  //Check ahead two steps
  if (isFirstMove) {
    ahead2Steps = board[coordinate.rank - 2][coordinate.file];
  }

  //Check diagonalLeft
  if (coordinate.file > 0) {
    diagonalLeft = board[coordinate.rank - 1][coordinate.file - 1];
  }
  //Check diagonalRight
  if (coordinate.file < 7) {
    diagonalRight = board[coordinate.rank - 1][coordinate.file + 1];
  }

  if (diagonalLeft?.piece?.color == 'black') {
    posibleMoves.add(
      Coordinate(
        file: diagonalLeft!.coordinate.file,
        rank: diagonalLeft.coordinate.rank,
      ),
    );
  }

  if (diagonalRight?.piece?.color == 'black') {
    posibleMoves.add(
      Coordinate(
        file: diagonalRight!.coordinate.file,
        rank: diagonalRight.coordinate.rank,
      ),
    );
  }

  if (ahead?.piece == null) {
    posibleMoves.add(
      Coordinate(
        file: ahead!.coordinate.file,
        rank: ahead.coordinate.rank,
      ),
    );

    if (isFirstMove && ahead2Steps!.piece == null) {
      posibleMoves.add(
        Coordinate(
          file: ahead2Steps.coordinate.file,
          rank: ahead2Steps.coordinate.rank,
        ),
      );
    }
  }

  //Highlight all possible moves
  for (final move in posibleMoves) {
    cleanBoard[move.rank][move.file] = SquareData(
      isHighLighted: true,
      cleanBoard[move.rank][move.file].piece,
      coordinate: cleanBoard[move.rank][move.file].coordinate,
    );
  }

  return cleanBoard;
}

List<List<SquareData>> gameInitialPieces = List.generate(8, (row) {
  return List.generate(8, (col) {
    if (row == 1) {
      return SquareData(
        Piece(
          type: 'pawn',
          color: 'black',
          currentPosition: Coordinate(file: col, rank: row),
        ),
        coordinate: Coordinate(file: col, rank: row),
      );
    }
    if (row == 6) {
      return SquareData(
        Piece(
          type: 'pawn',
          color: 'white',
          currentPosition: Coordinate(file: col, rank: row),
        ),
        coordinate: Coordinate(file: col, rank: row),
      );
    }
    if (row == 0) return blackPrimaryPieces[col];
    if (row == 7) return whitePrimaryPieces[col];
    return SquareData(null, coordinate: Coordinate(file: col, rank: row));
  });
});

final List<SquareData> whitePrimaryPieces = [
  SquareData(
    Piece(type: 'rook', color: 'white', currentPosition: const Coordinate(file: 0, rank: 7)),
    coordinate: const Coordinate(file: 0, rank: 7),
  ),
  SquareData(
    Piece(type: 'knight', color: 'white', currentPosition: const Coordinate(file: 1, rank: 7)),
    coordinate: const Coordinate(file: 1, rank: 7),
  ),
  SquareData(
    Piece(type: 'bishop', color: 'white', currentPosition: const Coordinate(file: 2, rank: 7)),
    coordinate: const Coordinate(file: 2, rank: 7),
  ),
  SquareData(
    Piece(type: 'queen', color: 'white', currentPosition: const Coordinate(file: 3, rank: 7)),
    coordinate: const Coordinate(file: 3, rank: 7),
  ),
  SquareData(
    Piece(type: 'king', color: 'white', currentPosition: const Coordinate(file: 4, rank: 7)),
    coordinate: const Coordinate(file: 4, rank: 7),
  ),
  SquareData(
    Piece(type: 'bishop', color: 'white', currentPosition: const Coordinate(file: 5, rank: 7)),
    coordinate: const Coordinate(file: 5, rank: 7),
  ),
  SquareData(
    Piece(type: 'knight', color: 'white', currentPosition: const Coordinate(file: 6, rank: 7)),
    coordinate: const Coordinate(file: 6, rank: 7),
  ),
  SquareData(
    Piece(type: 'rook', color: 'white', currentPosition: const Coordinate(file: 7, rank: 7)),
    coordinate: const Coordinate(file: 7, rank: 7),
  ),
];

final List<SquareData> blackPrimaryPieces = [
  SquareData(
    Piece(type: 'rook', color: 'black', currentPosition: const Coordinate(file: 0, rank: 0)),
    coordinate: const Coordinate(file: 0, rank: 0),
  ),
  SquareData(
    Piece(type: 'knight', color: 'black', currentPosition: const Coordinate(file: 1, rank: 0)),
    coordinate: const Coordinate(file: 1, rank: 0),
  ),
  SquareData(
    Piece(type: 'bishop', color: 'black', currentPosition: const Coordinate(file: 2, rank: 0)),
    coordinate: const Coordinate(file: 2, rank: 0),
  ),
  SquareData(
    Piece(type: 'queen', color: 'black', currentPosition: const Coordinate(file: 3, rank: 0)),
    coordinate: const Coordinate(file: 3, rank: 0),
  ),
  SquareData(
    Piece(type: 'king', color: 'black', currentPosition: const Coordinate(file: 4, rank: 0)),
    coordinate: const Coordinate(file: 4, rank: 0),
  ),
  SquareData(
    Piece(type: 'bishop', color: 'black', currentPosition: const Coordinate(file: 5, rank: 0)),
    coordinate: const Coordinate(file: 5, rank: 0),
  ),
  SquareData(
    Piece(type: 'knight', color: 'black', currentPosition: const Coordinate(file: 6, rank: 0)),
    coordinate: const Coordinate(file: 6, rank: 0),
  ),
  SquareData(
    Piece(type: 'rook', color: 'black', currentPosition: const Coordinate(file: 7, rank: 0)),
    coordinate: const Coordinate(file: 7, rank: 0),
  ),
];
