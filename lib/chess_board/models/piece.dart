// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_chess/chess_board/helpers/parse_fen_string.dart';
import 'package:flutter_chess/chess_board/view/view.dart';

enum Side { white, black }

enum PieceType { pawn, rook, knight, bishop, queen, king }

class ChessPiece {
  ChessPiece({
    required this.type,
    required this.color,
    //required this.currentPosition,
  });
  final PieceType type;
  final Side color;
  //final Coordinate currentPosition;

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}
