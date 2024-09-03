import 'package:ditonton/features/movie/presentation/bloc/bloc_export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton/features/movie/domain/entities/movie.dart';
import 'package:ditonton/common/state_enum.dart';

void main() {
  group('MovieListState', () {
    final movie = Movie(
        id: 1,
        title: 'Test Movie',
        overview: 'Test Overview',
        posterPath: 'test_path',
        releaseDate: '2024-08-30');
    final nowPlayingMovies = [movie];
    final popularMovies = [movie];
    final topRatedMovies = [movie];
    const message = 'Test Message';

    test('supports value comparison', () {
      expect(
        MovieListState(
          movieNowPlaying: nowPlayingMovies,
          movieNowPlayingState: RequestState.loaded,
          moviePopular: popularMovies,
          moviePopularState: RequestState.loaded,
          movieTopRated: topRatedMovies,
          movieTopRatedState: RequestState.loaded,
          message: message,
        ),
        equals(
          MovieListState(
            movieNowPlaying: nowPlayingMovies,
            movieNowPlayingState: RequestState.loaded,
            moviePopular: popularMovies,
            moviePopularState: RequestState.loaded,
            movieTopRated: topRatedMovies,
            movieTopRatedState: RequestState.loaded,
            message: message,
          ),
        ),
      );
    });

    test('copyWith works correctly', () {
      final state = MovieListState(
        movieNowPlaying: nowPlayingMovies,
        movieNowPlayingState: RequestState.loaded,
        moviePopular: popularMovies,
        moviePopularState: RequestState.loaded,
        movieTopRated: topRatedMovies,
        movieTopRatedState: RequestState.loaded,
        message: message,
      );

      final newState = state.copyWith(
        nowPlayingMovies: [],
        message: 'New Message',
      );

      expect(newState.movieNowPlaying, []);
      expect(newState.movieNowPlayingState, RequestState.loaded);
      expect(newState.moviePopular, popularMovies);
      expect(newState.moviePopularState, RequestState.loaded);
      expect(newState.movieTopRated, topRatedMovies);
      expect(newState.movieTopRatedState, RequestState.loaded);
      expect(newState.message, 'New Message');
    });

    test('props are correct', () {
      final state = MovieListState(
        movieNowPlaying: nowPlayingMovies,
        movieNowPlayingState: RequestState.loaded,
        moviePopular: popularMovies,
        moviePopularState: RequestState.loaded,
        movieTopRated: topRatedMovies,
        movieTopRatedState: RequestState.loaded,
        message: message,
      );

      expect(
        state.props,
        equals([
          nowPlayingMovies,
          RequestState.loaded,
          popularMovies,
          RequestState.loaded,
          topRatedMovies,
          RequestState.loaded,
          message,
        ]),
      );
    });
  });
}
