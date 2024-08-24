import 'package:dartz/dartz.dart';
import 'package:ditonton/features/tv/domain/entities/tv.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/tv/domain/usecases/get_tv_now_playing.dart';
import 'package:ditonton/features/tv/domain/usecases/get_tv_popular.dart';
import 'package:ditonton/features/tv/domain/usecases/get_tv_top_rated.dart';
import 'package:ditonton/features/tv/presentation/provider/tv_list_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetTvNowPlaying, GetTvPopular, GetTvTopRated])
void main() {
  late TvListNotifier provider;
  late MockGetTvNowPlaying mockGetNowPlayingTv;
  late MockGetTvPopular mockGetPopularTv;
  late MockGetTvTopRated mockGetTopRatedTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTv = MockGetTvNowPlaying();
    mockGetPopularTv = MockGetTvPopular();
    mockGetTopRatedTv = MockGetTvTopRated();
    provider = TvListNotifier(
      getNowPlayingTv: mockGetNowPlayingTv,
      getPopularTv: mockGetPopularTv,
      getTopRatedTv: mockGetTopRatedTv,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTv = Tv(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    name: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tTvList = <Tv>[tTv];

  group('now playing tvs', () {
    test('initialState should be Empty', () {
      expect(provider.nowPlayingState, equals(RequestState.empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchNowPlayingTv();
      // assert
      verify(mockGetNowPlayingTv.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchNowPlayingTv();
      // assert
      expect(provider.nowPlayingState, RequestState.loading);
    });

    test('should change tvs when data is gotten successfully', () async {
      // arrange
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      await provider.fetchNowPlayingTv();
      // assert
      expect(provider.nowPlayingState, RequestState.loaded);
      expect(provider.nowPlayingTv, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchNowPlayingTv();
      // assert
      expect(provider.nowPlayingState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tvs', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTv.execute()).thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchPopularTv();
      // assert
      expect(provider.popularTvState, RequestState.loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change tvs data when data is gotten successfully', () async {
      // arrange
      when(mockGetPopularTv.execute()).thenAnswer((_) async => Right(tTvList));
      // act
      await provider.fetchPopularTv();
      // assert
      expect(provider.popularTvState, RequestState.loaded);
      expect(provider.popularTv, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTv();
      // assert
      expect(provider.popularTvState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated tvs', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchTopRatedTv();
      // assert
      expect(provider.topRatedTvState, RequestState.loading);
    });

    test('should change tvs data when data is gotten successfully', () async {
      // arrange
      when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Right(tTvList));
      // act
      await provider.fetchTopRatedTv();
      // assert
      expect(provider.topRatedTvState, RequestState.loaded);
      expect(provider.topRatedTv, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTv();
      // assert
      expect(provider.topRatedTvState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
