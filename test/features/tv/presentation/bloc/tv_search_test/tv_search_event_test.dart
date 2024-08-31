import 'package:ditonton/features/tv/presentation/bloc/bloc_export.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TvSearchEvent', () {
    test('supports equality comparison', () {
      // Arrange
      const event1 = FetchTvSearch('query1');
      const event2 = FetchTvSearch('query1');
      const event3 = FetchTvSearch('query2');

      // Act & Assert
      expect(event1, equals(event2));
      expect(event1, isNot(equals(event3)));
      expect(event2, isNot(equals(event3)));
    });

    test('has correct props', () {
      // Arrange
      const event = FetchTvSearch('query1');

      // Act
      final props = event.props;

      // Assert
      expect(props, ['query1']);
    });
  });
}
