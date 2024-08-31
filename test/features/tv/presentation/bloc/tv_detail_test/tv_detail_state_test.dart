import 'package:ditonton/features/tv/presentation/bloc/bloc_export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton/features/tv/domain/entities/tv.dart';
import 'package:ditonton/features/tv/domain/entities/tv_detail.dart';
import 'package:ditonton/common/state_enum.dart';

void main() {
  group('TvDetailState', () {
    const testTvDetail = TvDetail(
      adult: false,
      backdropPath: '/backdropPath.jpg',
      genres: [],
      id: 1,
      originalName: 'Original Name',
      overview: 'Overview',
      posterPath: '/posterPath.jpg',
      releaseDate: '2022-12-12',
      runtime: 120,
      name: 'name',
      voteAverage: 7.5,
      voteCount: 1000,
    );

    final testTv = Tv(
      adult: false,
      backdropPath: '/backdropPath.jpg',
      genreIds: const [1, 2],
      id: 1,
      originalName: 'Original Name',
      overview: 'Overview',
      popularity: 1000.0,
      posterPath: '/posterPath.jpg',
      releaseDate: '2022-12-12',
      name: 'name',
      video: false,
      voteAverage: 7.5,
      voteCount: 1000,
    );

    test('supports value equality', () {
      expect(
        const TvDetailState(),
        const TvDetailState(),
      );
    });

    test('props are correct', () {
      expect(
        const TvDetailState().props,
        [
          null,
          RequestState.empty,
          [],
          RequestState.empty,
          '',
          false,
          '',
        ],
      );
    });

    test('copyWith returns new object with updated values', () {
      final newState = const TvDetailState().copyWith(
        tv: testTvDetail,
        tvState: RequestState.loaded,
        tvRecommendations: [testTv],
        recommendationState: RequestState.loaded,
        message: 'Error',
        isAddedToWatchlist: true,
        watchlistMessage: 'Added',
      );

      expect(newState.tv, testTvDetail);
      expect(newState.tvState, RequestState.loaded);
      expect(newState.tvRecommendations, [testTv]);
      expect(newState.recommendationState, RequestState.loaded);
      expect(newState.message, 'Error');
      expect(newState.isAddedToWatchlist, true);
      expect(newState.watchlistMessage, 'Added');
    });

    test('copyWith does not modify the original state', () {
      const originalState = TvDetailState();

      final newState = originalState.copyWith(
        tv: testTvDetail,
      );

      expect(newState.tv, testTvDetail);
      expect(originalState.tv, isNull); // Ensure original state is not changed
    });
  });
}
