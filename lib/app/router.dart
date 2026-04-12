import 'package:go_router/go_router.dart';
import 'package:show_movie_app/app/features/presentation/movie_details/view/movie_details_page.dart';
import 'package:show_movie_app/app/features/presentation/home/view/movies_home_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => MoviesHomePage()),
    GoRoute(
      name: 'movieDetails',
      path: '/movie/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return MovieDetailsPage(movieId: id);
      },
    ),
  ],
);
