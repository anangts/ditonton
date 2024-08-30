import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv/domain/usecases/usecases.dart';
import 'package:ditonton/features/tv/presentation/bloc/bloc_export.dart';

class TvWatchlistBloc extends Bloc<TvWatchlistEvent, TvWatchlistState> {
  final TvGetWatchlist getWatchlistTv;

  TvWatchlistBloc({required this.getWatchlistTv})
      : super(const TvWatchlistState()) {
    on<FetchWatchlistTv>(_onFetchWatchlistTv);
  }

  Future<void> _onFetchWatchlistTv(
    FetchWatchlistTv event,
    Emitter<TvWatchlistState> emit,
  ) async {
    emit(state.copyWith(watchlistState: RequestState.loading));

    final result = await getWatchlistTv.execute();

    result.fold(
      (failure) {
        emit(state.copyWith(
          watchlistState: RequestState.error,
          message: failure.message,
        ));
      },
      (tvs) {
        emit(state.copyWith(
          watchlistState: RequestState.loaded,
          watchlistTv: tvs,
        ));
      },
    );
  }
}
