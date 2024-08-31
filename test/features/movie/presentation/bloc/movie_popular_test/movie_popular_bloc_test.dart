import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/movie/domain/entities/entites.dart';
import 'package:ditonton/features/movie/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/features/movie/presentation/bloc/bloc_export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'movie_popular_bloc_test.mocks.dart'; // Import the generated mocks

@GenerateMocks([GetPopularMovies, Failure])
void main() {
  late PopularMoviesBloc bloc;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockFailure mockFailure;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    mockFailure = MockFailure();
    bloc = PopularMoviesBloc(getPopularMovies: mockGetPopularMovies);
  });

  group('PopularMoviesBloc', () {
    final tMovies = <Movie>[
      Movie(
        id: 1,
        title: 'Movie 1',
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

    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'emits [loading, loaded] when FetchPopularMovie is added and data is successfully fetched',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovies));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovie()),
      expect: () => [
        const PopularMoviesState(state: RequestState.loading),
        PopularMoviesState(
          state: RequestState.loaded,
          movies: tMovies,
        ),
      ],
    );

    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'emits [loading, error] when FetchPopularMovie is added and data retrieval fails',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Left(mockFailure));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovie()),
      expect: () => [
        const PopularMoviesState(state: RequestState.loading),
        const PopularMoviesState(
          state: RequestState.error,
          message: tFailureMessage,
        ),
      ],
    );
  });
}
