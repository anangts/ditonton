import 'package:ditonton/features/movie/presentation/bloc/bloc_export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/movie/domain/entities/movie.dart';

void main() {
  group('MovieSearchState', () {
    test('supports equality comparison', () {
      // Arrange
      final state1 = MovieSearchState(
        state: RequestState.loaded,
        searchResult: [
          Movie(
              id: 1,
              title: 'Movie 1',
              overview: 'Overview 1',
              posterPath: 'path1',
              releaseDate: '2024-08-30')
        ],
        message: 'Success',
      );
      final state2 = MovieSearchState(
        state: RequestState.loaded,
        searchResult: [
          Movie(
              id: 1,
              title: 'Movie 1',
              overview: 'Overview 1',
              posterPath: 'path1',
              releaseDate: '2024-08-30')
        ],
        message: 'Success',
      );
      final state3 = MovieSearchState(
        state: RequestState.error,
        searchResult: [
          Movie(
              id: 2,
              title: 'Movie 2',
              overview: 'Overview 2',
              posterPath: 'path2',
              releaseDate: '2024-08-31')
        ],
        message: 'Error',
      );

      // Act & Assert
      expect(state1, equals(state2));
      expect(state1, isNot(equals(state3)));
    });

    test('copyWith method works correctly', () {
      // Arrange
      final originalState = MovieSearchState(
        state: RequestState.loaded,
        searchResult: [
          Movie(
              id: 1,
              title: 'Movie 1',
              overview: 'Overview 1',
              posterPath: 'path1',
              releaseDate: '2024-08-30')
        ],
        message: 'Success',
      );

      // Act
      final updatedState = originalState.copyWith(
        state: RequestState.error,
        message: 'Updated Message',
      );

      // Assert
      expect(updatedState.state, RequestState.error);
      expect(updatedState.searchResult, originalState.searchResult);
      expect(updatedState.message, 'Updated Message');
    });

    test('props are correct', () {
      // Arrange
      final state = MovieSearchState(
        state: RequestState.loaded,
        searchResult: [
          Movie(
              id: 1,
              title: 'Movie 1',
              overview: 'Overview 1',
              posterPath: 'path1',
              releaseDate: '2024-08-30')
        ],
        message: 'Success',
      );

      // Act
      final props = state.props;

      // Assert
      expect(props, [
        RequestState.loaded,
        [
          Movie(
              id: 1,
              title: 'Movie 1',
              overview: 'Overview 1',
              posterPath: 'path1',
              releaseDate: '2024-08-30')
        ],
        'Success'
      ]);
    });
  });
}
