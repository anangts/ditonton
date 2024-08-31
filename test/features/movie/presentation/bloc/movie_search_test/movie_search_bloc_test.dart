import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/movie/domain/usecases/usecases.dart';
import 'package:ditonton/features/movie/presentation/bloc/bloc_export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/movie/domain/entities/movie.dart';

import 'movie_search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MockSearchMovies mockSearchMovies;
  late MovieSearchBloc movieSearchBloc;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    movieSearchBloc = MovieSearchBloc(searchMovies: mockSearchMovies);
  });

  group('MovieSearchBloc', () {
    const tQuery = 'query';
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
    const tFailure = ServerFailure(tFailureMessage); // Use concrete subclass

    test('initial state should be MovieSearchState.empty', () {
      expect(movieSearchBloc.state, equals(const MovieSearchState()));
    });

    blocTest<MovieSearchBloc, MovieSearchState>(
      'emits [loading, loaded] when FetchMovieSearch is added and search is successful',
      build: () {
        when(mockSearchMovies.execute(tQuery)).thenAnswer(
          (_) async => Right(tMovies),
        );
        return movieSearchBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieSearch(tQuery)),
      expect: () => [
        const MovieSearchState(state: RequestState.loading),
        MovieSearchState(
          state: RequestState.loaded,
          searchResult: tMovies,
        ),
      ],
    );

    blocTest<MovieSearchBloc, MovieSearchState>(
      'emits [loading, error] when FetchMovieSearch is added and search fails',
      build: () {
        when(mockSearchMovies.execute(tQuery)).thenAnswer(
          (_) async => const Left(tFailure),
        );
        return movieSearchBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieSearch(tQuery)),
      expect: () => [
        const MovieSearchState(state: RequestState.loading),
        const MovieSearchState(
          state: RequestState.error,
          message: tFailureMessage,
        ),
      ],
    );
  });
}
