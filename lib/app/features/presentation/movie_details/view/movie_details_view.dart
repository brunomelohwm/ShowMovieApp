import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:show_movie_app/app/features/presentation/movie_details/bloc/movie_details_bloc.dart';
import 'package:show_movie_app/app/features/presentation/movie_details/bloc/movie_details_state.dart';

class MovieDetailsView extends StatelessWidget {
  const MovieDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        builder: (context, state) {
          if (state is MovieDetailsLoading) {
            return Container(
              color: Colors.black,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                  strokeWidth: 2,
                ),
              ),
            );
          }

          if (state is MovieDetailsError) {
            return const Center(child: Text('Erro ao carregar'));
          }

          if (state is MovieDetailsLoaded) {
            final movie = state.movieDetail;

            return Stack(
              children: [
                Positioned.fill(
                  child:
                      movie.posterPath != null
                          ? Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                                fit: BoxFit.cover,
                              ),

                              BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 20,
                                  sigmaY: 20,
                                ),
                                child: Container(
                                  color: Colors.black.withValues(alpha: 0.6),
                                ),
                              ),
                            ],
                          )
                          : Container(color: Colors.black),
                ),

                SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 8),

                        if (movie.posterPath != null)
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                                height: 250,
                              ),
                            ),
                          ),

                        const SizedBox(height: 16),

                        Text(
                          movie.originalTitle,
                          style: Theme.of(
                            context,
                          ).textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 16),

                        Text(
                          movie.overview,
                          style: const TextStyle(
                            color: Colors.white70,
                            height: 1.4,
                          ),
                        ),

                        const SizedBox(height: 24),

                        _SectionTitle(title: 'Gêneros'),
                        const SizedBox(height: 8),

                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children:
                              movie.genres
                                  .map(
                                    (g) => Chip(
                                      label: Text(g.name),
                                      backgroundColor: Colors.white10,
                                      labelStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                  .toList(),
                        ),

                        const SizedBox(height: 24),

                        _SectionTitle(title: 'País'),
                        const SizedBox(height: 8),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              movie.productionCountries
                                  .map(
                                    (c) => Text(
                                      c.name,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                  )
                                  .toList(),
                        ),

                        const SizedBox(height: 24),

                        _SectionTitle(title: 'Produção'),
                        const SizedBox(height: 8),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              movie.productionCompanies
                                  .map(
                                    (c) => Text(
                                      c.name,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                  )
                                  .toList(),
                        ),

                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  bottom: 24,
                  right: 24,
                  child: FloatingActionButton(
                    onPressed: () {
                      //! implementar depois
                    },
                    backgroundColor: Colors.redAccent,
                    child: const Icon(Icons.favorite_border),
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
