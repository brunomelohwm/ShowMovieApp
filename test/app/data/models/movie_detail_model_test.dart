import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:show_movie_app/app/data/models/movie_detail_model.dart';
import 'package:show_movie_app/app/data/models/movie_genres_model.dart';
import 'package:show_movie_app/app/data/models/movie_production_companies_model.dart';
import 'package:show_movie_app/app/data/models/movie_production_countries_model.dart';
import 'package:show_movie_app/app/domain/entities/movie_detail_entity.dart';
import '../../../fixtures/fixture_reader.dart';

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

  group('fromJson', () {
    test('should return a valid Model', () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('movie_detail.json'));

      final result = MovieDetailModel.fromJson(jsonMap);

      expect(result, tMovieDetailModel);
    });
  });

  group('toJson', () {
    test('should return a JsonMap contaniing the proper data', () async {
      final result = tMovieDetailModel.toJson();

      final expectedMap = {
        "id": 16,
        "genres": <MovieGenresModel>[],
        "original_title": 'The Batman',
        "overview": 'Após dois anos espreitando as ruas como Batman, Bruce...',
        "production_companies": <MovieProductionCompaniesModel>[],
        "production_countries": <MovieProductionCountriesModel>[],
      };
      expect(result, expectedMap);
    });
  });
}
