// import 'package:dartz/dartz.dart';
// import 'package:ditonton/common/failure.dart';
// import 'package:ditonton/common/state_enum.dart';
// import 'package:ditonton/features/tv/domain/entities/tv.dart';
// import 'package:ditonton/features/tv/domain/usecases/tv_get_popular.dart';

// import 'package:ditonton/features/tv/presentation/provider/tv_popular_notifier.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// import 'tv_popular_notifier_test.mocks.dart';

// @GenerateMocks([TvGetPopular])
// void main() {
//   late MockGetTvPopular mockGetPopularTv;
//   late PopularTvNotifier notifier;
//   late int listenerCallCount;

//   setUp(() {
//     listenerCallCount = 0;
//     mockGetPopularTv = MockGetTvPopular();
//     notifier = PopularTvNotifier(mockGetPopularTv)
//       ..addListener(() {
//         listenerCallCount++;
//       });
//   });

//   final tTv = Tv(
//     adult: false,
//     backdropPath: 'backdropPath',
//     genreIds: const [1, 2, 3],
//     id: 1,
//     originalName: 'originalName',
//     overview: 'overview',
//     popularity: 1,
//     posterPath: 'posterPath',
//     releaseDate: 'releaseDate',
//     name: 'title',
//     video: false,
//     voteAverage: 1,
//     voteCount: 1,
//   );

//   final tTvList = <Tv>[tTv];

//   test('should change state to loading when usecase is called', () async {
//     // arrange
//     when(mockGetPopularTv.execute()).thenAnswer((_) async => Right(tTvList));
//     // act
//     notifier.fetchPopularTv();
//     // assert
//     expect(notifier.state, RequestState.loading);
//     expect(listenerCallCount, 1);
//   });

//   test('should change tvs data when data is gotten successfully', () async {
//     // arrange
//     when(mockGetPopularTv.execute()).thenAnswer((_) async => Right(tTvList));
//     // act
//     await notifier.fetchPopularTv();
//     // assert
//     expect(notifier.state, RequestState.loaded);
//     expect(notifier.tvs, tTvList);
//     expect(listenerCallCount, 2);
//   });

//   test('should return error when data is unsuccessful', () async {
//     // arrange
//     when(mockGetPopularTv.execute())
//         .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
//     // act
//     await notifier.fetchPopularTv();
//     // assert
//     expect(notifier.state, RequestState.error);
//     expect(notifier.message, 'Server Failure');
//     expect(listenerCallCount, 2);
//   });
// }
