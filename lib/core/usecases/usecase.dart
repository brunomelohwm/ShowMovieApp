import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failure.dart';

abstract class Usecase<Output, Input> {
  Future<Either<Failure, Output>> call(Input noParams);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
