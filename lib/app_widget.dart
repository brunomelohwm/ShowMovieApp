import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:show_movie_app/app/features/home/presenter/bloc/movie_free_to_watch_bloc/movie_free_to_watch_bloc.dart';
import 'package:show_movie_app/app/features/home/presenter/bloc/movie_popular_bloc/movie_popular_bloc.dart';
import 'package:show_movie_app/injection_container.dart';
import 'app/features/home/presenter/pages/movies_home_page.dart';

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      debugShowCheckedModeBanner: false,
      title: 'Filmes e Séries',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create:
                (_) =>
                    serviceLocalizator<MoviePopularBloc>()
                      ..add(GetMoviePopularEvent()),
          ),
          BlocProvider(
            create:
                (_) =>
                    serviceLocalizator<MovieFreeToWatchBloc>()
                      ..add(GetMovieFreeToWatchEvent()),
          ),
        ],
        child: const MoviesHomePage(),
      ),
    );
  }
}
