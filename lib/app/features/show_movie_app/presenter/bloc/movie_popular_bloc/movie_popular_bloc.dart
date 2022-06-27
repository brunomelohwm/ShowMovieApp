import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:show_movie_app/app/core/usecases/usecase.dart';
import 'package:show_movie_app/app/features/show_movie_app/domain/entities/movie_entity.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/usecases/get_movie_popular_usecase.dart';
part 'movie_popular_event.dart';
part 'movie_popular_state.dart';

//const String SERVER_FAILURE_MESSAGE = 'Server Failure';
//const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

const String serverFailureMessage = 'Server Failure';
const String cacheFailureMessage = 'Cache Failure';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  final GetMoviePopularUsecase getMoviePopularUsecase;

  MoviePopularBloc(
    this.getMoviePopularUsecase,
  ) : super(MoviePopularInitialState()) {
    on<GetMoviePopularEvent>((event, emit) async {
      emit(MoviePopularLoadingState());
      final movieListOrFailure = await getMoviePopularUsecase.call(NoParams());
      movieListOrFailure.fold(
          (failure) => emit(
              ErrorMoviePopularState(message: _mapFailureToMessage(failure))),
          (movieList) =>
              emit(MoviePopularLoadedState(moviePopular: movieList)));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return 'Unexpected error';
    }
  }
}
