import 'package:ditonton/features/tv/presentation/bloc/bloc_export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton/features/tv/domain/entities/tv_detail.dart';

void main() {
  group('TvDetailEvent', () {
    const testId = 1;
    const testTvDetail = TvDetail(
      adult: false,
      backdropPath: '/backdropPath.jpg',
      genres: [],
      id: testId,
      originalName: 'Original Name',
      overview: 'Overview',
      posterPath: '/posterPath.jpg',
      releaseDate: '2022-12-12',
      runtime: 120,
      name: 'name',
      voteAverage: 7.5,
      voteCount: 1000,
    );

    test('FetchTvDetail event supports value equality', () {
      expect(const FetchTvDetail(testId), const FetchTvDetail(testId));
    });

    test('FetchTvDetail event has correct props', () {
      expect(const FetchTvDetail(testId).props, [testId]);
    });

    test('AddToWatchlist event supports value equality', () {
      expect(const AddToWatchlist(testTvDetail),
          const AddToWatchlist(testTvDetail));
    });

    test('AddToWatchlist event has correct props', () {
      expect(const AddToWatchlist(testTvDetail).props, [testTvDetail]);
    });

    test('RemoveFromWatchlist event supports value equality', () {
      expect(const RemoveFromWatchlist(testTvDetail),
          const RemoveFromWatchlist(testTvDetail));
    });

    test('RemoveFromWatchlist event has correct props', () {
      expect(const RemoveFromWatchlist(testTvDetail).props, [testTvDetail]);
    });

    test('LoadWatchlistStatus event supports value equality', () {
      expect(
          const LoadWatchlistStatus(testId), const LoadWatchlistStatus(testId));
    });

    test('LoadWatchlistStatus event has correct props', () {
      expect(const LoadWatchlistStatus(testId).props, [testId]);
    });
  });
}
