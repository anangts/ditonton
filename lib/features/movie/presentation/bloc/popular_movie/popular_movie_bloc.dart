import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/movie/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/features/movie/presentation/bloc/popular_movie/popular_movie_event.dart';
import 'package:ditonton/features/movie/presentation/bloc/popular_movie/popular_movie_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;

  PopularMoviesBloc({required this.getPopularMovies})
      : super(const PopularMoviesState()) {
    on<FetchPopularMovie>(_onFetchPopularMovies);
  }

  Future<void> _onFetchPopularMovies(
    FetchPopularMovie event,
    Emitter<PopularMoviesState> emit,
  ) async {
    emit(state.copyWith(state: RequestState.loading));

    final result = await getPopularMovies.execute();

    result.fold(
      (failure) {
        emit(state.copyWith(
          state: RequestState.error,
          message: failure.message,
        ));
      },
      (movies) {
        emit(state.copyWith(
          state: RequestState.loaded,
          movies: movies,
        ));
      },
    );
  }
}
