import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/movie/domain/usecases/get_watchlist_movies.dart';
import 'movie_watchlist_event.dart';
import 'movie_watchlist_state.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final GetWatchlistMovies getWatchlistMovies;

  MovieWatchlistBloc({required this.getWatchlistMovies})
      : super(const MovieWatchlistState()) {
    on<FetchWatchlistMovies>(_onFetchWatchlistMovies);
  }

  Future<void> _onFetchWatchlistMovies(
    FetchWatchlistMovies event,
    Emitter<MovieWatchlistState> emit,
  ) async {
    emit(state.copyWith(watchlistState: RequestState.loading));

    final result = await getWatchlistMovies.execute();

    result.fold(
      (failure) {
        emit(state.copyWith(
          watchlistState: RequestState.error,
          message: failure.message,
        ));
      },
      (movies) {
        emit(state.copyWith(
          watchlistState: RequestState.loaded,
          watchlistMovies: movies,
        ));
      },
    );
  }
}
