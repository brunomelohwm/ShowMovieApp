import 'package:equatable/equatable.dart';

class MovieGenresEntity extends Equatable {
  final int id;
  final String name;
  const MovieGenresEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];
}
