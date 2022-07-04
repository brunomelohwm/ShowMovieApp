import 'package:show_movie_app/app/data/models/movie_production_companies_model.dart';
import 'package:show_movie_app/app/data/models/movie_production_countries_model.dart';
import 'package:show_movie_app/app/domain/entities/movie_detail_entity.dart';

import 'movie_genres_model.dart';

class MovieDetailModel extends MovieDetailEntity {
  const MovieDetailModel({
    required id,
    required genres,
    required originalTitle,
    required overview,
    required productionCompanies,
    required productionCountries,
  }) : super(
            id: id,
            genres: genres,
            originalTitle: originalTitle,
            overview: overview,
            productionCompanies: productionCompanies,
            productionCountries: productionCountries);

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      id: json['id'],
      genres: json['genres'] ? <MovieGenresModel>[] : <MovieGenresModel>[] ,
      originalTitle: json['original_title'],
      overview: json['overview'],
      productionCompanies: json['production_companies']
          ? <MovieProductionCompaniesModel>[]
          : <MovieProductionCompaniesModel>[],
      productionCountries: json['production_countries']
          ? <MovieProductionCountriesModel>[]
          : <MovieProductionCountriesModel>[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'genres': genres,
      'originalTitle': originalTitle,
      'overview': overview,
      'production_companies': productionCompanies,
      'production_countries': productionCountries,
    };
  }
}
