import 'package:show_movie_app/app/data/models/movie_production_companies_model.dart';
import 'package:show_movie_app/app/data/models/movie_production_countries_model.dart';
import 'package:show_movie_app/app/domain/entities/movie_detail_entity.dart';
import 'movie_genres_model.dart';

class MovieDetailModel extends MovieDetailEntity {
  const MovieDetailModel({
    required super.id,
    required super.originalTitle,
    required super.overview,
    required List<MovieGenresModel> super.genres,
    required List<MovieProductionCompaniesModel> super.productionCompanies,
    required List<MovieProductionCountriesModel> super.productionCountries,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      id: json['id'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      genres: MovieGenresModel.fromJsonList(json['genres']),
      productionCompanies: MovieProductionCompaniesModel.fromJsonList(
        json['production_companies'],
      ),
      productionCountries: MovieProductionCountriesModel.fromJsonList(
        json['production_countries'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'original_title': originalTitle,
      'overview': overview,
      'genres': genres,
      'production_companies': productionCompanies,
      'production_countries': productionCountries,
    };
  }
}
