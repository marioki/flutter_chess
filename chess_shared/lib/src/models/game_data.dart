// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chess_shared/chess_shared.dart';

class GameData {
  final String fen;
  final GameStatus status;
  final Side? winner;
  GameData({
    required this.fen,
    required this.status,
    this.winner,
  });

  GameData copyWith({
    String? fen,
    GameStatus? status,
    Side? winner,
  }) {
    return GameData(
      fen: fen ?? this.fen,
      status: status ?? this.status,
      winner: winner ?? this.winner,
    );
  }
}

enum GameStatus {
  playing,
  pawnPromotion,
  checkmate,
  draw,
}
