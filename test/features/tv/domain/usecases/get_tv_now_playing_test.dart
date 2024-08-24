import 'package:dartz/dartz.dart';
import 'package:ditonton/features/tv/domain/entities/tv.dart';
import 'package:ditonton/features/tv/domain/usecases/get_tv_now_playing.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/tv_test_helper.mocks.dart';

void main() {
  late GetTvNowPlaying usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvNowPlaying(mockTvRepository);
  });

  final tTv = <Tv>[];

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockTvRepository.getNowPlayingTvs())
        .thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTv));
  });
}
