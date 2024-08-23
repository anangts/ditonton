import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/tv/domain/entities/movie_detail.dart';
import 'package:ditonton/features/tv/domain/repositories/tv_repository.dart';

class SaveWatchTvList {
  final TvRepository repository;

  SaveWatchTvList(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.saveWatchlist(tv);
  }
}
