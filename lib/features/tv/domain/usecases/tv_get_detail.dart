import 'package:dartz/dartz.dart';
import 'package:ditonton/features/tv/domain/entities/tv_detail.dart';
import 'package:ditonton/features/tv/domain/repositories/tv_repository.dart';
import 'package:ditonton/common/failure.dart';

class TvGetDetail {
  final TvRepository repository;

  TvGetDetail(this.repository);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return repository.getTvDetail(id);
  }
}
