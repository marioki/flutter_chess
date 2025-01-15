import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chess/chess_board/bloc/board_bloc.dart';
import 'package:flutter_chess/chess_board/widgets/piece.dart';
import 'package:flutter_chess/models/coordinate.dart';
import 'package:flutter_chess/models/piece.dart';

class BoardSquare extends StatelessWidget {
  const BoardSquare({
    required this.row,
    required this.col,
    required this.piece,
    required this.isLight,
    this.isHighLighted = false,
    super.key,
  });
  final int row;
  final int col;
  final Piece? piece;
  final bool isLight;
  final bool isHighLighted;

  @override
  Widget build(BuildContext context) {
    return DragTarget<Piece>(
      builder: (context, candidateData, rejectedData) {
        return Stack(
          children: [
            if (isHighLighted) Container(color: Colors.green.withAlpha(150)) else Container(),
            Container(
              width: double.maxFinite,
              height: double.maxFinite,
              color: isLight ? Colors.brown[300] : Colors.brown[700],
              child: piece != null
                  ? Draggable<Piece>(
                      data: piece,
                      feedback: PieceWidget(piece: piece!),
                      childWhenDragging: Container(), // Empty square while dragging
                      child: PieceWidget(piece: piece!),
                    )
                  : Text('$row, $col'),
            ),
          ],
        );
      },
      onAcceptWithDetails: (pieceDraggable) {
        // Here we send the event to the bloc
        BlocProvider.of<BoardBloc>(context).add(
          BoardPieceMoved(
            target: Coordinate(file: col, rank: row),
            piece: pieceDraggable.data,
          ),
        );
      },
    );
  }
}
