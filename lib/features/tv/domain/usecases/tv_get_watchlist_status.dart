import 'package:ditonton/features/tv/domain/repositories/tv_repository.dart';

class TvGetWatchListStatus {
  final TvRepository repository;

  TvGetWatchListStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
