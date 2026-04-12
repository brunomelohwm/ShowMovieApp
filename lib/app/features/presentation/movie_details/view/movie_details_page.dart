import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:show_movie_app/app/features/presentation/movie_details/bloc/movie_details_bloc.dart';
import 'package:show_movie_app/app/features/presentation/movie_details/bloc/movie_details_event.dart';
import 'package:show_movie_app/app/features/presentation/movie_details/view/movie_details_view.dart';
import 'package:show_movie_app/injection_container.dart';

class MovieDetailsPage extends StatelessWidget {
  final int movieId;

  const MovieDetailsPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MovieDetailsBloc>()..add(GetMovieDetails(movieId)),
      child: const MovieDetailsView(),
    );
  }
}
