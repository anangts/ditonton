import 'package:ditonton/features/tv/presentation/bloc/bloc_export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv/domain/entities/tv.dart';

void main() {
  group('PopularTvState', () {
    const tState = RequestState.loaded;
    final tTv = <Tv>[
      Tv(
        id: 1,
        name: 'Tv 1',
        overview: 'Overview 1',
        posterPath: 'path1',
        releaseDate: '2024-08-30',
      ),
    ];
    const tMessage = 'Some message';

    test('supports value equality', () {
      expect(
        TvPopularState(
          state: tState,
          tvs: tTv,
          message: tMessage,
        ),
        TvPopularState(
          state: tState,
          tvs: tTv,
          message: tMessage,
        ),
      );
    });

    test('props are correct', () {
      expect(
        TvPopularState(
          state: tState,
          tvs: tTv,
          message: tMessage,
        ).props,
        [tState, tTv, tMessage],
      );
    });

    test('copyWith works correctly', () {
      const state = TvPopularState();

      final newState = state.copyWith(
        state: tState,
        tvs: tTv,
        message: tMessage,
      );

      expect(
        newState,
        TvPopularState(
          state: tState,
          tvs: tTv,
          message: tMessage,
        ),
      );
    });
  });
}
