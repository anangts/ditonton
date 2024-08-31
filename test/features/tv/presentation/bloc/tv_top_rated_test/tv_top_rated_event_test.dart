import 'package:ditonton/features/tv/presentation/bloc/bloc_export.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TopRatedTvEvent', () {
    test('FetchTopRatedTv supports value comparison', () {
      // Arrange & Act
      final event1 = FetchTopRatedTv();
      final event2 = FetchTopRatedTv();

      // Assert
      expect(event1, equals(event2));
    });

    test('props are correct for FetchTopRatedTv', () {
      // Arrange & Act
      final event = FetchTopRatedTv();

      // Assert
      expect(event.props, []);
    });
  });
}
