import 'package:dio/dio.dart';
import 'package:show_movie_app/app/core/network/dio_client.dart';
import '../../core/error/exceptions.dart';
import '../models/movie_detail_model.dart';
import '../models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getMoviePopular();
  Future<List<MovieModel>> getMovieFreeToWatch();
  Future<MovieDetailModel> getMovieDetail(int movieId);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final DioClient dioClient;

  MovieRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<MovieModel>> getMoviePopular() async {
    try {
      final response = await dioClient.dio.get('/movie/popular');
      return (response.data['results'] as List<dynamic>)
          .map((e) => MovieModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<List<MovieModel>> getMovieFreeToWatch() async {
    try {
      final response = await dioClient.dio.get('/movie/now_playing');
      return (response.data['results'] as List<dynamic>)
          .map((e) => MovieModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<MovieDetailModel> getMovieDetail(int movieId) async {
    try {
      final response = await dioClient.dio.get('/movie/$movieId');
      return MovieDetailModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
