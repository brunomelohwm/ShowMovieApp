import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    const apiKey = String.fromEnvironment('API_KEY');

    options.queryParameters['api_key'] = apiKey;

    return handler.next(options);
  }
}
