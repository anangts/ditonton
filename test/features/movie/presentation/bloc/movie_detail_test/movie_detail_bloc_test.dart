import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/features/movie/domain/entities/entites.dart';
import 'package:ditonton/features/movie/domain/usecases/usecases.dart';
import 'package:ditonton/features/movie/presentation/bloc/bloc_export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';

import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBloc bloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    bloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getWatchListStatus: mockGetWatchListStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  const tMovieId = 1;
  const tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: '/backdropPath.jpg',
    genres: [],
    id: tMovieId,
    originalTitle: 'Original Title',
    overview: 'Overview',
    posterPath: '/posterPath.jpg',
    releaseDate: '2022-12-12',
    runtime: 120,
    title: 'Title',
    voteAverage: 7.5,
    voteCount: 1000,
  );
  final tMovies = <Movie>[];

  blocTest<MovieDetailBloc, MovieDetailState>(
    'emits [loading, loaded] when FetchMovieDetail is added and data is gotten successfully',
    build: () {
      when(mockGetMovieDetail.execute(tMovieId))
          .thenAnswer((_) async => const Right(tMovieDetail));
      when(mockGetMovieRecommendations.execute(tMovieId))
          .thenAnswer((_) async => Right(tMovies));
      return bloc;
    },
    act: (bloc) => bloc.add(const FetchMovieDetail(tMovieId)),
    expect: () => [
      const MovieDetailState(movieState: RequestState.loading),
      const MovieDetailState(
        movieState: RequestState.loaded,
        movie: tMovieDetail,
      ),
      MovieDetailState(
        movieState: RequestState.loaded,
        movie: tMovieDetail,
        movieRecommendations: tMovies,
        recommendationState: RequestState.loaded,
      ),
    ],
    verify: (_) {
      verify(mockGetMovieDetail.execute(tMovieId));
      verify(mockGetMovieRecommendations.execute(tMovieId));
    },
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'emits [loading, error] when FetchMovieDetail is added and getting data fails',
    build: () {
      when(mockGetMovieDetail.execute(tMovieId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      when(mockGetMovieRecommendations.execute(tMovieId))
          .thenAnswer((_) async => Right(tMovies));
      return bloc;
    },
    act: (bloc) => bloc.add(const FetchMovieDetail(tMovieId)),
    expect: () => [
      const MovieDetailState(movieState: RequestState.loading),
      const MovieDetailState(
        movieState: RequestState.error,
        message: 'Server Failure',
      ),
    ],
    verify: (_) {
      verify(mockGetMovieDetail.execute(tMovieId));
      verify(mockGetMovieRecommendations.execute(tMovieId));
    },
  );
  blocTest<MovieDetailBloc, MovieDetailState>(
    'emits [watchlistMessage, LoadWatchlistStatus] when AddToWatchlist is added and succeeds',
    build: () {
      when(mockSaveWatchlist.execute(tMovieDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      when(mockGetWatchListStatus.execute(tMovieId))
          .thenAnswer((_) async => true);
      return bloc;
    },
    act: (bloc) => bloc.add(const AddToWatchlist(tMovieDetail)),
    expect: () => [
      const MovieDetailState(watchlistMessage: 'Added to Watchlist'),
      const MovieDetailState(
        watchlistMessage: 'Added to Watchlist',
        isAddedToWatchlist: true,
      ),
    ],
    verify: (_) {
      verify(mockSaveWatchlist.execute(tMovieDetail));
      verify(mockGetWatchListStatus.execute(tMovieId));
    },
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'emits [watchlistMessage, LoadWatchlistStatus] when RemoveFromWatchlist is added and succeeds',
    build: () {
      when(mockRemoveWatchlist.execute(tMovieDetail))
          .thenAnswer((_) async => const Right('Removed from Watchlist'));
      when(mockGetWatchListStatus.execute(tMovieId))
          .thenAnswer((_) async => false);
      return bloc;
    },
    act: (bloc) => bloc.add(const RemoveFromWatchlist(tMovieDetail)),
    expect: () => [
      const MovieDetailState(watchlistMessage: 'Removed from Watchlist'),
      
    ],
    verify: (_) {
      verify(mockRemoveWatchlist.execute(tMovieDetail));
      verify(mockGetWatchListStatus.execute(tMovieId));
    },
  );
  blocTest<MovieDetailBloc, MovieDetailState>(
    'emits isAddedToWatchlist when LoadWatchlistStatus is added and succeeds',
    build: () {
      when(mockGetWatchListStatus.execute(tMovieId))
          .thenAnswer((_) async => true);
      return bloc;
    },
    act: (bloc) => bloc.add(const LoadWatchlistStatus(tMovieId)),
    expect: () => [
      const MovieDetailState(isAddedToWatchlist: true),
    ],
    verify: (_) {
      verify(mockGetWatchListStatus.execute(tMovieId));
    },
  );
}
