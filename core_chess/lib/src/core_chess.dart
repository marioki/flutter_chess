import 'package:chess_shared/chess_shared.dart';

class CoreChess {
  /// {@macro core_chess}
  CoreChess();

  String makeMove(String fen, String lanMove) {
    final gamePosition = GamePosition.fromFEN(fen);
    final move = Move.fromLan(lan: lanMove);
    try {
      if (!isValidMove(gamePosition, move)) {
        print('Invalid move');
        return fen;
      }

      final newGamePosition = applyMove(gamePosition, move);
      newGamePosition.fullMoveNumber++;
      newGamePosition.halfMoveClock = 0;
      if (newGamePosition.sideToMove == Side.white) {
        newGamePosition.sideToMove = Side.black;
      } else {
        newGamePosition.sideToMove = Side.white;
      }
      return newGamePosition.toFenString();
    } catch (e) {
      print('Invalid Move');
      return fen;
    }
  }

  /// Applies a move to the board state and returns the new board state.
  ///
  /// [GamePosition] The current board state.
  /// [move] The move to apply.
  GamePosition applyMove(GamePosition gamePosition, Move move) {
    final originCoordinate = move.origin;
    final targetCoordinate = move.target;
    final originSquare = gamePosition.squareGrid[originCoordinate.rank][originCoordinate.file];
    final piece = originSquare.piece;
    final potientialTargetCoordinates =
        piece!.getPotientialTargetCoordinate(gamePosition, originCoordinate);

    if (!potientialTargetCoordinates.contains(targetCoordinate)) {
      throw Exception('Invalid move');
    }

    final newGamePosition = gamePosition.copyWith();
    newGamePosition.squareGrid[targetCoordinate.rank][targetCoordinate.file] = SquareData(
      piece,
      coordinate: targetCoordinate,
    );
    newGamePosition.squareGrid[originCoordinate.rank][originCoordinate.file] = SquareData(
      null,
      coordinate: originCoordinate,
    );
    return newGamePosition;
  }

  /// Returns a list of possible moves for a piece at the given AN square.
  ///
  /// [fen] The current FEN string.
  /// [anSquare] The algebraic notation square of the selected piece.
  List<String> getLegalMoves(String fen, String anSquare) {
    final gamePosition = GamePosition.fromFEN(fen);
    final originCoordinate = Coordinate.fromAlgebraic(anSquare);
    final originSquareData = gamePosition.squareGrid[originCoordinate.rank][originCoordinate.file];

    if (originSquareData.piece == null) {
      print('No piece at the given square');
      return [];
    }

    final potentialTargetCoordinates =
        originSquareData.piece!.getPotientialTargetCoordinate(gamePosition, originCoordinate)
          ..removeWhere(
            (targetCoordinate) {
              final move = Move(
                chessPiece: originSquareData.piece!,
                origin: originCoordinate,
                target: targetCoordinate,
              );
              return !isValidMove(gamePosition, move);
            },
          );

    final strings = potentialTargetCoordinates.map(
      (e) {
        return e.algebraic;
      },
    ).toList();

    return strings;
  }

  /// Checks if a move is valid according to the rules of chess.
  ///
  /// [GamePosition] The current board state.
  /// [move] The move to validate.
  bool isValidMove(GamePosition gamePosition, Move move) {
    /**
     * Rules to validate
     * 1. Check if the moving piece exposes the king to check.
     * 
     */
    print(move);
    final futureGamePosition = applyMove(gamePosition, move);
    final ownKingCoordinate = getOwnKingCoordinate(futureGamePosition);

    return !isKingInCheck(futureGamePosition, ownKingCoordinate);
  }

  Coordinate getOwnKingCoordinate(GamePosition gamePosition) {
    final board = gamePosition.squareGrid;
    for (int rank = 0; rank < 8; rank++) {
      for (int file = 0; file < 8; file++) {
        final squareData = board[rank][file];
        if (squareData.piece?.pieceType == PieceType.king &&
            squareData.piece?.side == gamePosition.sideToMove) {
          print('Own King found at ${squareData.coordinate.algebraic}');
          return Coordinate(rank: rank, file: file);
        }
      }
    }
    throw Exception('King not found');
  }

  bool isKingInCheck(GamePosition gamePosition, Coordinate ownKingCoordinate) {
    final board = gamePosition.squareGrid;
    bool isInCheck = false;
    for (int rank = 0; rank < 8; rank++) {
      for (int file = 0; file < 8; file++) {
        final squareData = board[rank][file];
        if (squareData.piece != null && squareData.piece!.side != gamePosition.sideToMove) {
          final potientialTargetCoordinates =
              squareData.piece!.getPotientialTargetCoordinate(gamePosition, squareData.coordinate);
          if (potientialTargetCoordinates.contains(ownKingCoordinate)) {
            return true;
          }
        }
      }
    }
    return false;
  }
}
