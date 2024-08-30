import 'package:dartz/dartz.dart';
import 'package:ditonton/features/tv/domain/entities/tv.dart';
import 'package:ditonton/features/tv/domain/repositories/tv_repository.dart';
import 'package:ditonton/common/failure.dart';

class TvGetNowPlaying {
  final TvRepository repository;

  TvGetNowPlaying(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getNowPlayingTvs();
  }
}
