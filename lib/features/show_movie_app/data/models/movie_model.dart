import 'package:show_movie_app/features/show_movie_app/domain/entities/movie_entity.dart';

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
      posterPath: json['posterPath'],
      releaseDate: json['releaseDate'],
      title: json['title'],
      voteAverage: double.parse(json['voteAverage'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'posterPath': posterPath,
      'releaseDate': releaseDate,
      'title': title,
      'voteAverage': voteAverage
    };
  }
}
