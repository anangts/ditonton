import 'package:ditonton/features/movie/presentation/bloc/bloc_export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton/features/movie/domain/entities/movie.dart';
import 'package:ditonton/features/movie/domain/entities/movie_detail.dart';
import 'package:ditonton/common/state_enum.dart';

void main() {
  group('MovieDetailState', () {
    const testMovieDetail = MovieDetail(
      adult: false,
      backdropPath: '/backdropPath.jpg',
      genres: [],
      id: 1,
      originalTitle: 'Original Title',
      overview: 'Overview',
      posterPath: '/posterPath.jpg',
      releaseDate: '2022-12-12',
      runtime: 120,
      title: 'Title',
      voteAverage: 7.5,
      voteCount: 1000,
    );

    final testMovie = Movie(
      adult: false,
      backdropPath: '/backdropPath.jpg',
      genreIds: const [1, 2],
      id: 1,
      originalTitle: 'Original Title',
      overview: 'Overview',
      popularity: 1000.0,
      posterPath: '/posterPath.jpg',
      releaseDate: '2022-12-12',
      title: 'Title',
      video: false,
      voteAverage: 7.5,
      voteCount: 1000,
    );

    test('supports value equality', () {
      expect(
        const MovieDetailState(),
        const MovieDetailState(),
      );
    });

    test('props are correct', () {
      expect(
        const MovieDetailState().props,
        [
          null,
          RequestState.empty,
          [],
          RequestState.empty,
          '',
          false,
          '',
        ],
      );
    });

    test('copyWith returns new object with updated values', () {
      final newState = const MovieDetailState().copyWith(
        movie: testMovieDetail,
        movieState: RequestState.loaded,
        movieRecommendations: [testMovie],
        recommendationState: RequestState.loaded,
        message: 'Error',
        isAddedToWatchlist: true,
        watchlistMessage: 'Added',
      );

      expect(newState.movie, testMovieDetail);
      expect(newState.movieState, RequestState.loaded);
      expect(newState.movieRecommendations, [testMovie]);
      expect(newState.recommendationState, RequestState.loaded);
      expect(newState.message, 'Error');
      expect(newState.isAddedToWatchlist, true);
      expect(newState.watchlistMessage, 'Added');
    });

    test('copyWith does not modify the original state', () {
      const originalState = MovieDetailState();

      final newState = originalState.copyWith(
        movie: testMovieDetail,
      );

      expect(newState.movie, testMovieDetail);
      expect(
          originalState.movie, isNull); // Ensure original state is not changed
    });
  });
}
