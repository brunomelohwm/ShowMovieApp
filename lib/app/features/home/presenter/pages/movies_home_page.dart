import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../injection_container.dart';
import '../bloc/movie_free_to_watch_bloc/movie_free_to_watch_bloc.dart';
import '../bloc/movie_popular_bloc/movie_popular_bloc.dart';
import '../widgets/card_movie_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/message_display.dart';

class MoviesHomePage extends StatefulWidget {
  const MoviesHomePage({super.key});

  @override
  State<MoviesHomePage> createState() => _MoviesHomePageState();
}

class _MoviesHomePageState extends State<MoviesHomePage> {
  late final MoviePopularBloc blocMoviePopular;
  late final MovieFreeToWatchBloc blocMovieFreeToWatch;

  @override
  void initState() {
    super.initState();
    blocMoviePopular = MoviePopularBloc(serviceLocalizator());
    blocMoviePopular.add(GetMoviePopularEvent());

    blocMovieFreeToWatch = MovieFreeToWatchBloc(serviceLocalizator());
    blocMovieFreeToWatch.add(GetMovieFreeToWatchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildBody(context),
          ],
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocalizator<MoviePopularBloc>()),
        BlocProvider(create: (_) => serviceLocalizator<MovieFreeToWatchBloc>()),
      ],
      child: SafeArea(
        child: Column(
          //const EdgeInsets.only(left: 5, top: 50),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: const Text(
                'Os Mais Populares',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            BlocBuilder<MoviePopularBloc, MoviePopularState>(
              bloc: blocMoviePopular,
              builder: (context, state) {
                if (state is MoviePopularInitialState) {
                  return const MessageDisplay(message: 'Iniciando');
                } else if (state is MoviePopularLoadingState) {
                  return const LoadingWidget();
                } else if (state is MoviePopularLoadedState) {
                  final moviePopularList = state.moviePopular;
                  return SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: moviePopularList.length,
                      itemBuilder: (context, index) {
                        final movie = moviePopularList[index];
                        return CardMovieWidget(movie: movie);
                      },
                    ),
                  );
                } else if (state is ErrorMoviePopularState) {
                  return MessageDisplay(message: state.message);
                }
                return Container();
              },
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: const Text(
                'Grátis Para Assitir',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            BlocBuilder<MovieFreeToWatchBloc, MovieFreeToWatchState>(
              bloc: blocMovieFreeToWatch,
              builder: (context, state) {
                if (state is MovieFreeToWatchInitialState) {
                  return const MessageDisplay(message: 'Iniciando');
                } else if (state is MovieFreeToWatchLoadingState) {
                  return const LoadingWidget();
                } else if (state is MovieFreeToWatchLoadedState) {
                  final blocMovieFreeToWatchList = state.movieFreeToWatch;
                  return SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: blocMovieFreeToWatchList.length,
                      itemBuilder: (context, index) {
                        final movie = blocMovieFreeToWatchList[index];
                        return CardMovieWidget(movie: movie);
                      },
                    ),
                  );
                } else if (state is ErrorMovieFreeToWatchState) {
                  return MessageDisplay(message: state.message);
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
