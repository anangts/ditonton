import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv/domain/usecases/usecases.dart';
import 'package:ditonton/features/tv/presentation/bloc/bloc_export.dart';

class TvListBloc extends Bloc<TvListEvent, TvListState> {
  final TvGetNowPlaying getNowPlayingTvs;
  final TvGetPopular getPopularTvs;
  final TvGetTopRated getTopRatedTvs;

  TvListBloc({
    required this.getNowPlayingTvs,
    required this.getPopularTvs,
    required this.getTopRatedTvs,
  }) : super(const TvListState()) {
    on<FetchNowPlayingTv>(_onFetchNowPlayingTvs);
    on<FetchPopularTvs>(_onFetchPopularTvs);
    on<FetchTopRatedTvs>(_onFetchTopRatedTvs);
  }

  Future<void> _onFetchNowPlayingTvs(
    FetchNowPlayingTv event,
    Emitter<TvListState> emit,
  ) async {
    emit(state.copyWith(nowPlayingState: RequestState.loading));

    final result = await getNowPlayingTvs.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(
          nowPlayingState: RequestState.error,
          message: failure.message,
        ));
      },
      (tvsData) {
        emit(state.copyWith(
          nowPlayingState: RequestState.loaded,
          nowPlayingTvs: tvsData,
        ));
      },
    );
  }

  Future<void> _onFetchPopularTvs(
    FetchPopularTvs event,
    Emitter<TvListState> emit,
  ) async {
    emit(state.copyWith(popularTvsState: RequestState.loading));

    final result = await getPopularTvs.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(
          popularTvsState: RequestState.error,
          message: failure.message,
        ));
      },
      (tvsData) {
        emit(state.copyWith(
          popularTvsState: RequestState.loaded,
          popularTvs: tvsData,
        ));
      },
    );
  }

  Future<void> _onFetchTopRatedTvs(
    FetchTopRatedTvs event,
    Emitter<TvListState> emit,
  ) async {
    emit(state.copyWith(topRatedTvsState: RequestState.loading));

    final result = await getTopRatedTvs.execute();
    result.fold(
      (failure) {
        emit(state.copyWith(
          topRatedTvsState: RequestState.error,
          message: failure.message,
        ));
      },
      (tvsData) {
        emit(state.copyWith(
          topRatedTvsState: RequestState.loaded,
          topRatedTvs: tvsData,
        ));
      },
    );
  }
}
