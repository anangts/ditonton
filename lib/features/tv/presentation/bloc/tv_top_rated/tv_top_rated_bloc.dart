import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv/domain/usecases/usecases.dart';
import 'package:ditonton/features/tv/presentation/bloc/bloc_export.dart';

class TvTopRatedBloc extends Bloc<TvTopRatedEvent, TvTopRatedState> {
  final TvGetTopRated getTopRatedTv;

  TvTopRatedBloc({required this.getTopRatedTv})
      : super(const TvTopRatedState()) {
    on<FetchTopRatedTv>(_onFetchTopRatedTv);
  }

  Future<void> _onFetchTopRatedTv(
    FetchTopRatedTv event,
    Emitter<TvTopRatedState> emit,
  ) async {
    emit(state.copyWith(state: RequestState.loading));

    final result = await getTopRatedTv.execute();

    result.fold(
      (failure) {
        emit(state.copyWith(
          state: RequestState.error,
          message: failure.message,
        ));
      },
      (tvs) {
        emit(state.copyWith(
          state: RequestState.loaded,
          tvs: tvs,
        ));
      },
    );
  }
}
