import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:show_movie_app/app/core/network/network_info.dart';
import 'package:show_movie_app/app/features/show_movie_app/data/datasources/movie_local_datasource.dart';
import 'package:show_movie_app/app/features/show_movie_app/data/datasources/movie_remote_datasource.dart';
import 'package:show_movie_app/app/features/show_movie_app/data/repositories/movie_repository_impl.dart';
import 'package:show_movie_app/app/features/show_movie_app/domain/usecases/get_movie_popular_usecase.dart';
import 'package:show_movie_app/app/features/show_movie_app/presenter/bloc/movie_popular_bloc/movie_popular_bloc.dart';
import 'app/features/show_movie_app/domain/repositories/movie_repository.dart';
import 'app/features/show_movie_app/domain/usecases/get_movie_free_to_watch_usecase.dart';
import 'app/features/show_movie_app/presenter/bloc/movie_free_to_watch_bloc/movie_free_to_watch_bloc.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Movies List
  // Bloc
  sl.registerFactory(
    () => MoviePopularBloc(sl()),
  );

  sl.registerFactory(
    () => MovieFreeToWatchBloc(sl()),
  );

  //Use Cases
  sl.registerLazySingleton(() => GetMoviePopularUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetMovieFreeToWatchUsecase(repository: sl()));

  //Respository
  sl.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(
        movieRemoteDataSource: sl(),
        movieLocalDataSource: sl(),
        networkInfo: sl(),
      ));

  // Data Sources
  sl.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(sharedPreferences: sl()));
  //! Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
