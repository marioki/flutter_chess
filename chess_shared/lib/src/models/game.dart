import 'package:chess_shared/chess_shared.dart';

/// Represents the state of a chess game.
class GamePosition {
  /// Creates a [GamePosition] with the given parameters.
  GamePosition({
    required this.squareGrid,
    required this.sideToMove,
    required this.whiteQueenSideCasttle,
    required this.whiteKingSideCasttle,
    required this.blackQueenSideCasttle,
    required this.blackKingSideCasttle,
    required this.halfMoveClock,
    required this.fullMoveNumber,
    this.enPassant,
  });

  /// Creates a [GamePosition] from a FEN string.
  ///
  /// [fen] The FEN string representing the game state.
  factory GamePosition.fromFEN(String fen) {
    final fenSegments = fen.split(' ');
    final piecesSegment = fenSegments[0];
    final sideToMoveSegment = fenSegments[1];
    final castleSegment = fenSegments[2];
    final enPassantSegment = fenSegments[3];
    final halfMoveClockSegment = fenSegments[4];
    final fullMoveClockSegment = fenSegments[5];

    return GamePosition(
      squareGrid: createSquareGrid(piecesSegment),
      sideToMove: sideToMoveSegment == 'w' ? Side.white : Side.black,
      whiteQueenSideCasttle: castleSegment.contains('Q'),
      whiteKingSideCasttle: castleSegment.contains('K'),
      blackQueenSideCasttle: castleSegment.contains('q'),
      blackKingSideCasttle: castleSegment.contains('k'),
      halfMoveClock: int.parse(halfMoveClockSegment),
      fullMoveNumber: int.parse(fullMoveClockSegment),
      enPassant: enPassantSegment == '-' ? null : Coordinate.fromAlgebraic(enPassantSegment),
    );
  }

  /// Converts the game state to a FEN string.
  /// Returns the FEN string representing the game state.
  String toFenString() {
    String fen = '';
    for (int row = 7; row >= 0; row--) {
      int emptySquareCounter = 0;
      for (int column = 0; column < 8; column++) {
        if (squareGrid[row][column].piece == null) {
          emptySquareCounter++;
        } else {
          if (emptySquareCounter > 0) {
            fen += emptySquareCounter.toString();
            emptySquareCounter = 0;
          }
          fen += chessPieceToFen(squareGrid[row][column].piece!);
        }
      }
      if (emptySquareCounter > 0) {
        fen += emptySquareCounter.toString();
      }
      if (row <= 7) {
        fen += '/';
      }
    }
    fen += ' ';
    fen += sideToMove == Side.white ? 'w' : 'b';
    fen += ' ';
    if (whiteKingSideCasttle) {
      fen += 'K';
    }
    if (whiteQueenSideCasttle) {
      fen += 'Q';
    }
    if (blackKingSideCasttle) {
      fen += 'k';
    }
    if (blackQueenSideCasttle) {
      fen += 'q';
    }
    if (fen.endsWith(' ')) {
      fen += '-';
    }
    fen += ' ';
    fen += enPassant?.algebraic ?? '-';
    fen += ' ';
    fen += halfMoveClock.toString();
    fen += ' ';
    fen += fullMoveNumber.toString();
    print('**FEN** $fen');
    return fen;
  }

  /// The side (color) to move next.
  Side sideToMove;

  /// Whether white can castle queenside.
  bool whiteQueenSideCasttle;

  /// Whether white can castle kingside.
  bool whiteKingSideCasttle;

  /// Whether black can castle queenside.
  bool blackQueenSideCasttle;

  /// Whether black can castle kingside.
  bool blackKingSideCasttle;

  /// The en passant target square, if any.
  Coordinate? enPassant;

  /// The number of half moves since the last capture or pawn move.
  int halfMoveClock;

  /// The number of full moves in the game.
  int fullMoveNumber;

  /// The grid of squares representing the board state.
  List<List<SquareData>> squareGrid;
}
