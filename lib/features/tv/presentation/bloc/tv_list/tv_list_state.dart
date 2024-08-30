import 'package:equatable/equatable.dart';
import 'package:ditonton/features/tv/domain/entities/tv.dart';
import 'package:ditonton/common/state_enum.dart';

class TvListState extends Equatable {
  final List<Tv> tvNowPlaying;
  final RequestState nowPlayingState;
  final List<Tv> popularTvs;
  final RequestState tvPopularState;
  final List<Tv> tvTopRated;
  final RequestState tvTopRatedState;
  final String message;

  const TvListState({
    this.tvNowPlaying = const [],
    this.nowPlayingState = RequestState.empty,
    this.popularTvs = const [],
    this.tvPopularState = RequestState.empty,
    this.tvTopRated = const [],
    this.tvTopRatedState = RequestState.empty,
    this.message = '',
  });

  TvListState copyWith({
    List<Tv>? nowPlayingTvs,
    RequestState? nowPlayingState,
    List<Tv>? popularTvs,
    RequestState? popularTvsState,
    List<Tv>? topRatedTvs,
    RequestState? topRatedTvsState,
    String? message,
  }) {
    return TvListState(
      tvNowPlaying: nowPlayingTvs ?? tvNowPlaying,
      nowPlayingState: nowPlayingState ?? this.nowPlayingState,
      popularTvs: popularTvs ?? this.popularTvs,
      tvPopularState: popularTvsState ?? tvPopularState,
      tvTopRated: topRatedTvs ?? tvTopRated,
      tvTopRatedState: topRatedTvsState ?? tvTopRatedState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        tvNowPlaying,
        nowPlayingState,
        popularTvs,
        tvPopularState,
        tvTopRated,
        tvTopRatedState,
        message,
      ];
}
