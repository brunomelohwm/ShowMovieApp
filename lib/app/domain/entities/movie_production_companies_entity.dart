import 'package:equatable/equatable.dart';

class MovieProductionCompaniesEntity extends Equatable {
  final int id;
  final String name;
  final String logoPath;
  final String originCountry;
  const MovieProductionCompaniesEntity({
    required this.id,
    required this.name,
    required this.logoPath,
    required this.originCountry,
  });

  @override
  List<Object> get props => [
        id,
        name,
        logoPath,
        originCountry,
      ];
}
