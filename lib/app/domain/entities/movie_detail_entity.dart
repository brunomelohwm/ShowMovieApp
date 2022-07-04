import 'package:equatable/equatable.dart';

import 'movie_genres_entity.dart';
import 'movie_production_companies_entity.dart';
import 'movie_production_countries_entity.dart';

class MovieDetailEntity extends Equatable {
  final int id;
  final String originalTitle;
  final String overview;
  final List<MovieGenresEntity> genres;
  final List<MovieProductionCompaniesEntity> productionCompanies;
  final List<MovieProductionCountriesEntity> productionCountries;
  const MovieDetailEntity({
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.genres,
    required this.productionCompanies,
    required this.productionCountries,
  });

  @override
  List<Object> get props {
    return [
      id,
      overview,
      genres,
      productionCompanies,
      productionCountries,
    ];
  }
}
