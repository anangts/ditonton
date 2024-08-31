import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/movie/domain/entities/movie.dart';
import 'package:ditonton/features/movie/presentation/bloc/movie_watchlist/movie_watchlist_state.dart';

void main() {
  group('MovieWatchlistState', () {
    test('supports value equality', () {
      expect(
        const MovieWatchlistState(),
        equals(const MovieWatchlistState()),
      );
    });

    test('props are correct', () {
      const state = MovieWatchlistState();
      expect(state.props, [
        state.watchlistState,
        state.watchlistMovies,
        state.message,
      ]);
    });

    test('copyWith returns a new state with updated values', () {
      const state = MovieWatchlistState();
      final newMovies = [
        Movie(
            id: 1,
            title: 'Test Movie',
            overview: 'Overview',
            posterPath: 'path.png')
      ];
      const newMessage = 'New Message';
      const newRequestState = RequestState.loaded;

      final newState = state.copyWith(
        watchlistState: newRequestState,
        watchlistMovies: newMovies,
        message: newMessage,
      );

      expect(newState.watchlistState, newRequestState);
      expect(newState.watchlistMovies, newMovies);
      expect(newState.message, newMessage);
    });

    test('copyWith retains old values if null is passed', () {
      final state = MovieWatchlistState(
        watchlistState: RequestState.loaded,
        watchlistMovies: [
          Movie(
              id: 1,
              title: 'Test Movie',
              overview: 'Overview',
              posterPath: 'path.png')
        ],
        message: 'Old Message',
      );

      final newState = state.copyWith();

      expect(newState.watchlistState, state.watchlistState);
      expect(newState.watchlistMovies, state.watchlistMovies);
      expect(newState.message, state.message);
    });
  });
}
