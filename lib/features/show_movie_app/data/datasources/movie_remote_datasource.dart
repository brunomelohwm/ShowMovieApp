import '../models/movie_model.dart';

abstract class MovieRemoteDataSource {
  /// Calls the https://api.themoviedb.org/3/movie/popular endpoint.
  ///
  /// Throws a [ServerException] for all erros codes.
  Future<List<MovieModel>> getMoviePopular();

  /// Calls the https://api.themoviedb.org/3/movie/movie/now_playing endpoint.
  ///
  /// Throws a [ServerException] for all erros codes.
  Future<List<MovieModel>> getMovieFreeToWatch();
}
