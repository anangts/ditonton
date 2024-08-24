import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/tv/domain/entities/tv.dart';
import 'package:ditonton/features/tv/domain/repositories/tv_repository.dart';

class GetTvTopRated {
  final TvRepository repository;

  GetTvTopRated(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTopRatedTvs();
  }
}
