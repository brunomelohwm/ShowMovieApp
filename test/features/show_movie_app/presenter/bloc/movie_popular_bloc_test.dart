import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:show_movie_app/app/core/error/failures.dart';
import 'package:show_movie_app/app/core/usecases/usecase.dart';
import 'package:show_movie_app/app/features/show_movie_app/domain/entities/movie_entity.dart';
import 'package:show_movie_app/app/features/show_movie_app/domain/usecases/get_movie_popular_usecase.dart';
import 'package:show_movie_app/app/features/show_movie_app/presenter/bloc/movie_popular_bloc/movie_popular_bloc.dart';
import 'movie_popular_bloc_test.mocks.dart';

@GenerateMocks([GetMoviePopularUsecase])
void main() {
  late MoviePopularBloc bloc;
  late MockGetMoviePopularUsecase mockGetMoviePopularUsecase;

  setUp(() {
    mockGetMoviePopularUsecase = MockGetMoviePopularUsecase();
    bloc = MoviePopularBloc(mockGetMoviePopularUsecase);
  });

  test('initial State should be Empty', () {
    expect(bloc.state, equals(MoviePopularInitialState()));
  });

  group('GetMoviePopular Should Be Successful ', () {
    setUp(() {
      bloc = MoviePopularBloc(mockGetMoviePopularUsecase);
      when(mockGetMoviePopularUsecase(NoParams()))
          .thenAnswer((_) async => const Right(<MovieEntity>[]));
    });
    blocTest<MoviePopularBloc, MoviePopularState>(
      'should emit [Loading, Loaded] when List is gotten Successfully',
      build: () => bloc,
      act: (bloc) => bloc.add(GetMoviePopularEvent()),
      wait: const Duration(seconds: 2),
      expect: () => [
        isA<MoviePopularLoadingState>(),
        isA<MoviePopularLoadedState>(),
      ],
    );
  });

  group('GetMoviePopular is Failure', () {
    setUp(() {
      bloc = MoviePopularBloc(mockGetMoviePopularUsecase);
      when(mockGetMoviePopularUsecase(NoParams()))
          .thenAnswer((_) async => Left(ServerFailure()));
    });
    test('Should Return Failure', () async {
      expect(
          bloc.stream,
          emitsInOrder([
            MoviePopularLoadingState(),
            const ErrorMoviePopularState(message: 'ERROR')
          ]));
      bloc.add(GetMoviePopularEvent());
    });
  });
}
