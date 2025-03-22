import 'package:chess_shared/chess_shared.dart';

class CoreChess {
  /// {@macro core_chess}
  CoreChess();

  /// Makes a move and returns the new FEN string.
  ///
  /// [fen] The current FEN string.
  /// [lanMove] The move in Long Algebraic Notation (LAN).
  /// Throws an exception if the move is not valid.
  // String makeMove(String fen, String lanMove) {
  //   final gamePosition = GamePosition.fromFEN(fen);
  //   final move = Move.fromLan(lanMove);
  //   if (!isValidMove(gamePosition, move)) {
  //     throw Exception('Invalid move');
  //   }
  //   final newGamePosition = applyMove(gamePosition, move);
  //   return fenFromGamePosition(newGamePosition);
  // }

  /// Returns a list of possible moves for a piece at the given AN square.
  ///
  /// [fen] The current FEN string.
  /// [anSquare] The algebraic notation square of the selected piece.
  List<String> getLegalMoves(String fen, String anSquare) {
    final gamePosition = GamePosition.fromFEN(fen);
    final coordinate = Coordinate.fromAlgebraic(anSquare);
    final squareData = gamePosition.squareGrid[coordinate.file][coordinate.rank];
    final moves = <Move>[];

    if (squareData.piece == null) {
      return [];
    }

    squareData.piece!.getPotientialTargetCoordinate(gamePosition, coordinate).forEach(
      (element) {
        moves.add(
          Move.fromCoordinates(
            chessPiece: squareData.piece!,
            origin: coordinate,
            target: element,
          ),
        );
      },
    );
    return moves.map((move) => move.lan).toList();
  }
}

/// Converts a [GamePosition] object to a FEN string.
///
/// [GamePosition] The board state to convert.
String fenFromGamePosition(GamePosition gamePosition) {
  // Implementation to convert GamePosition to FEN string
  // ...
  return '';
}

/// Checks if a move is valid according to the rules of chess.
///
/// [GamePosition] The current board state.
/// [move] The move to validate.
bool isValidMove(GamePosition gamePosition, Move move) {
  return true;
}

/// Applies a move to the board state and returns the new board state.
///
/// [GamePosition] The current board state.
/// [move] The move to apply.
GamePosition applyMove(GamePosition gamePosition, Move move) {
  // Implementation to apply the move and return the new board state
  // ...
  return gamePosition;
}

/// Generates a list of possible moves for a piece at the given coordinate.
///
/// [GamePosition] The current board state.
/// [coordinate] The coordinate of the selected piece.
List<String> generatePossibleMoves(GamePosition gamePosition, Coordinate coordinate) {
  final possibleMoves = <Coordinate>[];
  final squareData = gamePosition.squareGrid[coordinate.file][coordinate.rank];

  squareData.piece?.getPotientialTargetCoordinate(gamePosition, coordinate);

  return [];
}
