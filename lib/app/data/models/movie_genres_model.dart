import 'package:show_movie_app/app/domain/entities/movie_genres_entity.dart';

class MovieGenresModel extends MovieGenresEntity {
  const MovieGenresModel({
    required int id,
    required String name,
  }) : super(
          id: id,
          name: name,
        );

  factory MovieGenresModel.fromJson(Map<String, dynamic> json) {
    return MovieGenresModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
