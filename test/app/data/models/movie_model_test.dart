import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:show_movie_app/app/data/models/movie_model.dart';
import 'package:show_movie_app/app/domain/entities/movie_entity.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  const tMovieModel = MovieModel(
    id: 3,
    posterPath:
        "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/mzTMedMt7bPBATYvC6xm6IBTcbu.jpg",
    releaseDate: "05/12/2022",
    title: "The Northman",
    voteAverage: 73,
  );
  test(
    'Should be a subclass of Movie entity',
    () async {
      expect(tMovieModel, isA<MovieEntity>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model ',
      () async {
        final Map<String, dynamic> jsonMap = json.decode(fixture('movie.json'));
        
        final result = MovieModel.fromJson(jsonMap);

        expect(result, tMovieModel);
      },
    );
  });

  group('toJson', () {
    test('should return a JSON Map containing the proper data', () async {
      final result = tMovieModel.toJson(); //toJson

      final expectedMap = {
        "id": 3,
        "poster_path":
            "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/mzTMedMt7bPBATYvC6xm6IBTcbu.jpg",
        "release_date": "05/12/2022",
        "title": "The Northman",
        "vote_average": 73,
      };
      expect(result, expectedMap);
    });
  });
}
