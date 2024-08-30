import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv/domain/usecases/usecases.dart';
import 'package:ditonton/features/tv/presentation/bloc/bloc_export.dart';

class TvPopularBloc extends Bloc<TvPopularEvent, TvPopularState> {
  final TvGetPopular getPopularTvs;

  TvPopularBloc({required this.getPopularTvs}) : super(const TvPopularState()) {
    on<FetchPopularTv>(_onFetchPopularTvs);
  }

  Future<void> _onFetchPopularTvs(
    FetchPopularTv event,
    Emitter<TvPopularState> emit,
  ) async {
    emit(state.copyWith(state: RequestState.loading));

    final result = await getPopularTvs.execute();

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
