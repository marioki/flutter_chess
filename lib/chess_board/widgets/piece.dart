// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Piece extends StatelessWidget {
  const Piece({
    required this.label,
    super.key,
  });
  final String label;
  @override
  Widget build(BuildContext context) {
    return Draggable(
      feedback: Material(
        child: Container(
          decoration: const BoxDecoration(color: Colors.lightBlue),
          child:  Text(label),
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(color: Colors.lightBlue),
        child:  Text(label),
      ),
    );
  }
}
