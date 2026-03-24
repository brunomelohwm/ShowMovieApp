import 'package:dio/dio.dart';
import 'package:show_movie_app/app/core/network/auth_interceptor.dart';

class DioClient {
  final Dio dio;

  DioClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: 'https://api.themoviedb.org/3',
          connectTimeout: Duration(seconds: 10),
        ),
      ) {
    dio.interceptors.add(AuthInterceptor());
  }
}
