import 'package:ditonton/features/movie/domain/entities/entites.dart';
import 'package:ditonton/features/movie/presentation/bloc/bloc_export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton/common/state_enum.dart';

void main() {
  group('TopRatedMoviesState', () {
    test('supports value comparison', () {
      // Arrange & Act
      const state1 = TopRatedMoviesState();
      const state2 = TopRatedMoviesState();

      // Assert
      expect(state1, equals(state2));
    });

    test('has correct initial state', () {
      // Arrange & Act
      const state = TopRatedMoviesState();

      // Assert
      expect(state.state, equals(RequestState.empty));
      expect(state.movies, equals([]));
      expect(state.message, equals(''));
    });

    test('copyWith returns a new object with updated fields', () {
      // Arrange
      const state = TopRatedMoviesState();

      // Act
      final newState = state.copyWith(
        state: RequestState.loaded,
        movies: [
          Movie(
              id: 1,
              title: 'Test Movie',
              overview: 'Test Overview',
              posterPath: 'test.png')
        ],
        message: 'Test Message',
      );

      // Assert
      expect(newState.state, equals(RequestState.loaded));
      expect(
          newState.movies,
          equals([
            Movie(
                id: 1,
                title: 'Test Movie',
                overview: 'Test Overview',
                posterPath: 'test.png'),
          ]));
      expect(newState.message, equals('Test Message'));
    });

    test('props are correct', () {
      // Arrange & Act
      final state = TopRatedMoviesState(
        state: RequestState.loading,
        movies: [
          Movie(
              id: 1,
              title: 'Test Movie',
              overview: 'Test Overview',
              posterPath: 'test.png')
        ],
        message: 'Test Message',
      );

      // Assert
      expect(state.props, [
        RequestState.loading,
        [
          Movie(
              id: 1,
              title: 'Test Movie',
              overview: 'Test Overview',
              posterPath: 'test.png')
        ],
        'Test Message',
      ]);
    });
  });
}
