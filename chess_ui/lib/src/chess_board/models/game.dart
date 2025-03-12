import 'package:chess_ui/src/chess_board/helpers/parse_fen_string.dart';
import 'package:chess_ui/src/chess_board/models/coordinate.dart';
import 'package:chess_ui/src/chess_board/models/piece.dart';
import 'package:chess_ui/src/chess_board/models/square.dart';

/// Represents the state of a chess game.
class Game {
  /// Creates a [Game] with the given parameters.
  Game({
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

  /// Creates a [Game] from a FEN string.
  ///
  /// [fen] The FEN string representing the game state.
  factory Game.fromFEN(String fen) {
    final fenSegments = fen.split(' ');
    final piecesSegment = fenSegments[0];
    final sideToMoveSegment = fenSegments[1];
    final castleSegment = fenSegments[2];
    final enPassantSegment = fenSegments[3];
    final halfMoveClockSegment = fenSegments[4];
    final fullMoveClockSegment = fenSegments[5];

    return Game(
      squareGrid: createSquareGrid(piecesSegment),
      sideToMove: sideToMoveSegment == 'w' ? Side.white : Side.black,
      whiteQueenSideCasttle: castleSegment.contains('Q'),
      whiteKingSideCasttle: castleSegment.contains('K'),
      blackQueenSideCasttle: castleSegment.contains('q'),
      blackKingSideCasttle: castleSegment.contains('k'),
      halfMoveClock: int.parse(halfMoveClockSegment),
      fullMoveNumber: int.parse(fullMoveClockSegment),
      enPassant: Coordinate.fromAlgebraic(enPassantSegment),
    );
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
