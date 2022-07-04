import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/movie_entity.dart';
import '../repositories/movie_repository.dart';

class GetMoviePopularUsecase implements Usecase<List<MovieEntity>, NoParams> {
  final MovieRepository repository;

  GetMoviePopularUsecase({required this.repository});

  @override
  Future<Either<Failure, List<MovieEntity>>> call(noParams) async {
    return await repository.getMoviePopular();
  }
}
