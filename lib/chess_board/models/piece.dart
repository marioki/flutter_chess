// ignore_for_file: public_member_api_docs, sort_constructors_first

enum Side { white, black }

enum PieceType { pawn, rook, knight, bishop, queen, king }

class ChessPiece {
  ChessPiece({
    required this.type,
    required this.color,
  });
  final PieceType type;
  final Side color;
}
