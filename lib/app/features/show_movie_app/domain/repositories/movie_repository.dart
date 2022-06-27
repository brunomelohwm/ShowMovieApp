import 'package:dartz/dartz.dart';
import 'package:show_movie_app/app/core/error/failures.dart';
import 'package:show_movie_app/app/features/show_movie_app/domain/entities/movie_entity.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieEntity>>> getMoviePopular();
  Future<Either<Failure, List<MovieEntity>>> getMovieFreeToWatch();
}
