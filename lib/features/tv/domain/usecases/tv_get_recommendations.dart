import 'package:dartz/dartz.dart';
import 'package:ditonton/features/tv/domain/entities/tv.dart';
import 'package:ditonton/features/tv/domain/repositories/tv_repository.dart';
import 'package:ditonton/common/failure.dart';

class TvGetRecommendations {
  final TvRepository repository;

  TvGetRecommendations(this.repository);

  Future<Either<Failure, List<Tv>>> execute(id) {
    return repository.getTvRecommendations(id);
  }
}
