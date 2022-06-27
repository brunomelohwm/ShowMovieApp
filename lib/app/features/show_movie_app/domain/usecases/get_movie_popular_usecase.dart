import 'package:dartz/dartz.dart';
import 'package:show_movie_app/app/core/error/failures.dart';
import 'package:show_movie_app/app/core/usecases/usecase.dart';
import 'package:show_movie_app/app/features/show_movie_app/domain/entities/movie_entity.dart';
import 'package:show_movie_app/app/features/show_movie_app/domain/repositories/movie_repository.dart';

class GetMoviePopularUsecase implements Usecase<List<MovieEntity>, NoParams> {
  final MovieRepository repository;

  GetMoviePopularUsecase({required this.repository});

  @override
  Future<Either<Failure, List<MovieEntity>>> call(noParams) async {
    return await repository.getMoviePopular();
  }
}
