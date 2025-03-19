/// Represents the side (color) of a chess piece.
enum Side {
  /// The white side.
  white,

  /// The black side.
  black
}

/// Represents the type of a chess piece.
enum PieceType {
  /// The pawn piece.
  pawn,

  /// The rook piece.
  rook,

  /// The knight piece.
  knight,

  /// The bishop piece.
  bishop,

  /// The queen piece.
  queen,

  /// The king piece.
  king
}

/// Represents a chess piece on the board.
class ChessPiece {
  /// Creates a [ChessPiece] with the given [type] and [color].
  ChessPiece({
    required this.type,
    required this.color,
  });

  /// The type of the chess piece (e.g., pawn, rook, knight).
  final PieceType type;

  /// The color of the chess piece (e.g., white, black).
  final Side color;

  /// Returns the character representation of the chess piece.
  String get pieceCharacter {
    switch (type) {
      case PieceType.pawn:
        return '';
      case PieceType.rook:
        return 'R';
      case PieceType.knight:
        return 'N';
      case PieceType.bishop:
        return 'B';
      case PieceType.queen:
        return 'Q';
      case PieceType.king:
        return 'K';
    }
  }
}
