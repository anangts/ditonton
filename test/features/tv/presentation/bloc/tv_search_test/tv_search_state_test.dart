import 'package:ditonton/features/tv/presentation/bloc/bloc_export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv/domain/entities/tv.dart';

void main() {
  group('TvSearchState', () {
    test('supports equality comparison', () {
      // Arrange
      final state1 = TvSearchState(
        state: RequestState.loaded,
        searchResult: [
          Tv(
              id: 1,
              name: 'Tv 1',
              overview: 'Overview 1',
              posterPath: 'path1',
              releaseDate: '2024-08-30')
        ],
        message: 'Success',
      );
      final state2 = TvSearchState(
        state: RequestState.loaded,
        searchResult: [
          Tv(
              id: 1,
              name: 'Tv 1',
              overview: 'Overview 1',
              posterPath: 'path1',
              releaseDate: '2024-08-30')
        ],
        message: 'Success',
      );
      final state3 = TvSearchState(
        state: RequestState.error,
        searchResult: [
          Tv(
              id: 2,
              name: 'Tv 2',
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
      final originalState = TvSearchState(
        state: RequestState.loaded,
        searchResult: [
          Tv(
              id: 1,
              name: 'Tv 1',
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
      final state = TvSearchState(
        state: RequestState.loaded,
        searchResult: [
          Tv(
              id: 1,
              name: 'Tv 1',
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
          Tv(
              id: 1,
              name: 'Tv 1',
              overview: 'Overview 1',
              posterPath: 'path1',
              releaseDate: '2024-08-30')
        ],
        'Success'
      ]);
    });
  });
}
