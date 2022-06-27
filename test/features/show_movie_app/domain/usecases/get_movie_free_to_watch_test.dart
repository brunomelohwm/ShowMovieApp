import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:show_movie_app/app/core/error/failures.dart';
import 'package:show_movie_app/app/core/usecases/usecase.dart';
import 'package:show_movie_app/app/features/show_movie_app/domain/entities/movie_entity.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:show_movie_app/app/features/show_movie_app/domain/repositories/movie_repository.dart';
import 'package:show_movie_app/app/features/show_movie_app/domain/usecases/get_movie_free_to_watch_usecase.dart';

import 'get_movie_free_to_watch_test.mocks.dart';

@GenerateMocks([MovieRepository])
void main() {
  late GetMovieFreeToWatchUsecase usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetMovieFreeToWatchUsecase(repository: mockMovieRepository);
  });

  const tMovieFreeToWatch = [
    MovieEntity(
      posterPath:
          "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/mzTMedMt7bPBATYvC6xm6IBTcbu.jpg",
      releaseDate: "05/12/2022",
      title: "The Northman",
      voteAverage: 73,
    ),
    MovieEntity(
      posterPath: "rotas.....",
      releaseDate: "25/02/2022",
      title: "SpiderMan",
      voteAverage: 10,
    )
  ];

  test('should get return a list of movies free to watch from the repository',
      () async {
    when(mockMovieRepository.getMovieFreeToWatch())
        .thenAnswer((_) async => const Right(tMovieFreeToWatch));

    final result = await usecase.call(NoParams());

    expect(result, const Right(tMovieFreeToWatch));
    expect(result.fold((l) => l, (r) => r), isA<List<MovieEntity>>());
    verify(mockMovieRepository.getMovieFreeToWatch());
    verifyNoMoreInteractions(mockMovieRepository);
  });

  test('should return a Failure when don\'t succeced', () async {
    when(mockMovieRepository.getMovieFreeToWatch())
        .thenAnswer((_) async => Left(ServerFailure()));

    final result = await usecase.call(NoParams());

    expect(result, Left(ServerFailure()));
    verify(mockMovieRepository.getMovieFreeToWatch());
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
