import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:show_movie_app/app/features/domain/usecases/get_movie_details_usecase.dart';
import 'package:show_movie_app/app/features/presentation/movie_details/bloc/movie_details_event.dart';
import 'package:show_movie_app/app/features/presentation/movie_details/bloc/movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetMovieDetailUsecase getMovieDetailUsecase;
  MovieDetailsBloc(this.getMovieDetailUsecase) : super(MovieDetailsInitial()) {
    on<GetMovieDetails>(_onGetMovieDetail);
  }

  Future<void> _onGetMovieDetail(
    GetMovieDetails event,
    Emitter<MovieDetailsState> emit,
  ) async {
    emit(MovieDetailsLoading());

    final result = await getMovieDetailUsecase.call(event.movieId);
    result.fold(
      (failure) => emit(MovieDetailsError()),
      (movieDetail) => emit(MovieDetailsLoaded(movieDetail)),
    );
  }
}
