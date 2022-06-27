part of 'movie_free_to_watch_bloc.dart';

abstract class MovieFreeToWatchState extends Equatable {
  // GetMoviePopularUsecase
  const MovieFreeToWatchState();

  @override
  List<Object> get props => [];
}

class MovieFreeToWatchInitialState extends MovieFreeToWatchState {}

class MovieFreeToWatchLoadingState extends MovieFreeToWatchState {}

class MovieFreeToWatchLoadedState extends MovieFreeToWatchState {
  final List<MovieEntity> movieFreeToWatch;

  const MovieFreeToWatchLoadedState({required this.movieFreeToWatch});
}

class ErrorMovieFreeToWatchState extends MovieFreeToWatchState {
  final String message;
  const ErrorMovieFreeToWatchState({required this.message});
}
