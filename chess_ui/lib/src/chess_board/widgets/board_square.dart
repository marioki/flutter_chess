// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chess_shared/chess_shared.dart';
import 'package:chess_ui/src/chess_board/widgets/widgets.dart';
import 'package:flutter/material.dart';

class BoardSquare extends StatelessWidget {
  const BoardSquare({
    required this.squareData,
    required this.isLight,
    required this.onMove,
    required this.onSelectPiece,
    required this.sideToMove,
    this.isHighLighted = false,
    super.key,
  });
  final SquareData squareData;
  final bool isLight;
  final bool isHighLighted;
  final Side sideToMove;
  final void Function(String) onMove;
  final void Function(String) onSelectPiece;

  @override
  Widget build(BuildContext context) {
    return DragTarget<SquareData>(
      builder: (context, candidateData, rejectedData) {
        return Stack(
          children: [
            Container(
              color: isLight
                  ? const Color.fromRGBO(69, 123, 157, 1)
                  : const Color.fromRGBO(241, 250, 250, 1),
              child: (squareData.coordinate.file == 0 || squareData.coordinate.rank == 0)
                  ? Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        squareData.coordinate.algebraic,
                        style: TextStyle(
                          color: isLight ? Colors.white : Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : null,
            ),
            if (isHighLighted) Container(color: Colors.green.withAlpha(100)) else Container(),
            if (squareData.piece == null)
              const SizedBox.shrink()
            else if (squareData.piece!.side == sideToMove)
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
              SizedBox.expand(
                child: PieceWidget(piece: squareData.piece!),
              ),
          ],
        );
      },
      onAcceptWithDetails: (pieceDraggable) {
        if (pieceDraggable.data.coordinate == squareData.coordinate) {
          print('same square');
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
