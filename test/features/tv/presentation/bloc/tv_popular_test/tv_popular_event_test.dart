import 'package:ditonton/features/tv/presentation/bloc/bloc_export.dart';
import 'package:flutter_test/flutter_test.dart'; 

void main() {
  group('PopularTvEvent', () {
    test('FetchPopularTv supports value equality', () {
      expect(FetchPopularTv(), FetchPopularTv());
    });

    test('FetchPopularTv props are correct', () {
      final fetchPopularTv = FetchPopularTv();
      expect(fetchPopularTv.props, []);
    });
  });
}
