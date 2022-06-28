import 'package:show_movie_app/app/features/show_movie_app/data/datasources/movie_remote_datasource.dart';
import 'package:mockito/annotations.dart';
import 'package:show_movie_app/app/core/error/exceptions.dart';
import 'package:show_movie_app/app/features/show_movie_app/data/models/movie_model.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'movie_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MovieRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = MovieRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('response_movie.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went Wrong', 404));
  }

  group('getMoviePopular', () {
    final tMovieModel = [
      const MovieModel(
          posterPath:
              "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/mzTMedMt7bPBATYvC6xm6IBTcbu.jpg",
          releaseDate: "05/12/2022",
          title: "The Northman",
          voteAverage: 73)
    ];

    test(
      'should perform a GET request on a URL with endopoint and with application/json header',
      () async {
        setUpMockHttpClientSuccess200();

        final result = await dataSource.getMoviePopular();
        expect(result, tMovieModel);
        verify(mockHttpClient.get(
          Uri.parse(
              'https://api.themoviedb.org/3/movie/popular?api_key=1f0eff93de7c467191931ae3861e556b'),
          headers: {
            'Content-Type': 'application/json',
          },
        ));
      },
    );

    test(
      'should return MovieList when the response is 200 (success)',
      () async {
        setUpMockHttpClientSuccess200();

        final result = await dataSource.getMoviePopular();

        expect(result, equals(tMovieModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        setUpMockHttpClientFailure404();

        final call = dataSource.getMoviePopular;

        expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
