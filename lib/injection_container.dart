import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:show_movie_app/app/core/network/network_info.dart';
import 'package:http/http.dart' as http;
import 'app/data/datasources/movie_local_datasource.dart';
import 'app/data/datasources/movie_remote_datasource.dart';
import 'app/data/repositories/movie_repository_impl.dart';
import 'app/domain/repositories/movie_repository.dart';
import 'app/domain/usecases/get_movie_free_to_watch_usecase.dart';
import 'app/domain/usecases/get_movie_popular_usecase.dart';
import 'app/features/home/presenter/bloc/movie_free_to_watch_bloc/movie_free_to_watch_bloc.dart';
import 'app/features/home/presenter/bloc/movie_popular_bloc/movie_popular_bloc.dart';


final serviceLocalizator = GetIt.instance;

Future<void> init() async {
  //! Features - Movies List
  // Bloc
  serviceLocalizator.registerFactory(
    () => MoviePopularBloc(serviceLocalizator()),
  );

  serviceLocalizator.registerFactory(
    () => MovieFreeToWatchBloc(serviceLocalizator()),
  );

  //Use Cases
  serviceLocalizator.registerLazySingleton(
      () => GetMoviePopularUsecase(repository: serviceLocalizator()));
  serviceLocalizator.registerLazySingleton(
      () => GetMovieFreeToWatchUsecase(repository: serviceLocalizator()));

  //Respository
  serviceLocalizator
      .registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(
            movieRemoteDataSource: serviceLocalizator(),
            movieLocalDataSource: serviceLocalizator(),
            networkInfo: serviceLocalizator(),
          ));

  // Data Sources
  serviceLocalizator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: serviceLocalizator()));

  serviceLocalizator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(sharedPreferences: serviceLocalizator()));
  //! Core
  serviceLocalizator.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: serviceLocalizator()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocalizator.registerLazySingleton(() => sharedPreferences);
  serviceLocalizator.registerLazySingleton(() => http.Client());
  serviceLocalizator.registerLazySingleton(() => InternetConnectionChecker());
}
