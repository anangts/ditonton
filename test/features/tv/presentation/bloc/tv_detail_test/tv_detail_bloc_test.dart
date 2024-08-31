import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/features/tv/domain/entities/entites.dart';
import 'package:ditonton/features/tv/domain/usecases/usecases.dart';
import 'package:ditonton/features/tv/presentation/bloc/bloc_export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';

import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  TvGetDetail,
  TvGetRecommendations,
  TvGetWatchListStatus,
  TvSaveWatchlist,
  TvRemoveWatchlist,
])
void main() {
  late TvDetailBloc bloc;
  late MockTvGetDetail mockGetTvDetail;
  late MockTvGetRecommendations mockGetTvRecommendations;
  late MockTvGetWatchListStatus mockGetWatchListStatus;
  late MockTvSaveWatchlist mockSaveWatchlist;
  late MockTvRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetTvDetail = MockTvGetDetail();
    mockGetTvRecommendations = MockTvGetRecommendations();
    mockGetWatchListStatus = MockTvGetWatchListStatus();
    mockSaveWatchlist = MockTvSaveWatchlist();
    mockRemoveWatchlist = MockTvRemoveWatchlist();
    bloc = TvDetailBloc(
      getTvDetail: mockGetTvDetail,
      getTvRecommendations: mockGetTvRecommendations,
      getWatchListStatus: mockGetWatchListStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  const tTvId = 1;
  const tTvDetail = TvDetail(
    adult: false,
    backdropPath: '/backdropPath.jpg',
    genres: [],
    id: tTvId,
    originalName: 'Original Name',
    overview: 'Overview',
    posterPath: '/posterPath.jpg',
    releaseDate: '2022-12-12',
    runtime: 120,
    name: 'Title',
    voteAverage: 7.5,
    voteCount: 1000,
  );
  final tTv = <Tv>[];

  blocTest<TvDetailBloc, TvDetailState>(
    'emits [loading, loaded] when FetchTvDetail is added and data is gotten successfully',
    build: () {
      when(mockGetTvDetail.execute(tTvId))
          .thenAnswer((_) async => const Right(tTvDetail));
      when(mockGetTvRecommendations.execute(tTvId))
          .thenAnswer((_) async => Right(tTv));
      return bloc;
    },
    act: (bloc) => bloc.add(const FetchTvDetail(tTvId)),
    expect: () => [
      const TvDetailState(tvState: RequestState.loading),
      const TvDetailState(
        tvState: RequestState.loaded,
        tv: tTvDetail,
      ),
      TvDetailState(
        tvState: RequestState.loaded,
        tv: tTvDetail,
        tvRecommendations: tTv,
        recommendationState: RequestState.loaded,
      ),
    ],
    verify: (_) {
      verify(mockGetTvDetail.execute(tTvId));
      verify(mockGetTvRecommendations.execute(tTvId));
    },
  );

  blocTest<TvDetailBloc, TvDetailState>(
    'emits [loading, error] when FetchTvDetail is added and getting data fails',
    build: () {
      when(mockGetTvDetail.execute(tTvId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      when(mockGetTvRecommendations.execute(tTvId))
          .thenAnswer((_) async => Right(tTv));
      return bloc;
    },
    act: (bloc) => bloc.add(const FetchTvDetail(tTvId)),
    expect: () => [
      const TvDetailState(tvState: RequestState.loading),
      const TvDetailState(
        tvState: RequestState.error,
        message: 'Server Failure',
      ),
    ],
    verify: (_) {
      verify(mockGetTvDetail.execute(tTvId));
      verify(mockGetTvRecommendations.execute(tTvId));
    },
  );
  blocTest<TvDetailBloc, TvDetailState>(
    'emits [watchlistMessage, LoadWatchlistStatus] when AddToWatchlist is added and succeeds',
    build: () {
      when(mockSaveWatchlist.execute(tTvDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      when(mockGetWatchListStatus.execute(tTvId)).thenAnswer((_) async => true);
      return bloc;
    },
    act: (bloc) => bloc.add(const AddToWatchlist(tTvDetail)),
    expect: () => [
      const TvDetailState(watchlistMessage: 'Added to Watchlist'),
      const TvDetailState(
        watchlistMessage: 'Added to Watchlist',
        isAddedToWatchlist: true,
      ),
    ],
    verify: (_) {
      verify(mockSaveWatchlist.execute(tTvDetail));
      verify(mockGetWatchListStatus.execute(tTvId));
    },
  );

  blocTest<TvDetailBloc, TvDetailState>(
    'emits [watchlistMessage, LoadWatchlistStatus] when RemoveFromWatchlist is added and succeeds',
    build: () {
      when(mockRemoveWatchlist.execute(tTvDetail))
          .thenAnswer((_) async => const Right('Removed from Watchlist'));
      when(mockGetWatchListStatus.execute(tTvId))
          .thenAnswer((_) async => false);
      return bloc;
    },
    act: (bloc) => bloc.add(const RemoveFromWatchlist(tTvDetail)),
    expect: () => [
      const TvDetailState(watchlistMessage: 'Removed from Watchlist'),
    ],
    verify: (_) {
      verify(mockRemoveWatchlist.execute(tTvDetail));
      verify(mockGetWatchListStatus.execute(tTvId));
    },
  );
  blocTest<TvDetailBloc, TvDetailState>(
    'emits isAddedToWatchlist when LoadWatchlistStatus is added and succeeds',
    build: () {
      when(mockGetWatchListStatus.execute(tTvId)).thenAnswer((_) async => true);
      return bloc;
    },
    act: (bloc) => bloc.add(const LoadWatchlistStatus(tTvId)),
    expect: () => [
      const TvDetailState(isAddedToWatchlist: true),
    ],
    verify: (_) {
      verify(mockGetWatchListStatus.execute(tTvId));
    },
  );
}
