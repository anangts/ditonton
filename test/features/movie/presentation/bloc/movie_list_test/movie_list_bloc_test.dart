import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/movie/domain/entities/entites.dart';
import 'package:ditonton/features/movie/presentation/bloc/bloc_export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ditonton/features/movie/domain/usecases/usecases.dart';
import 'package:ditonton/common/state_enum.dart';

import 'movie_list_bloc_test.mocks.dart';

// Create mock classes

@GenerateMocks(
    [GetNowPlayingMovies, GetPopularMovies, GetTopRatedMovies, Failure])
void main() {
  late MovieListBloc movieListBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MockFailure mockFailure;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    mockFailure = MockFailure();
    movieListBloc = MovieListBloc(
      getNowPlayingMovies: mockGetNowPlayingMovies,
      getPopularMovies: mockGetPopularMovies,
      getTopRatedMovies: mockGetTopRatedMovies,
    );
  });

  group('MovieListBloc', () {
    test('initial state is correct', () {
      expect(movieListBloc.state, equals(const MovieListState()));
    });

    blocTest<MovieListBloc, MovieListState>(
      'emits [loading, loaded] when FetchNowPlayingMovies event is added',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer(
          (_) async => Right([
            Movie(
                id: 1,
                title: 'Test Movie',
                overview: 'Test Overview',
                posterPath: 'test_path',
                releaseDate: '2024-08-30')
          ]),
        );
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMovies()),
      expect: () => [
        const MovieListState(movieNowPlayingState: RequestState.loading),
        MovieListState(
          movieNowPlayingState: RequestState.loaded,
          movieNowPlaying: [
            Movie(
                id: 1,
                title: 'Test Movie',
                overview: 'Test Overview',
                posterPath: 'test_path',
                releaseDate: '2024-08-30')
          ],
        ),
      ],
    );

    blocTest<MovieListBloc, MovieListState>(
      'emits [loading, error] when FetchNowPlayingMovies event is added and fails',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer(
          (_) async => Left(mockFailure),
        );
        when(mockFailure.message).thenReturn('Error');
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMovies()),
      expect: () => [
        const MovieListState(movieNowPlayingState: RequestState.loading),
        const MovieListState(
          movieNowPlayingState: RequestState.error,
          message: 'Error',
        ),
      ],
    );

    blocTest<MovieListBloc, MovieListState>(
      'emits [loading, loaded] when FetchPopularMovies event is added',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
          (_) async => Right([
            Movie(
                id: 1,
                title: 'Test Movie',
                overview: 'Test Overview',
                posterPath: 'test_path',
                releaseDate: '2024-08-30')
          ]),
        );
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovies()),
      expect: () => [
        const MovieListState(moviePopularState: RequestState.loading),
        MovieListState(
          moviePopularState: RequestState.loaded,
          moviePopular: [
            Movie(
                id: 1,
                title: 'Test Movie',
                overview: 'Test Overview',
                posterPath: 'test_path',
                releaseDate: '2024-08-30')
          ],
        ),
      ],
    );

    blocTest<MovieListBloc, MovieListState>(
      'emits [loading, error] when FetchPopularMovies event is added and fails',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
          (_) async => Left(mockFailure),
        );
        when(mockFailure.message).thenReturn('Error');
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovies()),
      expect: () => [
        const MovieListState(moviePopularState: RequestState.loading),
        const MovieListState(
          moviePopularState: RequestState.error,
          message: 'Error',
        ),
      ],
    );

    blocTest<MovieListBloc, MovieListState>(
      'emits [loading, loaded] when FetchTopRatedMovies event is added',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
          (_) async => Right([
            Movie(
                id: 1,
                title: 'Test Movie',
                overview: 'Test Overview',
                posterPath: 'test_path',
                releaseDate: '2024-08-30')
          ]),
        );
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovies()),
      expect: () => [
        const MovieListState(movieTopRatedState: RequestState.loading),
        MovieListState(
          movieTopRatedState: RequestState.loaded,
          movieTopRated: [
            Movie(
                id: 1,
                title: 'Test Movie',
                overview: 'Test Overview',
                posterPath: 'test_path',
                releaseDate: '2024-08-30')
          ],
        ),
      ],
    );

    blocTest<MovieListBloc, MovieListState>(
      'emits [loading, error] when FetchTopRatedMovies event is added and fails',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
          (_) async => Left(mockFailure),
        );
        when(mockFailure.message).thenReturn('Error');
        return movieListBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovies()),
      expect: () => [
        const MovieListState(movieTopRatedState: RequestState.loading),
        const MovieListState(
          movieTopRatedState: RequestState.error,
          message: 'Error',
        ),
      ],
    );
  });
}
