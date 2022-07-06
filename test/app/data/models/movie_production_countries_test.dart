import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:show_movie_app/app/data/models/movie_production_countries_model.dart';
import 'package:show_movie_app/app/domain/entities/movie_production_countries_entity.dart';
import '../../../fixtures/fixture_reader.dart';

void main() {
  const tMovieProductionCountries = MovieProductionCountriesModel(
    iso31611: "???",
    name: "Possibility example",
  );

  test('Should be a subclass of MovieProductionCompaniesEntity ', () async {
    expect(tMovieProductionCountries, isA<MovieProductionCountriesEntity>());
  });

  group('From Json', () {
    test('should return a valid Movie Genres Model ', () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture("movie_production_countries.json"));

      final result = MovieProductionCountriesModel.fromJson(jsonMap);

      expect(result, tMovieProductionCountries);
    });
  });

  group('toJson', () {
    test('should return a JSON Map containing the proper data', () async {
      final result = tMovieProductionCountries.toJson();

      final expectMap = {
        "iso_3166_1": "???",
        "name": "Possibility example",
      };

      expect(result, expectMap);
    });
  });
}
