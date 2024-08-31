import 'package:ditonton/features/tv/presentation/bloc/bloc_export.dart';
import 'package:flutter_test/flutter_test.dart'; 
void main() {
  group('TvListEvent', () {
    test('supports value comparison', () {
      expect(FetchNowPlayingTv(), equals(FetchNowPlayingTv()));
      expect(FetchPopularTv(), equals(FetchPopularTv()));
      expect(FetchTopRatedTv(), equals(FetchTopRatedTv()));
    });

    test('props are correct', () {
      expect(FetchNowPlayingTv().props, []);
      expect(FetchPopularTv().props, []);
      expect(FetchTopRatedTv().props, []);
    });
  });
}
