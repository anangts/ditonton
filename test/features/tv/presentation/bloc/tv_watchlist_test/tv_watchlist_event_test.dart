import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton/features/tv/presentation/bloc/tv_watchlist/tv_watchlist_event.dart';

void main() {
  group('TvWatchlistEvent', () {
    test('FetchWatchlistTv supports value equality', () {
      expect(FetchWatchlistTv(), equals(FetchWatchlistTv()));
    });

    test('FetchWatchlistTv props are correct', () {
      expect(FetchWatchlistTv().props, equals([]));
    });
  });
}
