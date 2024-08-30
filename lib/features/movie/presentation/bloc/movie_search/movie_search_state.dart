import 'package:equatable/equatable.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/movie/domain/entities/movie.dart';

class MovieSearchState extends Equatable {
  final RequestState state;
  final List<Movie> searchResult;
  final String message;

  const MovieSearchState({
    this.state = RequestState.empty,
    this.searchResult = const [],
    this.message = '',
  });

  MovieSearchState copyWith({
    RequestState? state,
    List<Movie>? searchResult,
    String? message,
  }) {
    return MovieSearchState(
      state: state ?? this.state,
      searchResult: searchResult ?? this.searchResult,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [state, searchResult, message];
}
