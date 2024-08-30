import 'package:equatable/equatable.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv/domain/entities/tv.dart';

class TvPopularState extends Equatable {
  final RequestState state;
  final List<Tv> tvs;
  final String message;

  const TvPopularState({
    this.state = RequestState.empty,
    this.tvs = const [],
    this.message = '',
  });

  TvPopularState copyWith({
    RequestState? state,
    List<Tv>? tvs,
    String? message,
  }) {
    return TvPopularState(
      state: state ?? this.state,
      tvs: tvs ?? this.tvs,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [state, tvs, message];
}
