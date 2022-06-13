import 'dart:convert';
import 'movie_local_data_source_test.mocks.dart';
import 'package:mockito/annotations.dart';
import 'package:show_movie_app/core/error/exceptions.dart';
import 'package:show_movie_app/features/show_movie_app/data/datasources/movie_local_datasource.dart';
import 'package:show_movie_app/features/show_movie_app/data/models/movie_model.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late MovieLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = MovieLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getLastMovies ', () {
    final tMovieModel = [
      const MovieModel(
          posterPath:
              "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/mzTMedMt7bPBATYvC6xm6IBTcbu.jpg",
          releaseDate: "05/12/2022",
          title: "The Northman",
          voteAverage: 73)
    ];
    test(
      'should return Movie List from SharedPreferences when there is one in the cache',
      () async {
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('movie_cached.json'));

        final result = await dataSource.getLastMovies();

        verify(mockSharedPreferences.getStringList('CACHED_MOVIE_LIST'));
        expect(result, equals(tMovieModel));
      },
    );

    test(
      'should throw a cacheExeption when there is not a cached value',
      () async {
        when(mockSharedPreferences.getStringList(any)).thenReturn(null);

        final call = dataSource.getLastMovies;

        verify(mockSharedPreferences.getStringList('CACHED_MOVIE_LIST'));
        expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
      },
    );
  });

  group('cacheMovies', () {
    List<MovieModel> tMovieModel = [];

    test('should call SharedPreferences to cache the data', () async {
      dataSource.cacheMovies(tMovieModel);

      final expectedJsonString = json.encode(tMovieModel.toList());
      verify(mockSharedPreferences.setString(
        CACHED_MOVIE_LIST,
        expectedJsonString,
      ));
    });
  });
}
