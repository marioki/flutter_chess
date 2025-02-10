// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_chess/chess_board/models/piece.dart';
import 'package:flutter_chess/chess_board/models/square.dart';
import 'package:flutter_chess/chess_board/widgets/board_square.dart';

class ChessBoard extends StatelessWidget {
  final List<List<SquareData>> boardSquares;
  final String fen;

  const ChessBoard({
    required this.boardSquares,
    this.fen = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1',
    super.key,
  });

  List<String> get boardLetters => ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];

  @override
  Widget build(BuildContext context) {
    parseFenString(fen);

    return Row(
      children: [
        //Building the rank labels
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            8,
            (index) => Text(
              (index + 1).toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            children: [
              //Building the file labels
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  boardLetters.length,
                  (index) => Text(
                    boardLetters[index],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: Row(
                    children: List.generate(8, (col) {
                      return Expanded(
                        child: Column(
                          children: List.generate(8, (row) {
                            final isLightSquare = (row + col).isEven;
                            if (col == 0 || col == 7) {
                              return Expanded(
                                child: BoardSquare(
                                  squareData: boardSquares[row][col],
                                  isLight: isLightSquare,
                                ),
                              );
                            }
                            return Expanded(
                              child: BoardSquare(
                                squareData: boardSquares[row][col],
                                isLight: isLightSquare,
                              ),
                            );
                          }),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              //Building the file labels
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  boardLetters.length,
                  (index) => Text(
                    boardLetters[index],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        //Building the rank labels
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            8,
            (index) => Text(
              (index + 1).toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1',

parseFenString(String fen) {
  List<List<SquareData>> board;
  List<String> fenSegments = fen.split(' ');

  String piecesSegment = fenSegments[0];
  String sideToMoveSegment = fenSegments[1];
  String castleSegment = fenSegments[2];
  String enPassantSegment = fenSegments[3];
  String halfMoveClockSegment = fenSegments[4];
  String fullMoveClockSegment = fenSegments[5];

  for (int index = 0; index < piecesSegment.length; index++) {
    final char = piecesSegment[index];
    if (char == '/') {
      //jump to next rank
      //continue
    }

    if (int.tryParse(char) != null) {
      //Add empty Squares
    } else {
      pieceFromFenCharacter(char);
    }
  }
}

ChessPiece pieceFromFenCharacter(String char) {
  Side? color;
  PieceType? type;

  switch (char) {
    case 'p':
      color = Side.black;
      type = PieceType.pawn;
    case 'r':
      color = Side.black;
      type = PieceType.rook;
    case 'n':
      color = Side.black;
      type = PieceType.knight;
    case 'b':
      color = Side.black;
      type = PieceType.bishop;
    case 'q':
      color = Side.black;
      type = PieceType.queen;
    case 'k':
      color = Side.black;
      type = PieceType.king;
    case 'P':
      color = Side.white;
      type = PieceType.pawn;
    case 'R':
      color = Side.white;
      type = PieceType.rook;
    case 'N':
      color = Side.white;
      type = PieceType.knight;
    case 'B':
      color = Side.white;
      type = PieceType.bishop;
    case 'Q':
      color = Side.white;
      type = PieceType.queen;
    case 'K':
      color = Side.white;
      type = PieceType.king;
  }

  return ChessPiece(color: color!, type: type!);
}

enum Side { white, black }

enum PieceType { pawn, rook, knight, bishop, queen, king }

class GameState {
  Side sideToMove;
  bool whiteQueenSideCasttle;
  bool whiteKingSideCasttle;
  bool blackQueenSideCasttle;
  bool blackKingSideCasttle;
  SquareData enPassant;
  int halfMoveClock;
  int fullMoveNumber;
  List<List<ChessPiece>> pieceMatrix;
  GameState({
    required this.pieceMatrix,
    required this.sideToMove,
    required this.whiteQueenSideCasttle,
    required this.whiteKingSideCasttle,
    required this.blackQueenSideCasttle,
    required this.blackKingSideCasttle,
    required this.enPassant,
    required this.halfMoveClock,
    required this.fullMoveNumber,
  });
}
