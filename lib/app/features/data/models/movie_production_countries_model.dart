import 'package:show_movie_app/app/features/domain/entities/movie_production_countries_entity.dart';

class MovieProductionCountriesModel extends MovieProductionCountriesEntity {
  const MovieProductionCountriesModel({
    required super.iso31611,
    required super.name,
  });
  factory MovieProductionCountriesModel.fromJson(Map<String, dynamic> json) {
    return MovieProductionCountriesModel(
      iso31611: json['iso_3166_1'],
      name: json['name'],
    );
  }

  static List<MovieProductionCountriesModel> fromJsonList(
    List<dynamic> jsonList,
  ) {
    List<MovieProductionCountriesModel> listProductionCountries = [];
    for (var json in jsonList) {
      listProductionCountries.add(MovieProductionCountriesModel.fromJson(json));
    }
    return listProductionCountries;
  }

  Map<String, dynamic> toJson() {
    return {'iso_3166_1': iso31611, 'name': name};
  }
}
