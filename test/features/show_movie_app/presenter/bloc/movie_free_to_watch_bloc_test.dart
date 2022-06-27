import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:show_movie_app/app/core/error/failures.dart';
import 'package:show_movie_app/app/core/usecases/usecase.dart';
import 'package:show_movie_app/app/features/show_movie_app/domain/entities/movie_entity.dart';
import 'package:show_movie_app/app/features/show_movie_app/domain/usecases/get_movie_free_to_watch_usecase.dart';
import 'package:show_movie_app/app/features/show_movie_app/presenter/bloc/movie_free_to_watch_bloc/movie_free_to_watch_bloc.dart';

import 'movie_free_to_watch_bloc_test.mocks.dart';

@GenerateMocks([GetMovieFreeToWatchUsecase])
void main() {
  late MovieFreeToWatchBloc bloc;
  late MockGetMovieFreeToWatchUsecase mockGetMovieFreeToWatchUsecase;

  setUp(() {
    mockGetMovieFreeToWatchUsecase = MockGetMovieFreeToWatchUsecase();
    bloc = MovieFreeToWatchBloc(mockGetMovieFreeToWatchUsecase);
  });

  test('initial State should be Empty', () {
    expect(bloc.state, equals(MovieFreeToWatchInitialState()));
  });

  group('GetMoviePopular Should Be Successful ', () {
    setUp(() {
      bloc = MovieFreeToWatchBloc(mockGetMovieFreeToWatchUsecase);
      when(mockGetMovieFreeToWatchUsecase(NoParams()))
          .thenAnswer((_) async => const Right(<MovieEntity>[]));
    });
    blocTest<MovieFreeToWatchBloc, MovieFreeToWatchState>(
      'should emit [Loading, Loaded] when List is gotten Successfully',
      build: () => bloc,
      act: (bloc) => bloc.add(GetMovieFreeToWatchEvent()),
      wait: const Duration(seconds: 2),
      expect: () => [
        isA<MovieFreeToWatchLoadingState>(),
        isA<MovieFreeToWatchLoadedState>(),
      ],
    );
  });

  group('GetMoviePopular is Failure', () {
    setUp(() {
      bloc = MovieFreeToWatchBloc(mockGetMovieFreeToWatchUsecase);
      when(mockGetMovieFreeToWatchUsecase(NoParams()))
          .thenAnswer((_) async => Left(ServerFailure()));
    });
    test('Should Return Failure', () async {
      expect(
          bloc.stream,
          emitsInOrder([
            MovieFreeToWatchLoadingState(),
            const ErrorMovieFreeToWatchState(message: 'ERROR')
          ]));
      bloc.add(GetMovieFreeToWatchEvent());
    });
  });
}
