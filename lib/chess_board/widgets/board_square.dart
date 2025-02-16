import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chess/chess_board/bloc/board_bloc.dart';
import 'package:flutter_chess/chess_board/widgets/piece.dart';
import 'package:flutter_chess/chess_board/models/coordinate.dart';
import 'package:flutter_chess/chess_board/models/piece.dart';
import 'package:flutter_chess/chess_board/models/square.dart';

class BoardSquare extends StatelessWidget {
  const BoardSquare({
    required this.squareData,
    required this.isLight,
    super.key,
  });
  final SquareData squareData;
  final bool isLight;

  @override
  Widget build(BuildContext context) {
    return DragTarget<ChessPiece>(
      builder: (context, candidateData, rejectedData) {
        return Stack(
          children: [
            Container(
              width: double.maxFinite,
              height: double.maxFinite,
              color: isLight
                  ? const Color.fromRGBO(69, 123, 157, 1)
                  : const Color.fromRGBO(241, 250, 250, 1),
              //child: Text('${squareData.coordinate.file}, ${squareData.coordinate.rank}, '),
            ),
            if (squareData.isHighLighted)
              Container(color: Colors.green.withAlpha(100))
            else
              Container(),
            if (squareData.piece != null)
              Draggable<ChessPiece>(
                data: squareData.piece,
                feedback: PieceWidget(piece: squareData.piece!),
                dragAnchorStrategy:
                    (Draggable<Object> draggable, BuildContext context, Offset position) {
                  final renderBox = context.findRenderObject()! as RenderBox;
                  final size = renderBox.size;
                  final centerOffset = Offset(size.height / 8, size.width / 8);
                  return centerOffset;
                },
                onDragStarted: () {
                  BlocProvider.of<BoardBloc>(context)
                      .add(BoardPieceSelected(piece: squareData.piece!));
                },
                childWhenDragging: Container(), // Empty square while dragging
                child: SizedBox.expand(
                  child: PieceWidget(piece: squareData.piece!),
                ),
              )
            else
              Container(),
          ],
        );
      },
      onAcceptWithDetails: (pieceDraggable) {
        BlocProvider.of<BoardBloc>(context).add(
          BoardPieceMoved(
            target: squareData,
            piece: pieceDraggable.data,
          ),
        );
      },
    );
  }
}
