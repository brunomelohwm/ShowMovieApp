import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:show_movie_app/app/features/show_movie_app/data/models/movie_model.dart';
import 'package:show_movie_app/app/features/show_movie_app/domain/entities/movie_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tMovieModel = MovieModel(
    posterPath:
        "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/mzTMedMt7bPBATYvC6xm6IBTcbu.jpg",
    releaseDate: "05/12/2022",
    title: "The Northman",
    voteAverage: 73,
  );
  test(
    'Should be a subclass of Movie entity',
    () async {
      expect(tMovieModel, isA<List<MovieEntity>>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model when the JSON number is an Integer',
      () async {
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('movie_double.json'));

        final result = MovieModel.fromJson(jsonMap);

        expect(result, tMovieModel);
      },
    );
    test(
      'should return a valid model when the JSON number is an double',
      () async {
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('movie_double.json'));

        final result = MovieModel.fromJson(jsonMap);

        expect(result, tMovieModel);
      },
    );
  });

  group('toJson', () {
    test('should return a JSON Map containing the porper data', () async {
      final result = tMovieModel.toJson(); //toJson

      final expectedMap = {
        "posterPath":
            "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/mzTMedMt7bPBATYvC6xm6IBTcbu.jpg",
        "releaseDate": "05/12/2022",
        "title": "The Northman",
        "voteAverage": 73,
      };
      expect(result, expectedMap);
    });
  });
}
