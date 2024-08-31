import 'package:ditonton/features/movie/presentation/bloc/bloc_export.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TopRatedMoviesEvent', () {
    test('FetchTopRatedMovie supports value comparison', () {
      // Arrange & Act
      final event1 = FetchTopRatedMovie();
      final event2 = FetchTopRatedMovie();

      // Assert
      expect(event1, equals(event2));
    });

    test('props are correct for FetchTopRatedMovie', () {
      // Arrange & Act
      final event = FetchTopRatedMovie();

      // Assert
      expect(event.props, []);
    });
  });
}
