import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chess/chess_board/models/bishop.dart';
import 'package:flutter_chess/chess_board/models/black_pawn.dart';
import 'package:flutter_chess/chess_board/models/coordinate.dart';
import 'package:flutter_chess/chess_board/models/king.dart';
import 'package:flutter_chess/chess_board/models/knight.dart';
import 'package:flutter_chess/chess_board/models/piece.dart';
import 'package:flutter_chess/chess_board/models/queen.dart';
import 'package:flutter_chess/chess_board/models/rook.dart';
import 'package:flutter_chess/chess_board/models/square.dart';
import 'package:flutter_chess/chess_board/models/white_pawn.dart';
import 'package:meta/meta.dart';

part 'board_event.dart';
part 'board_state.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  BoardBloc()
      : super(
          BoardState(boardStatus: BoardStatus.initial, board: gameInitialPieces, totalMoves: 0),
        ) {
    on<BoardPieceMoved>(onBoardPieceMoved);
    on<BoardPieceSelected>(onBoardPieceSelected);
  }

  FutureOr<void> onBoardPieceMoved(BoardPieceMoved event, Emitter<BoardState> emit) {
    final origin = event.piece.currentPosition;
    final target = event.target;
    final piece = event.piece;

    //Handle Turns
    if (piece.color == 'white' && state.totalMoves.isOdd) {
      return Future.value();
    }
    if (piece.color == 'black' && state.totalMoves.isEven) {
      return Future.value();
    }

    //Do nothing if placed on the same square
    if (origin == target.coordinate) {
      return Future.value();
    }

    //Clean Board from previous selected piece
    var newBoard = resetBoardHighlights(state.board);

    // Check if the target square is on the posible moves.
    final (highLightedBoard, posibleMoves) = event.piece.generatePossibleMoves(newBoard);

    //Remove previous en pessant squared if Exist
    newBoard = resetEnPassant(newBoard);

    if (!posibleMoves.contains(target.coordinate)) {
      print('Move is not posible');
      return Future.value();
    }

    //If it is a pawn then setup en passant square
    if (piece.type == 'pawn' && (origin.rank - target.coordinate.rank).abs() == 2) {
      if (piece.color == 'white') {
        newBoard[origin.rank - 1][origin.file] = SquareData(
          null,
          enPassant: true,
          coordinate: Coordinate(rank: origin.rank - 1, file: origin.file),
        );
      } else {
        newBoard[origin.rank + 1][origin.file] = SquareData(
          null,
          enPassant: true,
          coordinate: Coordinate(rank: origin.rank + 1, file: origin.file),
        );
      }
    }

    //Remove piece from origin square
    newBoard[origin.rank][origin.file] =
        SquareData(null, coordinate: Coordinate(file: origin.file, rank: origin.rank));

    //add piece to target square
    newBoard[target.coordinate.rank][target.coordinate.file] = SquareData(
      event.piece.copyWith(
        currentPosition: Coordinate(file: target.coordinate.file, rank: target.coordinate.rank),
      ),
      coordinate: Coordinate(file: target.coordinate.file, rank: target.coordinate.rank),
    );
    if (target.enPassant) {
      if (piece.color == 'black') {
        newBoard[target.coordinate.rank - 1][target.coordinate.file] = SquareData(
          null,
          coordinate: Coordinate(rank: target.coordinate.rank - 1, file: target.coordinate.file),
        );
      } else {
        newBoard[target.coordinate.rank + 1][target.coordinate.file] = SquareData(
          null,
          coordinate: Coordinate(rank: target.coordinate.rank - 1, file: target.coordinate.file),
        );
      }
    }

    emit(state.copyWith(board: newBoard, totalMoves: state.totalMoves + 1));

    for (final row in state.board) {
      if (kDebugMode) {
        print(row.map((square) => square.piece ?? square.enPassant).toList());
      }
    }
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
    if (piece.color == 'white' && state.totalMoves.isOdd) {
      return Future.value();
    }
    if (piece.color == 'black' && state.totalMoves.isEven) {
      return Future.value();
    }

    final cleanBoard = resetBoardHighlights(state.board);

    final (newBoard, posibleMoves) = piece.generatePossibleMoves(cleanBoard);

    for (final row in state.board) {
      if (kDebugMode) {
        print(row.map((square) => square.piece ?? square.enPassant).toList());
      }
    }
    emit(state.copyWith(selectedPiece: piece, board: newBoard));
  }
}

