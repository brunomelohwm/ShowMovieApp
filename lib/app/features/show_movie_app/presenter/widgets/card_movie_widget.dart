import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/movie_entity.dart';

class CardMovieWidget extends StatelessWidget {
  final MovieEntity movie;
  const CardMovieWidget({Key? key, required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(7),
        child: InkWell(
          borderRadius: BorderRadius.circular(6),
          focusColor: const Color.fromARGB(24, 158, 158, 158),
          highlightColor: const Color.fromARGB(24, 158, 158, 158),
          onTap: () {},
          child: SizedBox(
            width: 120,
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Container(
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                        ),
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
                                      fontWeight: FontWeight.w900),
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
                                value: (movie.voteAverage),
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  ((movie.voteAverage) < 3.0)
                                      ? const Color.fromARGB(255, 219, 52, 52)
                                      : ((movie.voteAverage) >= 3.0 &&
                                              (movie.voteAverage) < 7.0)
                                          ? const Color.fromARGB(
                                              207, 248, 245, 56)
                                          : const Color.fromARGB(
                                              129, 66, 224, 171),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(
                                value: (movie.voteAverage / 10),
                                backgroundColor:
                                    const Color.fromARGB(179, 3, 32, 4),
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  ((movie.voteAverage) < 3.0)
                                      ? const Color.fromARGB(255, 219, 52, 52)
                                      : ((movie.voteAverage) >= 3.0 &&
                                              (movie.voteAverage) < 7.0)
                                          ? const Color.fromARGB(
                                              255, 240, 230, 144)
                                          : const Color.fromARGB(
                                              255, 66, 224, 172),
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
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                    DateFormat("dd 'de' MMM 'de' y", "pt_BR")
                        .format(DateTime.parse(movie.releaseDate)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
