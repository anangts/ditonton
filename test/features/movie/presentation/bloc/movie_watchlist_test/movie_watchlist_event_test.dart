import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton/features/movie/presentation/bloc/movie_watchlist/movie_watchlist_event.dart';

void main() {
  group('MovieWatchlistEvent', () {
    test('FetchWatchlistMovies supports value equality', () {
      expect(FetchWatchlistMovies(), equals(FetchWatchlistMovies()));
    });

    test('FetchWatchlistMovies props are correct', () {
      expect(FetchWatchlistMovies().props, equals([]));
    });
  });
}
