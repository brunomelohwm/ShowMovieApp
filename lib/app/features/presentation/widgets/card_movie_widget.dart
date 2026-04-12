import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:show_movie_app/app/features/presentation/extenseions/movie_formmater.dart';
import '../../domain/entities/movie_entity.dart';

class CardMovieWidget extends StatelessWidget {
  final MovieEntity movie;

  const CardMovieWidget({super.key, required this.movie});
  @override
  Widget build(BuildContext context) {
    final score = movie.voteAverage / 10;

    Color getColor(double value) {
      if (value < 0.3) return const Color.fromARGB(255, 219, 52, 52);
      if (value < 0.7) return const Color.fromARGB(255, 240, 230, 144);
      return const Color.fromARGB(255, 66, 224, 172);
    }

    return Container(
      padding: const EdgeInsets.all(7),
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        focusColor: const Color.fromARGB(24, 158, 158, 158),
        highlightColor: const Color.fromARGB(24, 158, 158, 158),
        onTap: () {
          FocusScope.of(context).unfocus();
          context.pushNamed(
            'movieDetails',
            pathParameters: {'id': movie.id.toString()},
          );
        },
        child: SizedBox(
          width: 120,
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (_, _) => Container(color: Colors.grey[300]),
                      errorWidget: (_, _, _) => const Icon(Icons.error),
                    ),
                  ),
                  Positioned(
                    right: -7,
                    bottom: 140,
                    child: IconButton(
                      icon: const Icon(Icons.pending, size: 20),
                      color: const Color.fromARGB(216, 158, 158, 158),
                      onPressed: () {},
                    ),
                  ),
                  Positioned(
                    right: 80.0,
                    bottom: -15.0,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: const ShapeDecoration(
                        shape: CircleBorder(),
                        color: Color.fromARGB(255, 3, 32, 4),
                      ),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ((movie.voteAverage * 10).toInt().toString()),
                                style: const TextStyle(
                                  fontSize: 9,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const Text(
                                '%',
                                style: TextStyle(
                                  fontSize: 4,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              value: score,
                              backgroundColor: const Color.fromARGB(
                                179,
                                3,
                                32,
                                4,
                              ),
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                getColor(score),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                alignment: Alignment.topLeft,
                child: Text(
                  movie.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                  movie.formattedReleaseDate,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
