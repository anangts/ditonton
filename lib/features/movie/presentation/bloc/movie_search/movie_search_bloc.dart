 
import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/movie/domain/usecases/search_movies.dart';
import 'movie_search_event.dart';
import 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies searchMovies;

  MovieSearchBloc({required this.searchMovies}) : super(const MovieSearchState()) {
    on<FetchMovieSearch>(_onFetchMovieSearch);
  }

  Future<void> _onFetchMovieSearch(
    FetchMovieSearch event,
    Emitter<MovieSearchState> emit,
  ) async {
    emit(state.copyWith(state: RequestState.loading));

    final result = await searchMovies.execute(event.query);
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
          searchResult: movies,
        ));
      },
    );
  }
}
