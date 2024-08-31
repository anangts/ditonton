import 'package:ditonton/features/movie/presentation/bloc/bloc_export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/movie/domain/entities/movie.dart';

void main() {
  group('PopularMoviesState', () {
    const tState = RequestState.loaded;
    final tMovies = <Movie>[
      Movie(
        id: 1,
        title: 'Movie 1',
        overview: 'Overview 1',
        posterPath: 'path1',
        releaseDate: '2024-08-30',
      ),
    ];
    const tMessage = 'Some message';

    test('supports value equality', () {
      expect(
        PopularMoviesState(
          state: tState,
          movies: tMovies,
          message: tMessage,
        ),
        PopularMoviesState(
          state: tState,
          movies: tMovies,
          message: tMessage,
        ),
      );
    });

    test('props are correct', () {
      expect(
        PopularMoviesState(
          state: tState,
          movies: tMovies,
          message: tMessage,
        ).props,
        [tState, tMovies, tMessage],
      );
    });

    test('copyWith works correctly', () {
      const state = PopularMoviesState();

      final newState = state.copyWith(
        state: tState,
        movies: tMovies,
        message: tMessage,
      );

      expect(
        newState,
        PopularMoviesState(
          state: tState,
          movies: tMovies,
          message: tMessage,
        ),
      );
    });
  });
}
