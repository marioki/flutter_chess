import 'package:equatable/equatable.dart';

/// Represents a coordinate on a chess board.
///
/// A coordinate is defined by its file (column) and rank (row),
/// where the file is represented as a letter ('a' to 'h') and
/// the rank is represented as a number (1 to 8).
class Coordinate extends Equatable {
  /// Creates a [Coordinate] with the given [file] and [rank].
  const Coordinate({
    required this.file,
    required this.rank,
  });
  final int file;
  final int rank;

  /// Converts an algebraic notation square (e.g., 'e4') to a [Coordinate].
  ///
  /// Returns `null` if the input is '-'.
  ///
  /// [an] The algebraic notation square to convert.
  /// Throws a [FormatException] if the input is not valid algebraic notation.
  static Coordinate fromAlgebraic(String an) {
    if (an == '-') {
      throw ArgumentError('Invalid algebraic notation $an');
    }
    const boardLetters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];
    final file = boardLetters.indexOf(an[0]);
    final rank = int.parse(an[1]) - 1;
    return Coordinate(file: file, rank: rank);
  }

  /// Returns the rank (row) of the coordinate as a string (1-based).
  ///
  /// For example, if the rank is 0 (0-based), this will return '1'.
  String get displayRank => (rank + 1).toString();

  /// Returns the file (column) of the coordinate as a string (e.g., 'a').
  ///
  /// For example, if the file is 0 (0-based), this will return 'a'.
  String get displayFile => String.fromCharCode(file + 97);

  /// Returns the algebraic notation of the coordinate (e.g., 'e4').
  ///
  /// Combines the file and rank into a standard chess notation string.
  String get algebraic => '$displayFile$displayRank';

  @override
  List<Object?> get props => [displayFile, rank];
}
