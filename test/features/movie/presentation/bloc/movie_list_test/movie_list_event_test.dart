import 'package:ditonton/features/movie/presentation/bloc/bloc_export.dart';
import 'package:flutter_test/flutter_test.dart'; 
void main() {
  group('MovieListEvent', () {
    test('supports value comparison', () {
      expect(FetchNowPlayingMovies(), equals(FetchNowPlayingMovies()));
      expect(FetchPopularMovies(), equals(FetchPopularMovies()));
      expect(FetchTopRatedMovies(), equals(FetchTopRatedMovies()));
    });

    test('props are correct', () {
      expect(FetchNowPlayingMovies().props, []);
      expect(FetchPopularMovies().props, []);
      expect(FetchTopRatedMovies().props, []);
    });
  });
}
