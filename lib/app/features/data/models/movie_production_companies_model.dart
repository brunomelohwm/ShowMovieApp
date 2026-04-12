import 'package:show_movie_app/app/features/domain/entities/movie_production_companies_entity.dart';

class MovieProductionCompaniesModel extends MovieProductionCompaniesEntity {
  const MovieProductionCompaniesModel({
    required super.id,
    required super.logoPath,
    required super.name,
    required super.originCountry,
  });

  factory MovieProductionCompaniesModel.fromJson(Map<String, dynamic> json) {
    return MovieProductionCompaniesModel(
      id: json['id'],
      logoPath: json['logo_path'],
      name: json['name'],
      originCountry: json['origin_country'],
    );
  }

  static List<MovieProductionCompaniesModel> fromJsonList(
    List<dynamic> jsonList,
  ) {
    List<MovieProductionCompaniesModel> listProductionCompanies = [];
    for (var json in jsonList) {
      listProductionCompanies.add(MovieProductionCompaniesModel.fromJson(json));
    }
    return listProductionCompanies;
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
