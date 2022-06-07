import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final String posterPath;
  final String releaseDate;
  final String title;
  final double voteAverage;
  const MovieEntity({
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
  });

  @override
  List<Object> get props => [posterPath, releaseDate, title, voteAverage];
}
