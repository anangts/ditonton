import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/tv/domain/entities/tv_detail.dart';
import 'package:ditonton/features/tv/domain/repositories/tv_repository.dart';

class TvRemoveWatchlist {
  final TvRepository repository;

  TvRemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.removeWatchlist(tv);
  }
}
