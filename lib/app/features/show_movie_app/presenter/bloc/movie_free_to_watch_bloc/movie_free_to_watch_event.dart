part of 'movie_free_to_watch_bloc.dart';

abstract class MovieFreeToWatchEvent extends Equatable {
  const MovieFreeToWatchEvent();

  @override
  List<Object> get props => [];
}

class GetMovieFreeToWatchEvent extends MovieFreeToWatchEvent {}
