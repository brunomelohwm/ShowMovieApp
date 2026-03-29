import 'package:dio/dio.dart';
import 'package:show_movie_app/app/core/network/auth_interceptor.dart';

class DioClient {
  final Dio dio;

  DioClient({Dio? dio})
    : dio = dio ?? Dio(BaseOptions(baseUrl: 'https://api.themoviedb.org/3')) {
    if (dio == null) {
      this.dio.interceptors.add(AuthInterceptor());
    }
  }
}
