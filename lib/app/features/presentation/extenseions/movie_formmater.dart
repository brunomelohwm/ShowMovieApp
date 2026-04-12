import 'package:intl/intl.dart';
import 'package:show_movie_app/app/features/domain/entities/movie_entity.dart';

extension MovieFormatter on MovieEntity {
  String get formattedReleaseDate {
    final date = DateTime.tryParse(releaseDate);
    if (date == null) return 'Data indisponível';

    return DateFormat("dd 'de' MMM 'de' y").format(date);
  }
}
