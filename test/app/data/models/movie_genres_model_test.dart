import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:show_movie_app/app/data/models/movie_genres_model.dart';
import 'package:show_movie_app/app/domain/entities/movie_genres_entity.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  const tMovieGenresModel = MovieGenresModel(
    id: 18,
    name: "suspense",
  );

  test('Should be a Subclass of Movie Genres Entity', () async {
    expect(tMovieGenresModel, isA<MovieGenresEntity>());
  });

  group('fromJson', () {
    test('should return a valid Model', () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('movie_genres.json'));

      final result = MovieGenresModel.fromJson(jsonMap);

      expect(result, tMovieGenresModel);
    });
  });

  group('toJson', () {
    test('should return a JsonMap contaniing the proper data', () async {
      final result = tMovieGenresModel.toJson();

      const expectedMap = {
        "id": 18,
        "name": "suspense",
      };
      expect(result, expectedMap);
    });
  });
}
