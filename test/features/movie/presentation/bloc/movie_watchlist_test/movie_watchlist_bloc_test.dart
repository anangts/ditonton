import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/movie/domain/entities/movie.dart';
import 'package:ditonton/features/movie/domain/usecases/usecases.dart';
import 'package:ditonton/features/movie/presentation/bloc/bloc_export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late MovieWatchlistBloc movieWatchlistBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    movieWatchlistBloc =
        MovieWatchlistBloc(getWatchlistMovies: mockGetWatchlistMovies);
  });

  final tMovie = Movie(
    id: 1,
    title: 'Test Movie',
    overview: 'Test Overview',
    posterPath: 'test.png',
  );
  final tMovieList = <Movie>[tMovie];

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'emits [loading, loaded] when FetchWatchlistMovies is successful',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovies()),
    expect: () => [
      const MovieWatchlistState(watchlistState: RequestState.loading),
      MovieWatchlistState(
        watchlistState: RequestState.loaded,
        watchlistMovies: tMovieList,
      ),
    ],
    verify: (_) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'emits [loading, error] when FetchWatchlistMovies fails',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovies()),
    expect: () => [
      const MovieWatchlistState(watchlistState: RequestState.loading),
      const MovieWatchlistState(
        watchlistState: RequestState.error,
        message: 'Server Failure',
      ),
    ],
    verify: (_) {
      verify(mockGetWatchlistMovies.execute());
    },
  );
}
