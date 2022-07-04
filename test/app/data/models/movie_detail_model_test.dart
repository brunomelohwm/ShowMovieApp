import 'package:flutter_test/flutter_test.dart';
import 'package:show_movie_app/app/data/models/movie_detail_model.dart';
import 'package:show_movie_app/app/data/models/movie_genres_model.dart';
import 'package:show_movie_app/app/data/models/movie_production_companies_model.dart';
import 'package:show_movie_app/app/data/models/movie_production_countries_model.dart';
import 'package:show_movie_app/app/domain/entities/movie_detail_entity.dart';

void main() {
  const tMovieDetailModel = MovieDetailModel(
    id: 16,
    genres: <MovieGenresModel>[],
    originalTitle: 'The Batman',
    overview: 'Após dois anos espreitando as ruas como Batman, Bruce...',
    productionCompanies: <MovieProductionCompaniesModel>[],
    productionCountries: <MovieProductionCountriesModel>[],
  );

  test('should be a subclass of MoviDetailEntity', () async {
    expect(tMovieDetailModel, isA<MovieDetailEntity>());
  });
}
