import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv/domain/entities/tv.dart';
import 'package:ditonton/features/tv/domain/usecases/usecases.dart';
import 'package:ditonton/features/tv/presentation/bloc/bloc_export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_watchlist_bloc_test.mocks.dart';

@GenerateMocks([TvGetWatchlist])
void main() {
  late TvWatchlistBloc tvWatchlistBloc;
  late MockTvGetWatchlist mockGetWatchlistTv;

  setUp(() {
    mockGetWatchlistTv = MockTvGetWatchlist();
    tvWatchlistBloc = TvWatchlistBloc(getWatchlistTv: mockGetWatchlistTv);
  });

  final tTv = Tv(
    id: 1,
    name: 'Test Tv',
    overview: 'Test Overview',
    posterPath: 'test.png',
  );
  final tTvList = <Tv>[tTv];

  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'emits [loading, loaded] when FetchWatchlistTv is successful',
    build: () {
      when(mockGetWatchlistTv.execute())
          .thenAnswer((_) async => Right(tTvList));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTv()),
    expect: () => [
      const TvWatchlistState(watchlistState: RequestState.loading),
      TvWatchlistState(
        watchlistState: RequestState.loaded,
        watchlistTv: tTvList,
      ),
    ],
    verify: (_) {
      verify(mockGetWatchlistTv.execute());
    },
  );

  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'emits [loading, error] when FetchWatchlistTv fails',
    build: () {
      when(mockGetWatchlistTv.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTv()),
    expect: () => [
      const TvWatchlistState(watchlistState: RequestState.loading),
      const TvWatchlistState(
        watchlistState: RequestState.error,
        message: 'Server Failure',
      ),
    ],
    verify: (_) {
      verify(mockGetWatchlistTv.execute());
    },
  );
}
