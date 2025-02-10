// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_chess/chess_board/models/coordinate.dart';
import 'package:flutter_chess/chess_board/models/square.dart';
import 'package:flutter_chess/chess_board/view/view.dart';

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
