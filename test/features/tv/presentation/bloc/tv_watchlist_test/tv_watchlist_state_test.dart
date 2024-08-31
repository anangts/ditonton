import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv/domain/entities/tv.dart';
import 'package:ditonton/features/tv/presentation/bloc/tv_watchlist/tv_watchlist_state.dart';

void main() {
  group('TvWatchlistState', () {
    test('supports value equality', () {
      expect(
        const TvWatchlistState(),
        equals(const TvWatchlistState()),
      );
    });

    test('props are correct', () {
      const state = TvWatchlistState();
      expect(state.props, [
        state.watchlistState,
        state.watchlistTv,
        state.message,
      ]);
    });

    test('copyWith returns a new state with updated values', () {
      const state = TvWatchlistState();
      final newTv = [
        Tv(
            id: 1,
            name: 'Test Tv',
            overview: 'Overview',
            posterPath: 'path.png')
      ];
      const newMessage = 'New Message';
      const newRequestState = RequestState.loaded;

      final newState = state.copyWith(
        watchlistState: newRequestState,
        watchlistTv: newTv,
        message: newMessage,
      );

      expect(newState.watchlistState, newRequestState);
      expect(newState.watchlistTv, newTv);
      expect(newState.message, newMessage);
    });

    test('copyWith retains old values if null is passed', () {
      final state = TvWatchlistState(
        watchlistState: RequestState.loaded,
        watchlistTv: [
          Tv(
              id: 1,
              name: 'Test Tv',
              overview: 'Overview',
              posterPath: 'path.png')
        ],
        message: 'Old Message',
      );

      final newState = state.copyWith();

      expect(newState.watchlistState, state.watchlistState);
      expect(newState.watchlistTv, state.watchlistTv);
      expect(newState.message, state.message);
    });
  });
}
