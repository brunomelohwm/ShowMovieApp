import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/error/exceptions.dart';
import '../models/movie_detail_model.dart';
import '../models/movie_model.dart';

abstract class MovieRemoteDataSource {
  /// Calls the https://api.themoviedb.org/3/movie/popular endpoint.
  ///
  /// Throws a [ServerException] for all erros codes.
  Future<List<MovieModel>> getMoviePopular();

  /// Calls the https://api.themoviedb.org/3/movie/now_playing endpoint.
  ///
  /// Throws a [ServerException] for all erros codes.
  Future<List<MovieModel>> getMovieFreeToWatch();

  /// Calls the https://api.themoviedb.org/3/movie/{movie_id} endpoint.
  ///
  /// Throws a [ServerException] for all erros codes.
  Future<MovieDetailModel> getMovieDetail();
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final String apikey = '1f0eff93de7c467191931ae3861e556b';
  static const _baseUrl = "https://api.themoviedb.org/3";
  static const _key = "?api_key=1f0eff93de7c467191931ae3861e556b";

  static const moviePopularUrl = "$_baseUrl/movie/popular$_key";
  static const movieFreeToWatchUrl = "$_baseUrl/movie/now_playing$_key";
  static const movieDetailUrl = "$_baseUrl/movie/{movie_id}$_key";

  final http.Client client;
  MovieRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<List<MovieModel>> getMoviePopular() =>
      _getMovieFromUrl(moviePopularUrl);

  @override
  Future<List<MovieModel>> getMovieFreeToWatch() =>
      _getMovieFromUrl(movieFreeToWatchUrl);

  Future<List<MovieModel>> _getMovieFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List<dynamic>).map((e) {
        return MovieModel.fromJson(e);
      }).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailModel> getMovieDetail() =>
      _getMovieDetailFromUrl(movieDetailUrl);

  Future<MovieDetailModel> _getMovieDetailFromUrl(String url) async {
    final response = await client.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'].map((e) {
        return MovieDetailModel.fromJson(e);
      });
    } else {
      throw ServerException();
    }
  }
}
