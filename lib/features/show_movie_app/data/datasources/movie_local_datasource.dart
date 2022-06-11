import '../models/movie_model.dart';

abstract class MovieLocalDataSource {
  /// Gets the cached [MovieModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<MovieModel>> getLastMovies();

  Future<void> cacheMovies(List<MovieModel> movieToCache);
}
