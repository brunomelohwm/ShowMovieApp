import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:show_movie_app/app/core/usecases/usecase.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../domain/entities/movie_entity.dart';
import '../../../../../domain/usecases/get_movie_free_to_watch_usecase.dart';
part 'movie_free_to_watch_event.dart';
part 'movie_free_to_watch_state.dart';

//const String SERVER_FAILURE_MESSAGE = 'Server Failure';
//const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

const String serverFailureMessage = 'Server Failure';
const String cacheFailureMessage = 'Cache Failure';
class MovieFreeToWatchBloc
    extends Bloc<MovieFreeToWatchEvent, MovieFreeToWatchState> {
  final GetMovieFreeToWatchUsecase getMovieFreeToWatchUsecase;

  MovieFreeToWatchBloc(
    this.getMovieFreeToWatchUsecase,
  ) : super(MovieFreeToWatchInitialState()) {
    on<GetMovieFreeToWatchEvent>((event, emit) async {
      emit(MovieFreeToWatchLoadingState());
      final movieListOrFailure =
          await getMovieFreeToWatchUsecase.call(NoParams());

      movieListOrFailure.fold(
          (failure) => emit(ErrorMovieFreeToWatchState(
              message: _mapFailureToMessage(failure))),
          (movieList) =>
              emit(MovieFreeToWatchLoadedState(movieFreeToWatch: movieList)));
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
