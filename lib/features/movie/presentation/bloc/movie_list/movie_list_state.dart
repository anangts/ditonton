import 'package:equatable/equatable.dart';
import 'package:ditonton/features/movie/domain/entities/movie.dart';
import 'package:ditonton/common/state_enum.dart';

class MovieListState extends Equatable {
  final List<Movie> movieNowPlaying;
  final RequestState movieNowPlayingState;
  final List<Movie> moviePopular;
  final RequestState moviePopularState;
  final List<Movie> movieTopRated;
  final RequestState movieTopRatedState;
  final String message;

  const MovieListState({
    this.movieNowPlaying = const [],
    this.movieNowPlayingState = RequestState.empty,
    this.moviePopular = const [],
    this.moviePopularState = RequestState.empty,
    this.movieTopRated = const [],
    this.movieTopRatedState = RequestState.empty,
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
      movieNowPlaying: nowPlayingMovies ?? movieNowPlaying,
      movieNowPlayingState: nowPlayingState ?? movieNowPlayingState,
      moviePopular: popularMovies ?? moviePopular,
      moviePopularState: popularMoviesState ?? moviePopularState,
      movieTopRated: topRatedMovies ?? movieTopRated,
      movieTopRatedState: topRatedMoviesState ?? movieTopRatedState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        movieNowPlaying,
        movieNowPlayingState,
        moviePopular,
        moviePopularState,
        movieTopRated,
        movieTopRatedState,
        message,
      ];
}
