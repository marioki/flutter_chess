import 'package:equatable/equatable.dart';

/// Represents a coordinate on a chess board.
///
/// A coordinate is defined by its file (column) and rank (row),
/// where the file is represented as a letter ('a' to 'h') and
/// the rank is represented as a number (1 to 8).
class Coordinate extends Equatable {
  /// Creates a [Coordinate] with the given [file] and [rank].
  ///
  /// [file] is the 0-based index of the file (column), where 0 represents 'a'.
  /// [rank] is the 0-based index of the rank (row), where 0 represents '1'.
  const Coordinate({
    required int file,
    required int rank,
  })  : _rank = rank,
        _file = file;

  /// The file (column) of the coordinate, represented as an integer (0-based).
  final int _file;
  /**
   * 
   * daddda
   */

  /// The rank (row) of the coordinate, represented as an integer (0-based).
  final int _rank;

  /// Converts an algebraic notation square (e.g., 'e4') to a [Coordinate].
  ///
  /// Returns `null` if the input is '-'.
  ///
  /// [an] The algebraic notation square to convert.
  /// Throws a [FormatException] if the input is not valid algebraic notation.
  static Coordinate? fromAlgebraic(String an) {
    if (an == '-') {
      return null;
    }
    const boardLetters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];
    final file = boardLetters.indexOf(an[0]);
    final rank = int.parse(an[1]) - 1;
    return Coordinate(file: file, rank: rank);
  }

  /// Returns the rank (row) of the coordinate as a string (1-based).
  ///
  /// For example, if the rank is 0 (0-based), this will return '1'.
  String get displayRank => (_rank + 1).toString();

  /// Returns the file (column) of the coordinate as a string (e.g., 'a').
  ///
  /// For example, if the file is 0 (0-based), this will return 'a'.
  String get displayFile => String.fromCharCode(_file + 97);

  /// Returns the algebraic notation of the coordinate (e.g., 'e4').
  ///
  /// Combines the file and rank into a standard chess notation string.
  String get algebraic => '$displayFile$displayRank';

  @override
  List<Object?> get props => [displayFile, _rank];
}
