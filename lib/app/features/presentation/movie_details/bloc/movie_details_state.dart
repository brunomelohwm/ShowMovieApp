import 'package:show_movie_app/app/features/domain/entities/movie_detail_entity.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsLoaded extends MovieDetailsState {
  final MovieDetailEntity movieDetail;

  MovieDetailsLoaded(this.movieDetail);
}

class MovieDetailsError extends MovieDetailsState {}
