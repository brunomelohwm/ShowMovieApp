import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:show_movie_app/app/core/error/exceptions.dart';
import 'package:show_movie_app/app/core/error/failures.dart';
import 'package:show_movie_app/app/core/network/network_info.dart';
import 'package:show_movie_app/app/data/datasources/movie_local_datasource.dart';
import 'package:show_movie_app/app/data/datasources/movie_remote_datasource.dart';
import 'package:show_movie_app/app/data/models/movie_detail_model.dart';
import 'package:show_movie_app/app/data/models/movie_genres_model.dart';
import 'package:show_movie_app/app/data/models/movie_model.dart';
import 'package:show_movie_app/app/data/models/movie_production_companies_model.dart';
import 'package:show_movie_app/app/data/models/movie_production_countries_model.dart';
import 'package:show_movie_app/app/data/repositories/movie_repository_impl.dart';
import 'movie_repository_impl_test.mocks.dart';

@GenerateMocks([
  MovieRemoteDataSource,
  MovieLocalDataSource,
  NetworkInfo,
])
void main() {
  late MovieRepositoryImpl repository;
  late MockMovieRemoteDataSource mockMovieRemoteDataSource;
  late MockMovieLocalDataSource mockMovieLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockMovieRemoteDataSource = MockMovieRemoteDataSource();
    mockMovieLocalDataSource = MockMovieLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = MovieRepositoryImpl(
      movieRemoteDataSource: mockMovieRemoteDataSource,
      movieLocalDataSource: mockMovieLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getMoviePopular', () {
    const tMovieModel = [
      MovieModel(
          id: 3,
          posterPath: "PosterPath",
          releaseDate: "05/12/2022",
          title: "The Northman",
          voteAverage: 73)
    ];

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successful ',
          () async {
        when(mockMovieRemoteDataSource.getMoviePopular())
            .thenAnswer((_) async => tMovieModel);

        final result = await repository.getMoviePopular();

        verify(mockMovieRemoteDataSource.getMoviePopular());
        expect(result, equals(const Right(tMovieModel)));
      });

      test(
          'should cache the data locally when the call to remote data source is successful ',
          () async {
        when(mockMovieRemoteDataSource.getMoviePopular())
            .thenAnswer((_) async => tMovieModel);

        await repository.getMoviePopular();
        verify(mockMovieRemoteDataSource.getMoviePopular());
        verify(mockMovieLocalDataSource.cacheMovies(tMovieModel));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful ',
          () async {
        when(mockMovieRemoteDataSource.getMoviePopular())
            .thenThrow(ServerException());

        final result = await repository.getMoviePopular();

        verify(mockMovieRemoteDataSource.getMoviePopular());
        verifyZeroInteractions(mockMovieLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });

      runTestsOffline(() {
        test(
            'should return last locally cached data when the cache data is present',
            () async {
          when(mockMovieLocalDataSource.getLastMovies())
              .thenAnswer((_) async => tMovieModel);
          final result = await repository.getMoviePopular();

          verifyZeroInteractions(mockMovieRemoteDataSource);
          verify(mockMovieLocalDataSource.getLastMovies());
          expect(result, equals(const Right(tMovieModel)));
        });

        test(
          'should return Cache failure when there is no cached data present ',
          () async {
            when(mockMovieLocalDataSource.getLastMovies())
                .thenThrow(CacheException());

            final result = await repository.getMoviePopular();

            verifyZeroInteractions(mockMovieRemoteDataSource);
            verify(mockMovieLocalDataSource.getLastMovies());
            expect(result, equals(Left(CacheFailure())));
          },
        );
      });
    });
  });

  group('getMovieFreeToWatch', () {
    const tMovieModel = [
      MovieModel(
          id: 3,
          posterPath: "PosterPath",
          releaseDate: "05/12/2022",
          title: "The Northman",
          voteAverage: 73)
    ];

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successful ',
          () async {
        when(mockMovieRemoteDataSource.getMovieFreeToWatch())
            .thenAnswer((_) async => tMovieModel);

        final result = await repository.getMovieFreeToWatch();

        verify(mockMovieRemoteDataSource.getMovieFreeToWatch());
        expect(result, equals(const Right(tMovieModel)));
      });

      test(
          'should cache the data locally when the call to remote data source is successful ',
          () async {
        when(mockMovieRemoteDataSource.getMovieFreeToWatch())
            .thenAnswer((_) async => tMovieModel);

        await repository.getMovieFreeToWatch();
        verify(mockMovieRemoteDataSource.getMovieFreeToWatch());
        verify(mockMovieLocalDataSource.cacheMovies(tMovieModel));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful ',
          () async {
        when(mockMovieRemoteDataSource.getMovieFreeToWatch())
            .thenThrow(ServerException());

        final result = await repository.getMovieFreeToWatch();

        verify(mockMovieRemoteDataSource.getMovieFreeToWatch());
        verifyZeroInteractions(mockMovieLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });

      runTestsOffline(() {
        test(
            'should return last locally cached data when the cache data is present',
            () async {
          when(mockMovieLocalDataSource.getLastMovies())
              .thenAnswer((_) async => tMovieModel);
          final result = await repository.getMovieFreeToWatch();

          verifyZeroInteractions(mockMovieRemoteDataSource);
          verify(mockMovieLocalDataSource.getLastMovies());
          expect(result, equals(const Right(tMovieModel)));
        });

        test(
          'should return Cache failure when there is no cached data present ',
          () async {
            when(mockMovieLocalDataSource.getLastMovies())
                .thenThrow(CacheException());

            final result = await repository.getMovieFreeToWatch();

            verifyZeroInteractions(mockMovieRemoteDataSource);
            verify(mockMovieLocalDataSource.getLastMovies());
            expect(result, equals(Left(CacheFailure())));
          },
        );
      });
    });
  });
  group('getMovieDetail', () {
    const tMovieDetail = MovieDetailModel(
      id: 10,
      originalTitle: 'O silencio dos inocentes',
      overview: 'overview',
      genres: <MovieGenresModel>[],
      productionCompanies: <MovieProductionCompaniesModel>[],
      productionCountries: <MovieProductionCountriesModel>[],
    );

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successful ',
          () async {
        log(tMovieDetail.originalTitle);
        when(mockMovieRemoteDataSource.getMovieDetail())
            .thenAnswer((_) async => tMovieDetail);

        final result = await repository.getMovieDetail();

        verify(mockMovieRemoteDataSource.getMovieDetail());
        expect(result, equals(const Right(tMovieDetail)));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful ',
          () async {
        when(mockMovieRemoteDataSource.getMovieDetail())
            .thenThrow(ServerException());

        final result = await repository.getMovieDetail();

        verify(mockMovieRemoteDataSource.getMovieDetail());
        verifyZeroInteractions(mockMovieLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });
  });
}
