import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:show_movie_app/app/core/error/failures.dart';
import 'package:show_movie_app/app/core/usecases/usecase.dart';
import 'package:show_movie_app/app/domain/entities/movie_entity.dart';
import 'package:show_movie_app/app/domain/repositories/movie_repository.dart';
import 'package:show_movie_app/app/domain/usecases/get_movie_popular_usecase.dart';
import 'get_movie_free_to_watch_test.mocks.dart';

@GenerateMocks([MovieRepository])
void main() {
  late GetMoviePopularUsecase usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetMoviePopularUsecase(repository: mockMovieRepository);
  });

  const tMoviePopular = [
    MovieEntity(
      id: 3,
      posterPath: "Poster",
      releaseDate: "sdghadfh",
      title: "srtjsdrt",
      voteAverage: 35,
    ),
    MovieEntity(
      id: 5,
      posterPath: "rotas.....",
      releaseDate: "25/02/2022",
      title: "SpiderMan",
      voteAverage: 10,
    )
  ];

  test('should get return a list of Popular movies from the repository',
      () async {
    when(mockMovieRepository.getMoviePopular())
        .thenAnswer((_) async => const Right(tMoviePopular));

    final result = await usecase.call(NoParams());

    expect(result, const Right(tMoviePopular));
    expect(result.fold((l) => l, (r) => r), isA<List<MovieEntity>>());
    verify(mockMovieRepository.getMoviePopular());
    verifyNoMoreInteractions(mockMovieRepository);
  });

  test('should return a Failure when don\'t succeced', () async {
    when(mockMovieRepository.getMoviePopular())
        .thenAnswer((_) async => Left(ServerFailure()));

    final result = await usecase.call(NoParams());

    expect(result, Left(ServerFailure()));
    expect(result.fold((l) => l, (r) => r), isA<Failure>());
    verify(mockMovieRepository.getMoviePopular());
    verifyNoMoreInteractions(mockMovieRepository);
  });
} 
