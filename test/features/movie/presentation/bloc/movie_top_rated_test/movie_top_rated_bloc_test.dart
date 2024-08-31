import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/movie/domain/entities/movie.dart';
import 'package:ditonton/features/movie/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/features/movie/presentation/bloc/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:ditonton/features/movie/presentation/bloc/movie_top_rated/movie_top_rated_event.dart';
import 'package:ditonton/features/movie/presentation/bloc/movie_top_rated/movie_top_rated_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_top_rated_bloc_test.mocks.dart';
 

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMoviesBloc topRatedMoviesBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMoviesBloc =
        TopRatedMoviesBloc(getTopRatedMovies: mockGetTopRatedMovies);
  });

  final tMovie = Movie(
    id: 1,
    title: 'Test Movie',
    overview: 'Test Overview',
    posterPath: 'test.png',
  );
  final tMovieList = <Movie>[tMovie];

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
    'emits [loading, loaded] when FetchTopRatedMovie is successful',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return topRatedMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedMovie()),
    expect: () => [
      const TopRatedMoviesState(state: RequestState.loading),
      TopRatedMoviesState(state: RequestState.loaded, movies: tMovieList),
    ],
    verify: (_) {
      verify(mockGetTopRatedMovies.execute());
    },
  );

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
    'emits [loading, error] when FetchTopRatedMovie fails',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return topRatedMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedMovie()),
    expect: () => [
      const TopRatedMoviesState(state: RequestState.loading),
      const TopRatedMoviesState(
          state: RequestState.error, message: 'Server Failure'),
    ],
    verify: (_) {
      verify(mockGetTopRatedMovies.execute());
    },
  );
}
