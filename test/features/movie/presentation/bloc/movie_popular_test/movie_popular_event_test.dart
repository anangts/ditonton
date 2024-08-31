import 'package:ditonton/features/movie/presentation/bloc/bloc_export.dart';
import 'package:flutter_test/flutter_test.dart'; 

void main() {
  group('PopularMoviesEvent', () {
    test('FetchPopularMovie supports value equality', () {
      expect(FetchPopularMovie(), FetchPopularMovie());
    });

    test('FetchPopularMovie props are correct', () {
      final fetchPopularMovie = FetchPopularMovie();
      expect(fetchPopularMovie.props, []);
    });
  });
}
