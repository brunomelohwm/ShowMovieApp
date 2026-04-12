import 'dart:convert';

import 'package:mockito/annotations.dart';
import 'package:show_movie_app/app/core/error/exceptions.dart';
import 'package:show_movie_app/app/core/network/dio_client.dart';
import 'package:show_movie_app/app/features/data/datasources/movie_remote_datasource.dart';
import 'package:show_movie_app/app/features/data/models/movie_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import '../../../fixtures/fixture_reader.dart';
import 'movie_remote_data_source_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MovieRemoteDataSourceImpl dataSource;
  late MockDio mockDio;
  late DioClient dioClient;

  setUp(() {
    mockDio = MockDio();
    dioClient = DioClient(dio: mockDio);
    dataSource = MovieRemoteDataSourceImpl(dioClient: dioClient);
  });

  void setUpMockDioClientSuccess200() {
    when(mockDio.get('/movie/popular')).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: ''),
        data: json.decode(fixture('response_movie.json')),
        statusCode: 200,
      ),
    );
  }

  void setUpMockDioClientFailure404() {
    when(mockDio.get('/movie/popular')).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: '/movie/popular'),
        response: Response(
          requestOptions: RequestOptions(path: '/movie/popular'),
          statusCode: 404,
          data: 'Something went Wrong',
        ),
        type: DioExceptionType.badResponse,
      ),
    );
  }

  group('getMoviePopular', () {
    final tMovieModel = [
      const MovieModel(
        id: 3,
        posterPath:
            "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/mzTMedMt7bPBATYvC6xm6IBTcbu.jpg",
        releaseDate: "05/12/2022",
        title: "The Northman",
        voteAverage: 73,
      ),
    ];

    test(
      'should perform a GET request on a URL with endopoint and with application/json header',
      () async {
        setUpMockDioClientSuccess200();

        final result = await dataSource.getMoviePopular();
        expect(result, tMovieModel);
        verify(mockDio.get('/movie/popular'));
      },
    );

    test(
      'should return MovieList when the response is 200 (success)',
      () async {
        setUpMockDioClientSuccess200();

        final result = await dataSource.getMoviePopular();

        expect(result, equals(tMovieModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        setUpMockDioClientFailure404();

        final call = dataSource.getMoviePopular;

        expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
