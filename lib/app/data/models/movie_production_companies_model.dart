import 'package:show_movie_app/app/domain/entities/movie_production_companies_entity.dart';

class MovieProductionCompaniesModel extends MovieProductionCompaniesEntity {
  const MovieProductionCompaniesModel({
    required int id,
    required String logoPath,
    required String name,
    required String originCountry,
  }) : super(
            id: id,
            logoPath: logoPath,
            name: name,
            originCountry: originCountry);

  factory MovieProductionCompaniesModel.fromJson(Map<String, dynamic> json) {
    return MovieProductionCompaniesModel(
      id: json['id'],
      logoPath: json['logo_path'],
      name: json['name'],
      originCountry: json['origin_country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'logo_path': logoPath,
      'name': name,
      'origin_country': originCountry,
    };
  }
}
