import 'package:show_movie_app/app/domain/entities/movie_production_countries_entity.dart';

class MovieProductionCountriesModel extends MovieProductionCountriesEntity {
  const MovieProductionCountriesModel({
    required iso31611,
    required name,
  }) : super(
          iso31611: iso31611,
          name: name,
        );
  factory MovieProductionCountriesModel.fromJson(Map<String, dynamic> json) {
    return MovieProductionCountriesModel(
      iso31611: json['iso31611'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'iso31611': iso31611,
      'name': name,
    };
  }
}
