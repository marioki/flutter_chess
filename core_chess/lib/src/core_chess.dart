import 'package:chess_shared/chess_shared.dart';

class CoreChess {
  /// {@macro core_chess}
  CoreChess();

  /// Makes a move and returns the new FEN string.
  ///
  /// [fen] The current FEN string.
  /// [lanMove] The move in Long Algebraic Notation (LAN).
  /// Throws an exception if the move is not valid.
  String makeMove(String fen, String lanMove) {
    final gamePosition = GamePosition.fromFEN(fen);
    final move = Move.fromLan(lanMove);
    if (!isValidMove(gamePosition, move)) {
      throw Exception('Invalid move');
    }
    final newGamePosition = applyMove(gamePosition, move);
    return fenFromGamePosition(newGamePosition);
  }

  /// Returns a list of possible moves for a piece at the given AN square.
  ///
  /// [fen] The current FEN string.
  /// [anSquare] The algebraic notation square of the selected piece.
  List<String> getPossibleMovesForPiece(String fen, String anSquare) {
    final gamePosition = GamePosition.fromFEN(fen);
    final coordinate = Coordinate.fromAlgebraic(anSquare);
    return generatePossibleMoves(gamePosition, coordinate!);
  }
}

/// Converts a [GamePosition] object to a FEN string.
///
/// [GamePosition] The board state to convert.
String fenFromGamePosition(GamePosition gamePosition) {
  // Implementation to convert GamePosition to FEN string
  // ...
  return '';
}

/// Checks if a move is valid according to the rules of chess.
///
/// [GamePosition] The current board state.
/// [move] The move to validate.
bool isValidMove(GamePosition GamePosition, Move move) {
  // Implementation to validate the move
  // ...
  return true;
}

/// Applies a move to the board state and returns the new board state.
///
/// [GamePosition] The current board state.
/// [move] The move to apply.
GamePosition applyMove(GamePosition GamePosition, Move move) {
  // Implementation to apply the move and return the new board state
  // ...
  return GamePosition;
}

/// Generates a list of possible moves for a piece at the given coordinate.
///
/// [GamePosition] The current board state.
/// [coordinate] The coordinate of the selected piece.
List<String> generatePossibleMoves(GamePosition GamePosition, Coordinate coordinate) {
  // Implementation to generate possible moves
  // ...
  return [];
}

/// Represents a move in Long Algebraic Notation (LAN).
class Move {
  /// Creates a [Move] from a String LAN notation.
  Move.fromLan(String lan) {
    // Implementation to parse LAN notation and create Move
    // ...
  }
}

/// Represents a coordinate on the chess board.
class Coordinate {
  final int file;
  final int rank;

  Coordinate({required this.file, required this.rank});

  /// Converts an algebraic notation square (e.g., 'e4') to a [Coordinate].
  ///
  /// Returns `null` if the input is '-'.
  ///
  /// [an] The algebraic notation square.
  static Coordinate? fromAlgebraic(String an) {
    if (an == '-') {
      return null;
    }
    const boardLetters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];
    final file = boardLetters.indexOf(an[0]);
    final rank = int.parse(an[1]) - 1;
    return Coordinate(file: file, rank: rank);
  }

  /// Returns the algebraic notation of the coordinate.
  String get algebraic {
    const boardLetters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];
    return '${boardLetters[file]}${rank + 1}';
  }
}

enum PieceType { pawn, knight, bishop, rook, queen, king }

enum PieceColor { white, black }

class Piece {
  Piece({
    required this.type,
    required this.color,
  });

  PieceType type;
  PieceColor color;
}
