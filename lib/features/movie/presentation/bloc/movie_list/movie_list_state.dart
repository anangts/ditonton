import 'package:equatable/equatable.dart';
import 'package:ditonton/features/movie/domain/entities/movie.dart';
import 'package:ditonton/common/state_enum.dart';

class MovieListState extends Equatable {
  final List<Movie> nowPlayingMovies;
  final RequestState nowPlayingState;
  final List<Movie> popularMovies;
  final RequestState popularMoviesState;
  final List<Movie> topRatedMovies;
  final RequestState topRatedMoviesState;
  final String message;

  const MovieListState({
    this.nowPlayingMovies = const [],
    this.nowPlayingState = RequestState.empty,
    this.popularMovies = const [],
    this.popularMoviesState = RequestState.empty,
    this.topRatedMovies = const [],
    this.topRatedMoviesState = RequestState.empty,
    this.message = '',
  });

  MovieListState copyWith({
    List<Movie>? nowPlayingMovies,
    RequestState? nowPlayingState,
    List<Movie>? popularMovies,
    RequestState? popularMoviesState,
    List<Movie>? topRatedMovies,
    RequestState? topRatedMoviesState,
    String? message,
  }) {
    return MovieListState(
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      nowPlayingState: nowPlayingState ?? this.nowPlayingState,
      popularMovies: popularMovies ?? this.popularMovies,
      popularMoviesState: popularMoviesState ?? this.popularMoviesState,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      topRatedMoviesState: topRatedMoviesState ?? this.topRatedMoviesState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        nowPlayingMovies,
        nowPlayingState,
        popularMovies,
        popularMoviesState,
        topRatedMovies,
        topRatedMoviesState,
        message,
      ];
}
