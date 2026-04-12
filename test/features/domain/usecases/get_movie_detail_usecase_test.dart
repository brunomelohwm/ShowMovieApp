import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:show_movie_app/app/core/error/failures.dart';
import 'package:show_movie_app/app/features/domain/entities/movie_detail_entity.dart';
import 'package:show_movie_app/app/features/domain/entities/movie_genres_entity.dart';
import 'package:show_movie_app/app/features/domain/entities/movie_production_companies_entity.dart';
import 'package:show_movie_app/app/features/domain/entities/movie_production_countries_entity.dart';
import 'package:show_movie_app/app/features/domain/repositories/movie_repository.dart';
import 'package:show_movie_app/app/features/domain/usecases/get_movie_details_usecase.dart';

import 'get_movie_popular_test.mocks.dart';

@GenerateMocks([MovieRepository])
void main() {
  late GetMovieDetailUsecase usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetMovieDetailUsecase(repository: mockMovieRepository);
  });

  const tMovieDetail = MovieDetailEntity(
    id: 10,
    originalTitle: 'O silencio dos inocentes',
    overview: 'overview',
    genres: <MovieGenresEntity>[],
    productionCompanies: <MovieProductionCompaniesEntity>[],
    productionCountries: <MovieProductionCountriesEntity>[], posterPath: '',
  );

  test('Should get movie detail from the repository ', () async {
    when(
      mockMovieRepository.getMovieDetail(10),
    ).thenAnswer((_) async => const Right(tMovieDetail));

    final result = await usecase.call(10);

    expect(result, const Right(tMovieDetail));
    expect(result.fold((l) => l, (r) => r), isA<MovieDetailEntity>());
    verify(mockMovieRepository.getMovieDetail(10));
    verifyNoMoreInteractions(mockMovieRepository);
  });

  test('Should return a Failure when don\'t Succeced', () async {
    when(
      mockMovieRepository.getMovieDetail(10),
    ).thenAnswer((_) async => Left(ServerFailure()));

    final result = await usecase.call(10);

    expect(result, Left(ServerFailure()));
    expect(result.fold((l) => l, (r) => r), isA<Failure>());
    verify(mockMovieRepository.getMovieDetail(10));
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
