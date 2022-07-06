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

  static List<MovieGenresModel> fromJsonList(List<dynamic> jsonList) {
    List<MovieGenresModel> listGenres = [];
    for (var json in jsonList) {
      listGenres.add(MovieGenresModel.fromJson(json));
    }
    return listGenres;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
