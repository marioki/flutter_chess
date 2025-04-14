import 'package:chess_shared/chess_shared.dart';

class CoreChess {
  /// {@macro core_chess}
  CoreChess();

  GameData makeMove(String fen, String lanMove) {
    final gamePosition = GamePosition.fromFEN(fen);
    final move = Move.fromLan(lan: lanMove);

    // if (piece == null) {
    //   throw Exception('No piece at the origin square');
    // }

    // if (piece.side != gamePosition.sideToMove) {
    //   throw Exception('Not your turn');
    // }

    // if (gamePosition.squareGrid[targetCoordinate.rank][targetCoordinate.file].piece?.side ==
    //     gamePosition.sideToMove) {
    //   throw Exception('Cannot capture your own piece');
    // }

    // Validate the move using the piece's move set

    if (!isMoveValid(gamePosition, move)) {
      throw Exception('Invalid move for the piece');
    }

    validateMoveByLegality(gamePosition, move);

    final newGamePosition = applyMove(gamePosition, move);

    newGamePosition.fullMoveNumber++;
    newGamePosition.halfMoveClock++;

    if (newGamePosition.sideToMove == Side.white) {
      newGamePosition.sideToMove = Side.black;
    } else {
      newGamePosition.sideToMove = Side.white;
    }

    return generateGameData(newGamePosition);
  }

  GameData generateGameData(GamePosition gamePosition) {
    if (gamePosition.halfMoveClock >= 50) {
      print('Draw by 50-move rule');
      return GameData(
        fen: gamePosition.toFenString(),
        status: GameStatus.draw,
      );
    }

    if (isKingInMate(gamePosition)) {
      return GameData(
        fen: gamePosition.toFenString(),
        status: GameStatus.checkmate,
        winner: gamePosition.sideToMove == Side.white ? Side.black : Side.white,
      );
    }

    return GameData(
      fen: gamePosition.toFenString(),
      status: GameStatus.playing,
    );
  }

  bool isKingInMate(GamePosition gamePosition) {
    final ownKingCoordinate = getOwnKingCoordinate(gamePosition);
    if (isKingInCheck(gamePosition, ownKingCoordinate)) {
      // Check if there are any legal moves for the current player
      final potentialMoves = <Move>[];
      for (int rank = 0; rank < 8; rank++) {
        for (int file = 0; file < 8; file++) {
          final squareData = gamePosition.squareGrid[rank][file];
          if (squareData.piece?.side == gamePosition.sideToMove) {
            final piece = squareData.piece!;
            final potentialTargetCoordinates =
                piece.getPotientialTargetCoordinate(gamePosition, squareData.coordinate);
            for (var targetCoordinate in potentialTargetCoordinates) {
              final move = Move(
                chessPiece: piece,
                origin: squareData.coordinate,
                target: targetCoordinate,
              );
              if (!isKingInCheck(gamePosition, ownKingCoordinate)) {
                potentialMoves.add(move);
              }
            }
          }
        }
      }
      if (potentialMoves.isEmpty) {
        return true;
      }
    }
    return false;
  }

  bool isMoveValid(GamePosition gamePosition, Move move) {
    final originCoordinate = move.origin;
    final targetCoordinate = move.target;
    final originSquare = gamePosition.squareGrid[originCoordinate.rank][originCoordinate.file];
    final piece = originSquare.piece;

    final potentialTargetCoordinates =
        piece!.getPotientialTargetCoordinate(gamePosition, originCoordinate);
    if (!potentialTargetCoordinates.contains(targetCoordinate)) {
      return false;
    } else {
      return true;
    }
  }

  void validateMoveByLegality(GamePosition gamePosition, Move move) {
    /**
     * Rules to validate
     * 1. Check if the moving piece exposes the king to check.
     * 
     */

    final futureGamePosition = applyMove(gamePosition, move);
    final ownKingCoordinate = getOwnKingCoordinate(futureGamePosition);

    if (isKingInCheck(futureGamePosition, ownKingCoordinate)) {
      throw Exception('Move exposes the king to check');
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
  List<String> getLegalMovesForPiece(String fen, String anSquare) {
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
              return !isMoveValid(gamePosition, move);
            },
          );

    final strings = potentialTargetCoordinates.map(
      (e) {
        return e.algebraic;
      },
    ).toList();

    return strings;
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

  Coordinate getKingCoordinates(GamePosition gamePosition, Side side) {
    final board = gamePosition.squareGrid;
    for (int rank = 0; rank < 8; rank++) {
      for (int file = 0; file < 8; file++) {
        final squareData = board[rank][file];
        if (squareData.piece?.pieceType == PieceType.king && squareData.piece?.side == side) {
          print('$side King found at ${squareData.coordinate.algebraic}');
          return Coordinate(rank: rank, file: file);
        }
      }
    }
    throw Exception('King not found');
  }

  bool isKingInCheck(GamePosition gamePosition, Coordinate ownKingCoordinate) {
    final board = gamePosition.squareGrid;
    for (var rank = 0; rank < 8; rank++) {
      for (var file = 0; file < 8; file++) {
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
