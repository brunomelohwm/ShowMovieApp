import '../../domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  const MovieModel({
    required super.id,
    required super.posterPath,
    required super.releaseDate,
    required super.title,
    required super.voteAverage,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      posterPath: json['poster_path'] as String? ?? '',
      releaseDate: json['release_date'] as String? ?? '',
      title: json['title'] as String? ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'title': title,
      'vote_average': voteAverage,
    };
  }
}
