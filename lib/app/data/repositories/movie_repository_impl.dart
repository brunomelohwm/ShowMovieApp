import 'package:dartz/dartz.dart';
import 'package:show_movie_app/app/domain/entities/movie_detail_entity.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_local_datasource.dart';
import '../datasources/movie_remote_datasource.dart';

typedef _MoviePopularOrFreeToWatch = Future<List<MovieEntity>> Function();

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

  @override
  Future<Either<Failure, MovieDetailEntity>> getMovieDetail() async {
    return await _getMovieDetail(() {
      return movieRemoteDataSource.getMovieDetail();
    });
  }

  Future<Either<Failure, MovieDetailEntity>> _getMovieDetail(
      Future<MovieDetailEntity> Function() getMovieDetail) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await getMovieDetail();
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
