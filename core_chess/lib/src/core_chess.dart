import 'package:chess_shared/chess_shared.dart';

class CoreChess {
  /// {@macro core_chess}
  CoreChess();

  GameData makeMove(String fen, String lanMove) {
    final gamePosition = GamePosition.fromFEN(fen);
    final move = Move.fromLAN(lanMove);

    // Validate the move using the piece's move set

    if (!isMoveValid(gamePosition, move)) {
      throw Exception('Invalid move for the piece');
    }

    if (!isMoveLegal(gamePosition, move)) {
      throw Exception('Move exposes the king to check');
    }

    final newGamePosition = applyMove(gamePosition, move);

    // Setting up en passant target square
    if (move.pieceType == PieceType.pawn && (move.origin.rank - move.target.rank).abs() == 2) {
      if (gamePosition.sideToMove == Side.white) {
        newGamePosition.enPassant = Coordinate(
          file: move.target.file,
          rank: move.target.rank - 1,
        );
      } else {
        newGamePosition.enPassant = Coordinate(
          file: move.target.file,
          rank: move.target.rank + 1,
        );
      }
    } else {
      // Reset en passant target square if the move is not a double pawn move
      newGamePosition.enPassant = null;
    }

    //TODO: Add logic for updating move clocks correctly
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
    //Check for game ending conditions
    if (gamePosition.halfMoveClock >= 50) {
      print('Draw by 50-move rule');
      return GameData(
        fen: gamePosition.toFenString(),
        status: GameStatus.draw,
      );
    }

    // Check for stalemate
    if (!isKingInCheck(gamePosition, getOwnKingCoordinate(gamePosition))) {
      final potentialMoves = <Move>[];
      for (var rank = 0; rank < 8; rank++) {
        for (var file = 0; file < 8; file++) {
          final squareData = gamePosition.squareGrid[rank][file];
          if (squareData.piece?.side == gamePosition.sideToMove) {
            final piece = squareData.piece!;
            final potentialTargetCoordinates =
                piece.getPotientialTargetCoordinate(gamePosition, squareData.coordinate);
            for (final targetCoordinate in potentialTargetCoordinates) {
              final move = Move(
                pieceType: piece.pieceType,
                origin: squareData.coordinate,
                target: targetCoordinate,
              );

              if (isMoveLegal(gamePosition, move)) {
                potentialMoves.add(move);
              }
            }
          }
        }
      }
      if (potentialMoves.isEmpty) {
        return GameData(
          fen: gamePosition.toFenString(),
          status: GameStatus.stalemate,
        );
      }
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
      for (var rank = 0; rank < 8; rank++) {
        for (var file = 0; file < 8; file++) {
          final squareData = gamePosition.squareGrid[rank][file];
          if (squareData.piece?.side == gamePosition.sideToMove) {
            final piece = squareData.piece!;
            final potentialTargetCoordinates =
                piece.getPotientialTargetCoordinate(gamePosition, squareData.coordinate);
            for (var targetCoordinate in potentialTargetCoordinates) {
              final move = Move(
                pieceType: piece.pieceType,
                origin: squareData.coordinate,
                target: targetCoordinate,
              );

              if (isMoveLegal(gamePosition, move)) {
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

  bool isMoveLegal(GamePosition gamePosition, Move move) {
    /**
     * Rules to validate
     * 1. Check if the moving piece exposes the king to check.
     * 
     */

    //Special case for castling

    if (isCastlingMove(move)) {
      if (isCastleLegal(gamePosition, move)) {
        return true;
      } else {
        print('Castling is not legal');
        return false;
      }
    }

    final futureGamePosition = applyMove(gamePosition, move);
    final ownKingCoordinate = getOwnKingCoordinate(futureGamePosition);

    return !isKingInCheck(futureGamePosition, ownKingCoordinate);
  }

  bool isCastleLegal(GamePosition gamePosition, Move move) {
    if (isKingInCheck(gamePosition, getKingCoordinates(gamePosition, gamePosition.sideToMove))) {
      print('King is in check, cannot castle');
    }

    if (gamePosition.sideToMove == Side.white) {
      if (move.target.file == 2) {
        if (isKingInCheck(gamePosition, const Coordinate(file: 3, rank: 0)) ||
            isKingInCheck(gamePosition, const Coordinate(file: 2, rank: 0))) {
          return false;
        }
      }
      if (move.target.file == 6) {
        if (isKingInCheck(gamePosition, const Coordinate(file: 5, rank: 0)) ||
            isKingInCheck(gamePosition, const Coordinate(file: 6, rank: 0))) {
          return false;
        }
      }
    } else {
      if (move.target.file == 2) {
        if (isKingInCheck(gamePosition, const Coordinate(file: 3, rank: 7)) ||
            isKingInCheck(gamePosition, const Coordinate(file: 2, rank: 7))) {
          return false;
        }
      }
      if (move.target.file == 6) {
        if (isKingInCheck(gamePosition, const Coordinate(file: 5, rank: 7)) ||
            isKingInCheck(gamePosition, const Coordinate(file: 6, rank: 7))) {
          return false;
        }
      }
    }
    return true;
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

    final newGamePosition = gamePosition.copyWith();
    newGamePosition.squareGrid[targetCoordinate.rank][targetCoordinate.file] = SquareData(
      piece,
      coordinate: targetCoordinate,
    );
    newGamePosition.squareGrid[originCoordinate.rank][originCoordinate.file] = SquareData(
      null,
      coordinate: originCoordinate,
    );

    // Handle en passant capture
    if (move.pieceType == PieceType.pawn && targetCoordinate == gamePosition.enPassant) {
      final capturedPawnCoordinate = Coordinate(
        file: targetCoordinate.file,
        rank: targetCoordinate.rank + (piece!.side == Side.white ? -1 : 1),
      );

      newGamePosition.squareGrid[capturedPawnCoordinate.rank][capturedPawnCoordinate.file] =
          SquareData(null, coordinate: capturedPawnCoordinate);
    }

    // Handle pawn promotion
    if (move.selectedPromotionPiece != null) {
      newGamePosition.squareGrid[move.target.rank][move.target.file] = SquareData(
        chessPieceFromPieceType(move.selectedPromotionPiece!, piece!.side),
        coordinate: move.target,
      );
    }
    // Handle castling
    if (isCastlingMove(move)) {
      if (move.target.file == 2) {
        // Queen-side castling
        newGamePosition.squareGrid[originCoordinate.rank][0] = SquareData(
          null,
          coordinate: Coordinate(rank: originCoordinate.rank, file: 0),
        );
        newGamePosition.squareGrid[originCoordinate.rank][3] = SquareData(
          chessPieceFromPieceType(PieceType.rook, piece!.side),
          coordinate: Coordinate(rank: originCoordinate.rank, file: 3),
        );
      } else if (move.target.file == 6) {
        // King-side castling
        newGamePosition.squareGrid[originCoordinate.rank][7] = SquareData(
          null,
          coordinate: Coordinate(rank: originCoordinate.rank, file: 7),
        );
        newGamePosition.squareGrid[originCoordinate.rank][5] = SquareData(
          chessPieceFromPieceType(PieceType.rook, piece!.side),
          coordinate: Coordinate(rank: originCoordinate.rank, file: 5),
        );
      }
    }

    //Remove castling rights if the king or rook has moved
    if (gamePosition.whiteQueenSideCasttle ||
        gamePosition.whiteKingSideCasttle ||
        gamePosition.blackKingSideCasttle ||
        gamePosition.blackQueenSideCasttle) {
      if (piece!.pieceType == PieceType.king) {
        if (piece.side == Side.white) {
          print('White king moved...Removing All White castling rights');
          newGamePosition
            ..whiteKingSideCasttle = false
            ..whiteQueenSideCasttle = false;
        } else {
          print('black king moved...Removing All Black castling rights');
          newGamePosition
            ..blackKingSideCasttle = false
            ..blackQueenSideCasttle = false;
        }
      } else if (piece.pieceType == PieceType.rook) {
        if (piece.side == Side.white) {
          if (originCoordinate.file == 0) {
            print('White queen side rook moved...Removing White queen side castling rights');
            newGamePosition.whiteQueenSideCasttle = false;
          } else if (originCoordinate.file == 7) {
            print('White king side rook moved...Removing White king side castling rights');
            newGamePosition.whiteKingSideCasttle = false;
          }
        } else {
          if (originCoordinate.file == 0) {
            print('Black queen side rook moved...Removing Black queen side castling rights');
            newGamePosition.blackQueenSideCasttle = false;
          } else if (originCoordinate.file == 7) {
            print('Black king side rook moved...Removing Black king side castling rights');
            newGamePosition.blackKingSideCasttle = false;
          }
        }
      }
    }

    return newGamePosition;
  }

  ChessPiece chessPieceFromPieceType(PieceType pieceType, Side side) {
    switch (pieceType) {
      case PieceType.king:
        return King(side);
      case PieceType.queen:
        return Queen(side);
      case PieceType.rook:
        return Rook(side);
      case PieceType.bishop:
        return Bishop(side);
      case PieceType.knight:
        return Knight(side);
      case PieceType.pawn:
        return Pawn(side);
    }
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
                pieceType: originSquareData.piece!.pieceType,
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
    for (var rank = 0; rank < 8; rank++) {
      for (var file = 0; file < 8; file++) {
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
    for (var rank = 0; rank < 8; rank++) {
      for (var file = 0; file < 8; file++) {
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

  bool isCastlingMove(Move move) {
    if (move.pieceType == PieceType.king &&
        (move.target.file - move.origin.file).abs() == 2 &&
        (move.target.rank - move.origin.rank).abs() == 0) {
      return true;
    } else {
      return false;
    }
  }
}
