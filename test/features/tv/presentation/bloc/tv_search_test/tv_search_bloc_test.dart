import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/tv/domain/usecases/usecases.dart';
import 'package:ditonton/features/tv/presentation/bloc/bloc_export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv/domain/entities/tv.dart';

import 'tv_search_bloc_test.mocks.dart';

@GenerateMocks([TvSearch])
void main() {
  late MockTvSearch mockSearchTv;
  late TvSearchBloc tvSearchBloc;

  setUp(() {
    mockSearchTv = MockTvSearch();
    tvSearchBloc = TvSearchBloc(searchTvs: mockSearchTv);
  });

  group('TvSearchBloc', () {
    const tQuery = 'query';
    final tTv = <Tv>[
      Tv(
        id: 1,
        name: 'Tv 1',
        overview: 'Overview 1',
        posterPath: 'path1',
        releaseDate: '2024-08-30',
      ),
    ];
    const tFailureMessage = 'Error';
    const tFailure = ServerFailure(tFailureMessage); // Use concrete subclass

    test('initial state should be TvSearchState.empty', () {
      expect(tvSearchBloc.state, equals(const TvSearchState()));
    });

    blocTest<TvSearchBloc, TvSearchState>(
      'emits [loading, loaded] when FetchTvSearch is added and search is successful',
      build: () {
        when(mockSearchTv.execute(tQuery)).thenAnswer(
          (_) async => Right(tTv),
        );
        return tvSearchBloc;
      },
      act: (bloc) => bloc.add(const FetchTvSearch(tQuery)),
      expect: () => [
        const TvSearchState(state: RequestState.loading),
        TvSearchState(
          state: RequestState.loaded,
          searchResult: tTv,
        ),
      ],
    );

    blocTest<TvSearchBloc, TvSearchState>(
      'emits [loading, error] when FetchTvSearch is added and search fails',
      build: () {
        when(mockSearchTv.execute(tQuery)).thenAnswer(
          (_) async => const Left(tFailure),
        );
        return tvSearchBloc;
      },
      act: (bloc) => bloc.add(const FetchTvSearch(tQuery)),
      expect: () => [
        const TvSearchState(state: RequestState.loading),
        const TvSearchState(
          state: RequestState.error,
          message: tFailureMessage,
        ),
      ],
    );
  });
}
