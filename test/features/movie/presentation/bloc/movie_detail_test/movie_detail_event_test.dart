import 'package:ditonton/features/movie/presentation/bloc/bloc_export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton/features/movie/domain/entities/movie_detail.dart';

void main() {
  group('MovieDetailEvent', () {
    const testId = 1;
    const testMovieDetail = MovieDetail(
      adult: false,
      backdropPath: '/backdropPath.jpg',
      genres: [],
      id: testId,
      originalTitle: 'Original Title',
      overview: 'Overview',
      posterPath: '/posterPath.jpg',
      releaseDate: '2022-12-12',
      runtime: 120,
      title: 'Title',
      voteAverage: 7.5,
      voteCount: 1000,
    );

    test('FetchMovieDetail event supports value equality', () {
      expect(const FetchMovieDetail(testId), const FetchMovieDetail(testId));
    });

    test('FetchMovieDetail event has correct props', () {
      expect(const FetchMovieDetail(testId).props, [testId]);
    });

    test('AddToWatchlist event supports value equality', () {
      expect(const AddToWatchlist(testMovieDetail),
          const AddToWatchlist(testMovieDetail));
    });

    test('AddToWatchlist event has correct props', () {
      expect(const AddToWatchlist(testMovieDetail).props, [testMovieDetail]);
    });

    test('RemoveFromWatchlist event supports value equality', () {
      expect(const RemoveFromWatchlist(testMovieDetail),
          const RemoveFromWatchlist(testMovieDetail));
    });

    test('RemoveFromWatchlist event has correct props', () {
      expect(
          const RemoveFromWatchlist(testMovieDetail).props, [testMovieDetail]);
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
