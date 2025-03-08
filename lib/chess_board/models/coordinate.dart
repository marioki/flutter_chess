// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Coordinate extends Equatable {
  final int _file;
  final int _rank;

  const Coordinate({
    required int file,
    required int rank,
  })  : _rank = rank,
        _file = file;

  String get displayRank => (_rank + 1).toString();
  String get displayFile => String.fromCharCode(_file + 97);

  String get algebraic => '$displayFile$displayRank';

  @override
  List<Object?> get props => [displayFile, _rank];
}
