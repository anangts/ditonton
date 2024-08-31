import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv/domain/entities/entites.dart';
import 'package:ditonton/features/tv/domain/usecases/usecases.dart';
import 'package:ditonton/features/tv/presentation/bloc/bloc_export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'tv_popular_bloc_test.mocks.dart'; // Import the generated mocks

@GenerateMocks([TvGetPopular, Failure])
void main() {
  late TvPopularBloc bloc;
  late MockTvGetPopular mockGetPopularTv;
  late MockFailure mockFailure;

  setUp(() {
    mockGetPopularTv = MockTvGetPopular();
    mockFailure = MockFailure();
    bloc = TvPopularBloc(getPopularTvs: mockGetPopularTv);
  });

  group('PopularTvBloc', () {
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

    // Configure the behavior of mockFailure
    setUp(() {
      when(mockFailure.message).thenReturn(tFailureMessage);
    });

    blocTest<TvPopularBloc, TvPopularState>(
      'emits [loading, loaded] when FetchPopularTv is added and data is successfully fetched',
      build: () {
        when(mockGetPopularTv.execute()).thenAnswer((_) async => Right(tTv));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchPopularTv()),
      expect: () => [
        const TvPopularState(state: RequestState.loading),
        TvPopularState(
          state: RequestState.loaded,
          tvs: tTv,
        ),
      ],
    );

    blocTest<TvPopularBloc, TvPopularState>(
      'emits [loading, error] when FetchPopularTv is added and data retrieval fails',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Left(mockFailure));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchPopularTv()),
      expect: () => [
        const TvPopularState(state: RequestState.loading),
        const TvPopularState(
          state: RequestState.error,
          message: tFailureMessage,
        ),
      ],
    );
  });
}
