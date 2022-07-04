import 'package:equatable/equatable.dart';

class MovieProductionCountriesEntity extends Equatable {
  final String iso31611;
  final String name;

  const MovieProductionCountriesEntity(
      {required this.iso31611, required this.name});

  @override
  List<Object> get props => [iso31611];
}
