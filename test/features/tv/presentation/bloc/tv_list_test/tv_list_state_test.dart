import 'package:ditonton/features/tv/presentation/bloc/bloc_export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton/features/tv/domain/entities/tv.dart';
import 'package:ditonton/common/state_enum.dart';

void main() {
  group('TvListState', () {
    final tv = Tv(
        id: 1,
        name: 'Test Tv',
        overview: 'Test Overview',
        posterPath: 'test_path',
        releaseDate: '2024-08-30');
    final nowPlayingTv = [tv];
    final popularTv = [tv];
    final topRatedTv = [tv];
    const message = 'Test Message';

    test('supports value comparison', () {
      expect(
        TvListState(
          tvNowPlaying: nowPlayingTv,
          nowPlayingState: RequestState.loaded,
          popularTvs: popularTv,
          tvPopularState: RequestState.loaded,
          tvTopRated: topRatedTv,
          tvTopRatedState: RequestState.loaded,
          message: message,
        ),
        equals(
          TvListState(
            tvNowPlaying: nowPlayingTv,
            nowPlayingState: RequestState.loaded,
            popularTvs: popularTv,
            tvPopularState: RequestState.loaded,
            tvTopRated: topRatedTv,
            tvTopRatedState: RequestState.loaded,
            message: message,
          ),
        ),
      );
    });

    test('copyWith works correctly', () {
      final state = TvListState(
        tvNowPlaying: nowPlayingTv,
        nowPlayingState: RequestState.loaded,
        popularTvs: popularTv,
        tvPopularState: RequestState.loaded,
        tvTopRated: topRatedTv,
        tvTopRatedState: RequestState.loaded,
        message: message,
      );

      final newState = state.copyWith(
        nowPlayingTvs: [],
        message: 'New Message',
      );

      expect(newState.tvNowPlaying, []);
      expect(newState.nowPlayingState, RequestState.loaded);
      expect(newState.popularTvs, popularTv);
      expect(newState.tvPopularState, RequestState.loaded);
      expect(newState.tvTopRated, topRatedTv);
      expect(newState.tvTopRatedState, RequestState.loaded);
      expect(newState.message, 'New Message');
    });

    test('props are correct', () {
      final state = TvListState(
        tvNowPlaying: nowPlayingTv,
        nowPlayingState: RequestState.loaded,
        popularTvs: popularTv,
        tvPopularState: RequestState.loaded,
        tvTopRated: topRatedTv,
        tvTopRatedState: RequestState.loaded,
        message: message,
      );

      expect(
        state.props,
        equals([
          nowPlayingTv,
          RequestState.loaded,
          popularTv,
          RequestState.loaded,
          topRatedTv,
          RequestState.loaded,
          message,
        ]),
      );
    });
  });
}
