import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:show_movie_app/app/features/presentation/home/bloc/movie_free_to_watch_bloc/movie_free_to_watch_bloc.dart';
import 'package:show_movie_app/app/features/presentation/home/bloc/movie_popular_bloc/movie_popular_bloc.dart';
import 'package:show_movie_app/app/router.dart';
import 'package:show_movie_app/injection_container.dart';

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<MoviePopularBloc>()..add(GetMoviePopularEvent()),
        ),
        BlocProvider(
          create:
              (_) =>
                  sl<MovieFreeToWatchBloc>()..add(GetMovieFreeToWatchEvent()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('pt', 'BR')],
        title: 'Filmes e Séries',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}
