// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:show_movie_app/core/error/exceptions.dart';
import 'package:show_movie_app/core/error/failures.dart';
import 'package:show_movie_app/features/show_movie_app/domain/entities/movie_entity.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_local_datasource.dart';
import '../datasources/movie_remote_datasource.dart';
import '../models/movie_model.dart';

typedef _MoviePopularOrFreeToWatch = Future<List<MovieModel>> Function();

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource movieRemoteDataSource;
  final MovieLocalDataSource movieLocalDataSource;
  final NetworkInfo networkInfo;
  MovieRepositoryImpl({
    required this.movieRemoteDataSource,
    required this.movieLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<MovieEntity>>> getMoviePopular() async {
    return await _getMovie(() {
      return movieRemoteDataSource.getMoviePopular();
    });
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getMovieFreeToWatch() async {
    return await _getMovie(() {
      return movieRemoteDataSource.getMovieFreeToWatch();
    });
  }

  Future<Either<Failure, List<MovieEntity>>> _getMovie(
    _MoviePopularOrFreeToWatch getPopularOrFreeToWatch,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteMovie = await getPopularOrFreeToWatch();
        movieLocalDataSource.cacheMovies(remoteMovie);
        return Right(remoteMovie);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localMovie = await movieLocalDataSource.getLastMovies();
        return Right(localMovie);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
