import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/movie/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/features/movie/presentation/bloc/movie_top_rated/movie_top_rated_event.dart';
import 'package:ditonton/features/movie/presentation/bloc/movie_top_rated/movie_top_rated_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesBloc({required this.getTopRatedMovies})
      : super(const TopRatedMoviesState()) {
    on<FetchTopRatedMovie>(_onFetchTopRatedMovies);
  }

  Future<void> _onFetchTopRatedMovies(
    FetchTopRatedMovie event,
    Emitter<TopRatedMoviesState> emit,
  ) async {
    emit(state.copyWith(state: RequestState.loading));

    final result = await getTopRatedMovies.execute();

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
