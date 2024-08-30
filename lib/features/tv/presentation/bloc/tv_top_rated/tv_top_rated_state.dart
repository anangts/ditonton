import 'package:equatable/equatable.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv/domain/entities/tv.dart';

class TvTopRatedState extends Equatable {
  final RequestState state;
  final List<Tv> tvs;
  final String message;

  const TvTopRatedState({
    this.state = RequestState.empty,
    this.tvs = const [],
    this.message = '',
  });

  TvTopRatedState copyWith({
    RequestState? state,
    List<Tv>? tvs,
    String? message,
  }) {
    return TvTopRatedState(
      state: state ?? this.state,
      tvs: tvs ?? this.tvs,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [state, tvs, message];
}
