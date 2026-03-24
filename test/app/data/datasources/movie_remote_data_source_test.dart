import 'package:mockito/annotations.dart';
import 'package:show_movie_app/app/core/error/exceptions.dart';
import 'package:show_movie_app/app/core/network/dio_client.dart';
import 'package:show_movie_app/app/data/datasources/movie_remote_datasource.dart';
import 'package:show_movie_app/app/data/models/movie_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import '../../../fixtures/fixture_reader.dart';
import 'movie_remote_data_source_test.mocks.dart';

@GenerateMocks([DioClient])
void main() {
  late MovieRemoteDataSourceImpl dataSource;
  late MockDioClient mockDioClient;

  setUp(() {
    mockDioClient = MockDioClient();
    dataSource = MovieRemoteDataSourceImpl(dioClient: mockDioClient);
  });

  void setUpMockDioClientSuccess200() {
    when(
      mockDioClient.dio.get('https://api.themoviedb.org/3/movie/popular'),
    ).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: ''),
        data: fixture('response_movie.json'),
        statusCode: 200,
      ),
    );
  }

  void setUpMockDioClientFailure404() {
    when(
      mockDioClient.dio.get('https://api.themoviedb.org/3/movie/popular'),
    ).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: ''),
        data: 'Something went Wrong',
        statusCode: 404,
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
        verify(
          mockDioClient.dio.get('https://api.themoviedb.org/3/movie/popular'),
        );
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
