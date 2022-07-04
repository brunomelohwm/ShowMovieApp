import 'package:show_movie_app/app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:show_movie_app/app/core/usecases/usecase.dart';
import '../entities/movie_entity.dart';
import '../repositories/movie_repository.dart';

class GetMovieFreeToWatchUsecase
    implements Usecase<List<MovieEntity>, NoParams> {
  final MovieRepository repository;

  GetMovieFreeToWatchUsecase({required this.repository});

  @override
  Future<Either<Failure, List<MovieEntity>>> call(noParams) async {
    return await repository.getMovieFreeToWatch();
  }
}
