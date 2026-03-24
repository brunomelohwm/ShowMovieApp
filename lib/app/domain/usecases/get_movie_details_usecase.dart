import 'package:show_movie_app/app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:show_movie_app/app/core/usecases/usecase.dart';
import 'package:show_movie_app/app/domain/entities/movie_detail_entity.dart';
import '../repositories/movie_repository.dart';

class GetMovieDetailUsecase implements Usecase<MovieDetailEntity, int> {
  final MovieRepository repository;

  GetMovieDetailUsecase({required this.repository});

  @override
  Future<Either<Failure, MovieDetailEntity>> call(int movieId) async {
    return await repository.getMovieDetail(movieId);
  }
}
