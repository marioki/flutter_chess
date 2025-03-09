// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../models/lan_move.dart';
import '../models/square.dart';
import 'piece.dart';

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
                  print(squareData.coordinate.algebraic);
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
        final lanMove = LANMove(
          chessPiece: pieceDraggable.data.piece!,
          origin: pieceDraggable.data.coordinate,
          target: squareData.coordinate,
        );

        print(lanMove);
      },
    );
  }
}
