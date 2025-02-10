/// {@template core_chess}
/// chess engine made in dart
/// {@endtemplate}
class CoreChess {
  /// {@macro core_chess}
  CoreChess({this.fen = _defaultStartingPosition});
  String fen;
  static const _defaultStartingPosition =
      'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1';

  makeMove(String fen, String lanMove) {
    boardStateFromFen();
  }

  getPossibleMovesForPiece() {}
}

///Create a [BoardState] object from a FEN String.
void boardStateFromFen() {}

class Move {
  ///Create a [Move] from a String LAN notation
  Move.fromLan() {}
}

class BoardState {
  // List<List<Piece>> board;
  // (int, int) enPassant;
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