/// Takes in a board List<List<SquareData>> and returns the board without highlighted squares
/// Does not removes en passant squares.
List<List<SquareData>> resetBoardHighlights(List<List<SquareData>> oldBoard) {
  final cleanBoard = oldBoard.map((rank) {
    return rank
        .map(
          (squareData) => squareData.copyWith(
            isHighLighted: false,
          ),
        )
        .toList();
  }).toList();
  return cleanBoard;
}

List<List<SquareData>> resetEnPassant(List<List<SquareData>> oldBoard) {
  final newBoard = oldBoard.map((rank) {
    return rank
        .map(
          (squareData) => squareData.copyWith(
            enPassant: false,
            isHighLighted: false,
          ),
        )
        .toList();
  }).toList();
  return newBoard;
}

List<List<SquareData>> gameInitialPieces = List.generate(8, (row) {
  return List.generate(8, (col) {
    if (row == 1) {
      return SquareData(
        BlackPawn(
          type: 'pawn',
          color: 'black',
          currentPosition: Coordinate(file: col, rank: row),
        ),
        coordinate: Coordinate(file: col, rank: row),
      );
    }
    if (row == 6) {
      return SquareData(
        WhitePawn(
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
    Rook(type: 'rook', color: 'white', currentPosition: const Coordinate(file: 0, rank: 7)),
    coordinate: const Coordinate(file: 0, rank: 7),
  ),
  SquareData(
    Knight(type: 'knight', color: 'white', currentPosition: const Coordinate(file: 1, rank: 7)),
    coordinate: const Coordinate(file: 1, rank: 7),
  ),
  SquareData(
    Bishop(type: 'bishop', color: 'white', currentPosition: const Coordinate(file: 2, rank: 7)),
    coordinate: const Coordinate(file: 2, rank: 7),
  ),
  SquareData(
    Queen(type: 'queen', color: 'white', currentPosition: const Coordinate(file: 3, rank: 7)),
    coordinate: const Coordinate(file: 3, rank: 7),
  ),
  SquareData(
    King(type: 'king', color: 'white', currentPosition: const Coordinate(file: 4, rank: 7)),
    coordinate: const Coordinate(file: 4, rank: 7),
  ),
  SquareData(
    Bishop(type: 'bishop', color: 'white', currentPosition: const Coordinate(file: 5, rank: 7)),
    coordinate: const Coordinate(file: 5, rank: 7),
  ),
  SquareData(
    Knight(type: 'knight', color: 'white', currentPosition: const Coordinate(file: 6, rank: 7)),
    coordinate: const Coordinate(file: 6, rank: 7),
  ),
  SquareData(
    Rook(type: 'rook', color: 'white', currentPosition: const Coordinate(file: 7, rank: 7)),
    coordinate: const Coordinate(file: 7, rank: 7),
  ),
];

final List<SquareData> blackPrimaryPieces = [
  SquareData(
    Rook(type: 'rook', color: 'black', currentPosition: const Coordinate(file: 0, rank: 0)),
    coordinate: const Coordinate(file: 0, rank: 0),
  ),
  SquareData(
    Knight(type: 'knight', color: 'black', currentPosition: const Coordinate(file: 1, rank: 0)),
    coordinate: const Coordinate(file: 1, rank: 0),
  ),
  SquareData(
    Bishop(type: 'bishop', color: 'black', currentPosition: const Coordinate(file: 2, rank: 0)),
    coordinate: const Coordinate(file: 2, rank: 0),
  ),
  SquareData(
    Queen(type: 'queen', color: 'black', currentPosition: const Coordinate(file: 3, rank: 0)),
    coordinate: const Coordinate(file: 3, rank: 0),
  ),
  SquareData(
    King(type: 'king', color: 'black', currentPosition: const Coordinate(file: 4, rank: 0)),
    coordinate: const Coordinate(file: 4, rank: 0),
  ),
  SquareData(
    Bishop(type: 'bishop', color: 'black', currentPosition: const Coordinate(file: 5, rank: 0)),
    coordinate: const Coordinate(file: 5, rank: 0),
  ),
  SquareData(
    Knight(type: 'knight', color: 'black', currentPosition: const Coordinate(file: 6, rank: 0)),
    coordinate: const Coordinate(file: 6, rank: 0),
  ),
  SquareData(
    Rook(type: 'rook', color: 'black', currentPosition: const Coordinate(file: 7, rank: 0)),
    coordinate: const Coordinate(file: 7, rank: 0),
  ),
];
