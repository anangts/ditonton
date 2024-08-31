import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv/domain/entities/tv.dart';
import 'package:ditonton/features/tv/domain/usecases/usecases.dart';
import 'package:ditonton/features/tv/presentation/bloc/tv_top_rated/tv_top_rated_bloc.dart';
import 'package:ditonton/features/tv/presentation/bloc/tv_top_rated/tv_top_rated_event.dart';
import 'package:ditonton/features/tv/presentation/bloc/tv_top_rated/tv_top_rated_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_top_rated_bloc_test.mocks.dart';

@GenerateMocks([TvGetTopRated])
void main() {
  late TvTopRatedBloc topRatedTvBloc;
  late MockTvGetTopRated mockGetTopRatedTv;

  setUp(() {
    mockGetTopRatedTv = MockTvGetTopRated();
    topRatedTvBloc = TvTopRatedBloc(getTopRatedTv: mockGetTopRatedTv);
  });

  final tTv = Tv(
    id: 1,
    name: 'Test Tv',
    overview: 'Test Overview',
    posterPath: 'test.png',
  );
  final tTvList = <Tv>[tTv];

  blocTest<TvTopRatedBloc, TvTopRatedState>(
    'emits [loading, loaded] when FetchTopRatedTv is successful',
    build: () {
      when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Right(tTvList));
      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTv()),
    expect: () => [
      const TvTopRatedState(state: RequestState.loading),
      TvTopRatedState(state: RequestState.loaded, tvs: tTvList),
    ],
    verify: (_) {
      verify(mockGetTopRatedTv.execute());
    },
  );

  blocTest<TvTopRatedBloc, TvTopRatedState>(
    'emits [loading, error] when FetchTopRatedTv fails',
    build: () {
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTv()),
    expect: () => [
      const TvTopRatedState(state: RequestState.loading),
      const TvTopRatedState(
          state: RequestState.error, message: 'Server Failure'),
    ],
    verify: (_) {
      verify(mockGetTopRatedTv.execute());
    },
  );
}
