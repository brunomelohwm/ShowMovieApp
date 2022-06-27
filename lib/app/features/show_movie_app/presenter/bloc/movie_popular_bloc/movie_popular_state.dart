part of 'movie_popular_bloc.dart';

abstract class MoviePopularState extends Equatable {
  const MoviePopularState();

  @override
  List<Object> get props => [];
}

class MoviePopularInitialState extends MoviePopularState {}

class MoviePopularLoadingState extends MoviePopularState{}

class MoviePopularLoadedState extends MoviePopularState {
  final List<MovieEntity> moviePopular;

  const MoviePopularLoadedState({required this.moviePopular});
}

class ErrorMoviePopularState extends MoviePopularState {
  final String message;
  const ErrorMoviePopularState({required this.message});
}
