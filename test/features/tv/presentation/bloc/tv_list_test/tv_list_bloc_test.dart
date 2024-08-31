import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/tv/domain/entities/entites.dart';
import 'package:ditonton/features/tv/presentation/bloc/bloc_export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ditonton/features/tv/domain/usecases/usecases.dart';
import 'package:ditonton/common/state_enum.dart';

import 'tv_list_bloc_test.mocks.dart';

// Create mock classes

@GenerateMocks([TvGetNowPlaying, TvGetPopular, TvGetTopRated, Failure])
void main() {
  late TvListBloc tvListBloc;
  late MockTvGetNowPlaying mockTvGetNowPlaying;
  late MockTvGetPopular mockTvGetPopular;
  late MockTvGetTopRated mockTvGetTopRated;
  late MockFailure mockFailure;

  setUp(() {
    mockTvGetNowPlaying = MockTvGetNowPlaying();
    mockTvGetPopular = MockTvGetPopular();
    mockTvGetTopRated = MockTvGetTopRated();
    mockFailure = MockFailure();
    tvListBloc = TvListBloc(
      getNowPlayingTvs: mockTvGetNowPlaying,
      getPopularTvs: mockTvGetPopular,
      getTopRatedTvs: mockTvGetTopRated,
    );
  });

  group('TvListBloc', () {
    test('initial state is correct', () {
      expect(tvListBloc.state, equals(const TvListState()));
    });

    blocTest<TvListBloc, TvListState>(
      'emits [loading, loaded] when FetchNowPlayingTv event is added',
      build: () {
        when(mockTvGetNowPlaying.execute()).thenAnswer(
          (_) async => Right([
            Tv(
                id: 1,
                name: 'Test Tv',
                overview: 'Test Overview',
                posterPath: 'test_path',
                releaseDate: '2024-08-30')
          ]),
        );
        return tvListBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingTv()),
      expect: () => [
        const TvListState(nowPlayingState: RequestState.loading),
        TvListState(
          nowPlayingState: RequestState.loaded,
          tvNowPlaying: [
            Tv(
                id: 1,
                name: 'Test Tv',
                overview: 'Test Overview',
                posterPath: 'test_path',
                releaseDate: '2024-08-30')
          ],
        ),
      ],
    );

    blocTest<TvListBloc, TvListState>(
      'emits [loading, error] when FetchNowPlayingTv event is added and fails',
      build: () {
        when(mockTvGetNowPlaying.execute()).thenAnswer(
          (_) async => Left(mockFailure),
        );
        when(mockFailure.message).thenReturn('Error');
        return tvListBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingTv()),
      expect: () => [
        const TvListState(nowPlayingState: RequestState.loading),
        const TvListState(
          nowPlayingState: RequestState.error,
          message: 'Error',
        ),
      ],
    );

    blocTest<TvListBloc, TvListState>(
      'emits [loading, loaded] when FetchPopularTv event is added',
      build: () {
        when(mockTvGetPopular.execute()).thenAnswer(
          (_) async => Right([
            Tv(
                id: 1,
                name: 'Test Tv',
                overview: 'Test Overview',
                posterPath: 'test_path',
                releaseDate: '2024-08-30')
          ]),
        );
        return tvListBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvs()),
      expect: () => [
        const TvListState(tvPopularState: RequestState.loading),
        TvListState(
          tvPopularState: RequestState.loaded,
          popularTvs: [
            Tv(
                id: 1,
                name: 'Test Tv',
                overview: 'Test Overview',
                posterPath: 'test_path',
                releaseDate: '2024-08-30')
          ],
        ),
      ],
    );

    blocTest<TvListBloc, TvListState>(
      'emits [loading, error] when FetchPopularTv event is added and fails',
      build: () {
        when(mockTvGetPopular.execute()).thenAnswer(
          (_) async => Left(mockFailure),
        );
        when(mockFailure.message).thenReturn('Error');
        return tvListBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvs()),
      expect: () => [
        const TvListState(tvPopularState: RequestState.loading),
        const TvListState(
          tvPopularState: RequestState.error,
          message: 'Error',
        ),
      ],
    );

    blocTest<TvListBloc, TvListState>(
      'emits [loading, loaded] when FetchTopRatedTv event is added',
      build: () {
        when(mockTvGetTopRated.execute()).thenAnswer(
          (_) async => Right([
            Tv(
                id: 1,
                name: 'Test Tv',
                overview: 'Test Overview',
                posterPath: 'test_path',
                releaseDate: '2024-08-30')
          ]),
        );
        return tvListBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTvs()),
      expect: () => [
        const TvListState(tvTopRatedState: RequestState.loading),
        TvListState(
          tvTopRatedState: RequestState.loaded,
          tvTopRated: [
            Tv(
                id: 1,
                name: 'Test Tv',
                overview: 'Test Overview',
                posterPath: 'test_path',
                releaseDate: '2024-08-30')
          ],
        ),
      ],
    );

    blocTest<TvListBloc, TvListState>(
      'emits [loading, error] when FetchTopRatedTv event is added and fails',
      build: () {
        when(mockTvGetTopRated.execute()).thenAnswer(
          (_) async => Left(mockFailure),
        );
        when(mockFailure.message).thenReturn('Error');
        return tvListBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTvs()),
      expect: () => [
        const TvListState(tvTopRatedState: RequestState.loading),
        const TvListState(
          tvTopRatedState: RequestState.error,
          message: 'Error',
        ),
      ],
    );
  });
}
