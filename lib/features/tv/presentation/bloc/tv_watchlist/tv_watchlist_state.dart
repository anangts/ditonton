import 'package:equatable/equatable.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv/domain/entities/tv.dart';

class TvWatchlistState extends Equatable {
  final RequestState watchlistState;
  final List<Tv> watchlistTv;
  final String message;

  const TvWatchlistState({
    this.watchlistState = RequestState.empty,
    this.watchlistTv = const [],
    this.message = '',
  });

  TvWatchlistState copyWith({
    RequestState? watchlistState,
    List<Tv>? watchlistTv,
    String? message,
  }) {
    return TvWatchlistState(
      watchlistState: watchlistState ?? this.watchlistState,
      watchlistTv: watchlistTv ?? this.watchlistTv,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [watchlistState, watchlistTv, message];
}
