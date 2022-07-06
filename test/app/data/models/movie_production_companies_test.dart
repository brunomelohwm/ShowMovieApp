import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:show_movie_app/app/data/models/movie_production_companies_model.dart';
import 'package:show_movie_app/app/domain/entities/movie_production_companies_entity.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  const tMovieProductionCompanies = MovieProductionCompaniesModel(
    id: 22,
    logoPath: 'https://',
    name: 'Bridges Company',
    originCountry: "United Kingdom",
  );

  test('Should be a subclass of MovieProductionCompaniesEntity ', () async {
    expect(tMovieProductionCompanies, isA<MovieProductionCompaniesEntity>());
  });

  group('From Json', () {
    test('should return a valid Movie Genres Model ', () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture("movie_production_companies.json"));

      final result = MovieProductionCompaniesModel.fromJson(jsonMap);
      expect(result, tMovieProductionCompanies);
    });
  });

  group('toJson', () {
    test('should return a JSON Map containing the proper data', () async {
      final result = tMovieProductionCompanies.toJson();

      final expectMap = {
        'id': 22,
        'logo_path': 'https://',
        'name': 'Bridges Company',
        'origin_country': "United Kingdom",
      };
      
      expect(result, expectMap);
    });
  });
}
