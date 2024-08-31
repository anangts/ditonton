import 'package:equatable/equatable.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/movie/domain/entities/movie.dart';

class MovieWatchlistState extends Equatable {
  final RequestState watchlistState;
  final List<Movie> watchlistMovies;
  final String message;

  const MovieWatchlistState({
    this.watchlistState = RequestState.empty,
    this.watchlistMovies = const [],
    this.message = '',
  });

  MovieWatchlistState copyWith({
    RequestState? watchlistState,
    List<Movie>? watchlistMovies,
    String? message,
  }) {
    return MovieWatchlistState(
      watchlistState: watchlistState ?? this.watchlistState,
      watchlistMovies: watchlistMovies ?? this.watchlistMovies,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [watchlistState, watchlistMovies, message];
}
