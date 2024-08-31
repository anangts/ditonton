import 'package:ditonton/features/tv/domain/entities/entites.dart';
import 'package:ditonton/features/tv/presentation/bloc/bloc_export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton/common/state_enum.dart';

void main() {
  group('TvTopRatedState', () {
    test('supports value comparison', () {
      // Arrange & Act
      const state1 = TvTopRatedState();
      const state2 = TvTopRatedState();

      // Assert
      expect(state1, equals(state2));
    });

    test('has correct initial state', () {
      // Arrange & Act
      const state = TvTopRatedState();

      // Assert
      expect(state.state, equals(RequestState.empty));
      expect(state.tvs, equals([]));
      expect(state.message, equals(''));
    });

    test('copyWith returns a new object with updated fields', () {
      // Arrange
      const state = TvTopRatedState();

      // Act
      final newState = state.copyWith(
        state: RequestState.loaded,
        tvs: [
          Tv(
              id: 1,
              name: 'Test Tv',
              overview: 'Test Overview',
              posterPath: 'test.png')
        ],
        message: 'Test Message',
      );

      // Assert
      expect(newState.state, equals(RequestState.loaded));
      expect(
          newState.tvs,
          equals([
            Tv(
                id: 1,
                name: 'Test Tv',
                overview: 'Test Overview',
                posterPath: 'test.png'),
          ]));
      expect(newState.message, equals('Test Message'));
    });

    test('props are correct', () {
      // Arrange & Act
      final state = TvTopRatedState(
        state: RequestState.loading,
        tvs: [
          Tv(
              id: 1,
              name: 'Test Tv',
              overview: 'Test Overview',
              posterPath: 'test.png')
        ],
        message: 'Test Message',
      );

      // Assert
      expect(state.props, [
        RequestState.loading,
        [
          Tv(
              id: 1,
              name: 'Test Tv',
              overview: 'Test Overview',
              posterPath: 'test.png')
        ],
        'Test Message',
      ]);
    });
  });
}
