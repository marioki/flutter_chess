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

  /// Converts an algebraic notation square (e.g., 'e4') to a [Coordinate].
  ///
  /// Returns `null` if the input is '-'.
  ///
  /// [an] The algebraic notation square.
  static Coordinate? fromAlgebraic(String an) {
    if (an == '-') {
      return null;
    }
    const boardLetters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];
    final file = boardLetters.indexOf(an[0]);
    final rank = int.parse(an[1]) - 1;
    return Coordinate(file: file, rank: rank);
  }

  String get displayRank => (_rank + 1).toString();
  String get displayFile => String.fromCharCode(_file + 97);

  String get algebraic => '$displayFile$displayRank';

  @override
  List<Object?> get props => [displayFile, _rank];
}
