// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Coordinate extends Equatable {
  final int file;
  final int rank;

  const Coordinate({
    required this.file,
    required this.rank,
  });

  @override
  List<Object?> get props => [file, rank];
}
