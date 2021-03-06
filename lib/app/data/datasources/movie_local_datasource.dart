import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:show_movie_app/app/core/error/exceptions.dart';
import 'package:show_movie_app/app/domain/entities/movie_detail_entity.dart';
import '../../domain/entities/movie_entity.dart';
import '../models/movie_detail_model.dart';
import '../models/movie_model.dart';

abstract class MovieLocalDataSource {
  /// Gets the cached [MovieModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<MovieModel>> getLastMovies();

  Future<void> cacheMovies(List<MovieEntity> movieToCache);
}

abstract class MovieDetailLocalDataSource extends MovieLocalDataSource {
  Future<MovieDetailModel> getLastMovieDetail();

  Future<void> cacheMovieDetail(MovieDetailEntity movieDetailToCache);
}

const cachedMovieList = 'CACHED_MOVIE_LIST';
const cachedMovieDetail = 'CACHED_MOVIE_DETAIL';

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final SharedPreferences sharedPreferences;

  MovieLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<MovieModel>> getLastMovies() async {
    final jsonString = sharedPreferences.getString(cachedMovieList);
    if (jsonString != null) {
      //log(jsonString);
      final List data = await json.decode(jsonString);
      final result = data.map((e) => MovieModel.fromJson(e)).toList();
      return result;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheMovies(List<MovieEntity> movieToCache) {
    late List<Map<String, dynamic>> listMovieModel = movieToCache.map((e) {
      final movieModel = MovieModel(
        id: e.id,
        posterPath: e.posterPath,
        releaseDate: e.releaseDate,
        title: e.title,
        voteAverage: e.voteAverage,
      );
      return movieModel.toJson();
    }).toList();

    //log(json.encode(listMovieModel));
    return sharedPreferences.setString(
        cachedMovieList, json.encode(listMovieModel));
  }
}
