// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'game_bloc.dart';

class GameState extends Equatable {
  const GameState({
    required this.fen,
    this.possibleMoves = const [],
  });

  final String fen;
  final List<String> possibleMoves;

  @override
  List<Object?> get props => [fen, possibleMoves];

  GameState copyWith({
    String? fen,
    List<String>? possibleMoves,
  }) {
    return GameState(
      fen: fen ?? this.fen,
      possibleMoves: possibleMoves ?? this.possibleMoves,
    );
  }
}
