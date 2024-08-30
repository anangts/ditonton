import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv/domain/usecases/usecases.dart';
import 'tv_detail_event.dart';
import 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final TvGetDetail getTvDetail;
  final TvGetRecommendations getTvRecommendations;
  final TvGetWatchListStatus getWatchListStatus;
  final TvSaveWatchlist saveWatchlist;
  final TvRemoveWatchlist removeWatchlist;

  TvDetailBloc({
    required this.getTvDetail,
    required this.getTvRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(const TvDetailState()) {
    on<FetchTvDetail>(_onFetchTvDetail);
    on<AddToWatchlist>(_onAddToWatchlist);
    on<RemoveFromWatchlist>(_onRemoveFromWatchlist);
    on<LoadWatchlistStatus>(_onLoadWatchlistStatus);
  }

  Future<void> _onFetchTvDetail(
    FetchTvDetail event,
    Emitter<TvDetailState> emit,
  ) async {
    emit(state.copyWith(tvState: RequestState.loading));
    final detailResult = await getTvDetail.execute(event.id);
    final recommendationResult = await getTvRecommendations.execute(event.id);

    detailResult.fold(
      (failure) {
        emit(state.copyWith(
          tvState: RequestState.error,
          message: failure.message,
        ));
      },
      (tv) {
        emit(state.copyWith(
          tvState: RequestState.loaded,
          tv: tv,
        ));

        recommendationResult.fold(
          (failure) {
            emit(state.copyWith(
              recommendationState: RequestState.error,
              message: failure.message,
            ));
          },
          (tvs) {
            emit(state.copyWith(
              recommendationState: RequestState.loaded,
              tvRecommendations: tvs,
            ));
          },
        );
      },
    );
  }

  Future<void> _onAddToWatchlist(
    AddToWatchlist event,
    Emitter<TvDetailState> emit,
  ) async {
    final result = await saveWatchlist.execute(event.tv);

    result.fold(
      (failure) {
        emit(state.copyWith(watchlistMessage: failure.message));
      },
      (successMessage) {
        emit(state.copyWith(watchlistMessage: successMessage));
      },
    );

    add(LoadWatchlistStatus(event.tv.id));
  }

  Future<void> _onRemoveFromWatchlist(
    RemoveFromWatchlist event,
    Emitter<TvDetailState> emit,
  ) async {
    final result = await removeWatchlist.execute(event.tv);

    result.fold(
      (failure) {
        emit(state.copyWith(watchlistMessage: failure.message));
      },
      (successMessage) {
        emit(state.copyWith(watchlistMessage: successMessage));
      },
    );

    add(LoadWatchlistStatus(event.tv.id));
  }

  Future<void> _onLoadWatchlistStatus(
    LoadWatchlistStatus event,
    Emitter<TvDetailState> emit,
  ) async {
    final result = await getWatchListStatus.execute(event.id);
    emit(state.copyWith(isAddedToWatchlist: result));
  }
}
