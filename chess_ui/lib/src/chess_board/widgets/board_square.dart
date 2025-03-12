// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chess_ui/src/chess_board/models/move.dart';
import 'package:chess_ui/src/chess_board/models/square.dart';
import 'package:chess_ui/src/chess_board/widgets/widgets.dart';
import 'package:flutter/material.dart';

class BoardSquare extends StatelessWidget {
  const BoardSquare({
    required this.squareData,
    required this.isLight,
    required this.onMove,
    required this.onSelectPiece,
    super.key,
  });
  final SquareData squareData;
  final bool isLight;

  final void Function(String) onMove;
  final void Function(String) onSelectPiece;

  @override
  Widget build(BuildContext context) {
    return DragTarget<SquareData>(
      builder: (context, candidateData, rejectedData) {
        return Stack(
          children: [
            Container(
              width: double.maxFinite,
              height: double.maxFinite,
              color: isLight
                  ? const Color.fromRGBO(69, 123, 157, 1)
                  : const Color.fromRGBO(241, 250, 250, 1),
              child: Text(
                  '${squareData.coordinate.displayFile}, ${squareData.coordinate.displayRank}, '),
            ),
            if (squareData.isHighLighted)
              Container(color: Colors.green.withAlpha(100))
            else
              Container(),
            if (squareData.piece != null)
              Draggable<SquareData>(
                data: squareData,
                feedback: PieceWidget(piece: squareData.piece!),
                dragAnchorStrategy:
                    (Draggable<Object> draggable, BuildContext context, Offset position) {
                  final renderBox = context.findRenderObject()! as RenderBox;
                  final size = renderBox.size;
                  final centerOffset = Offset(size.height / 8, size.width / 8);
                  return centerOffset;
                },

                onDragStarted: () {
                  //for selected piece events
                  onSelectPiece(squareData.coordinate.algebraic);
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
        if (pieceDraggable.data.coordinate == squareData.coordinate) {
          return;
        }
        //for move events
        final lanMove = Move(
          chessPiece: pieceDraggable.data.piece!,
          origin: pieceDraggable.data.coordinate,
          target: squareData.coordinate,
        );
        onMove(lanMove.toString());
      },
    );
  }
}
