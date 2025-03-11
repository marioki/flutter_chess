part of 'game_bloc.dart';

sealed class GameState extends Equatable {
  const GameState();
  
  @override
  List<Object> get props => [];
}

final class GameInitial extends GameState {}
