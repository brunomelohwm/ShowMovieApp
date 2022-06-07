import 'package:dartz/dartz.dart';
import 'package:show_movie_app/core/error/failure.dart';
import 'package:show_movie_app/core/usecases/usecase.dart';
import 'package:show_movie_app/features/show_movie_app/domain/entities/movie_entity.dart';
import 'package:show_movie_app/features/show_movie_app/domain/repositories/movie_repository.dart';

class GetMoviePopular implements Usecase<List<MovieEntity>, NoParams> {
  final MovieRepository repository;

  GetMoviePopular({required this.repository});

  @override
  Future<Either<Failure, List<MovieEntity>>> call(noParams) async {
    return await repository.getMoviePopular();
  }
}
