import 'package:chess_shared/chess_shared.dart';

/// Represents a chess move in Long Algebraic Notation (LAN).
class Move {
  /// Creates a [Move] with the given [pieceType], [origin], and [target].
  Move({
    required this.pieceType,
    required this.origin,
    required this.target,
    this.selectedPromotionPiece,
  });

  Move.fromCoordinates({
    required this.pieceType,
    required Coordinate origin,
    required Coordinate target,
    this.selectedPromotionPiece,
  })  : origin = Coordinate(file: origin.file, rank: origin.rank),
        target = Coordinate(file: target.file, rank: target.rank);

  Move.fromLAN(String lanMove)
      : pieceType = (lanMove.length == 4 || lanMove.contains('='))
            ? PieceType.pawn
            : chessPieceTypeFromLanMove(lanMove[0]),
        selectedPromotionPiece = lanMove.contains('=')
            ? chessPieceTypeFromLanMove(lanMove[lanMove.indexOf('=') + 1])
            : null,
        origin = (lanMove.length == 4 || lanMove.contains('='))
            ? Coordinate.fromAlgebraic(lanMove.substring(0, 2))
            : Coordinate.fromAlgebraic(lanMove.substring(1, 3)),
        target = (lanMove.length == 4 || lanMove.contains('='))
            ? Coordinate.fromAlgebraic(lanMove.substring(2, 4))
            : Coordinate.fromAlgebraic(lanMove.substring(3));

  /// The chess piece being moved.
  final PieceType pieceType;

  /// The origin coordinate of the chess piece.
  final Coordinate origin;

  /// The target coordinate of the chess piece.
  final Coordinate target;

  /// The piece type to promote to, if applicable.
  final PieceType? selectedPromotionPiece;

  /// Returns the move in Long Algebraic Notation (LAN).
  String get lan {
    return '${getPieceTypeString(pieceType)}${origin.algebraic}${target.algebraic}';
  }

  @override
  String toString() {
    return lan;
  }
}

String getPieceTypeString(PieceType pieceType) {
  switch (pieceType) {
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
