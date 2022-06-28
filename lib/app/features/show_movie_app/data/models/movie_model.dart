import 'package:show_movie_app/app/features/show_movie_app/domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  const MovieModel({
    required String posterPath,
    required String releaseDate,
    required String title,
    required double voteAverage,
  }) : super(
            posterPath: posterPath,
            releaseDate: releaseDate,
            title: title,
            voteAverage: voteAverage);

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
        posterPath: json['poster_path'] as String,
        releaseDate: json['release_date'] as String,
        title: json['title'] as String,
        voteAverage: double.parse(json['vote_average'].toString()));
  }

  Map<String, dynamic> toJson() {
    return {
      'poster_path': posterPath,
      'release_date': releaseDate,
      'title': title,
      'vote_average': voteAverage
    };
  }
}
