import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:show_movie_app/app/core/utils/horizontal_list_view_wrapper.dart';
import '../bloc/movie_free_to_watch_bloc/movie_free_to_watch_bloc.dart';
import '../bloc/movie_popular_bloc/movie_popular_bloc.dart';
import '../../widgets/card_movie_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/message_display.dart';

class MoviesHomePage extends StatefulWidget {
  const MoviesHomePage({super.key});

  @override
  State<MoviesHomePage> createState() => _MoviesHomePageState();
}

class _MoviesHomePageState extends State<MoviesHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Populares',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(onPressed: () {}, child: const Text('Ver mais')),
                  ],
                ),
              ),
            ),

            BlocBuilder<MoviePopularBloc, MoviePopularState>(
              builder: (context, state) {
                if (state is MoviePopularLoadingState ||
                    state is MoviePopularInitialState) {
                  return SliverToBoxAdapter(child: const LoadingWidget());
                } else if (state is MoviePopularLoadedState) {
                  return SliverToBoxAdapter(
                    child: HorizontalListView(
                      itemCount: state.moviePopular.length,
                      itemBuilder: (context, index) {
                        return CardMovieWidget(
                          movie: state.moviePopular[index],
                        );
                      },
                    ),
                  );
                } else if (state is ErrorMoviePopularState) {
                  return SliverToBoxAdapter(
                    child: MessageDisplay(message: state.message),
                  );
                }
                return SliverToBoxAdapter(child: Container());
              },
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Grátis Para Assistir',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            BlocBuilder<MovieFreeToWatchBloc, MovieFreeToWatchState>(
              builder: (context, state) {
                if (state is MovieFreeToWatchLoadingState ||
                    state is MovieFreeToWatchInitialState) {
                  return SliverToBoxAdapter(child: const LoadingWidget());
                } else if (state is MovieFreeToWatchLoadedState) {
                  return SliverToBoxAdapter(
                    child: HorizontalListView(
                      itemCount: state.movieFreeToWatch.length,
                      itemBuilder: (context, index) {
                        return CardMovieWidget(
                          movie: state.movieFreeToWatch[index],
                        );
                      },
                    ),
                  );
                } else if (state is ErrorMovieFreeToWatchState) {
                  return SliverToBoxAdapter(
                    child: MessageDisplay(message: state.message),
                  );
                }
                return SliverToBoxAdapter(child: Container());
              },
            ),
          ],
        ),
      ),
    );
  }
}
