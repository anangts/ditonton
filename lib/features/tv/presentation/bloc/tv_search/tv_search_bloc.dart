import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv/domain/usecases/usecases.dart';
import 'package:ditonton/features/tv/presentation/bloc/bloc_export.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final TvSearch searchTvs;

  TvSearchBloc({required this.searchTvs}) : super(const TvSearchState()) {
    on<FetchTvSearch>(_onFetchTvSearch);
  }

  Future<void> _onFetchTvSearch(
    FetchTvSearch event,
    Emitter<TvSearchState> emit,
  ) async {
    emit(state.copyWith(state: RequestState.loading));

    final result = await searchTvs.execute(event.query);
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
          searchResult: tvs,
        ));
      },
    );
  }
}
