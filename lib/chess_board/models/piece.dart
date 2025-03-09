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
