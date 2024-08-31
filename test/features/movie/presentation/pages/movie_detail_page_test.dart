// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:ditonton/features/movie/presentation/bloc/bloc_export.dart';
// import 'package:ditonton/features/movie/domain/entities/entites.dart';
// import 'package:ditonton/common/state_enum.dart';
// import 'package:ditonton/features/movie/presentation/pages/movie_detail_page.dart';

// class MockMovieDetailBloc extends Mock implements MovieDetailBloc {}

// void main() {
//   late MockMovieDetailBloc mockMovieDetailBloc;

//   setUp(() {
//     mockMovieDetailBloc = MockMovieDetailBloc();
//   });

//   Widget createWidgetUnderTest() {
//     return BlocProvider<MovieDetailBloc>(
//       create: (context) => mockMovieDetailBloc,
//       child: const MaterialApp(
//         home: MovieDetailPage(id: 1),
//       ),
//     );
//   }

//   testWidgets('Displays loading indicator while fetching data',
//       (WidgetTester tester) async {
//     // Arrange
//     when(() => mockMovieDetailBloc.state).thenAnswer(
//       (_) => const MovieDetailState(
//         movieState: RequestState.loading,
//         recommendationState: RequestState.loading,
//         movie: null,
//         movieRecommendations: [],
//         isAddedToWatchlist: false,
//         message: '',
//       ),
//     );

//     // Act
//     await tester.pumpWidget(createWidgetUnderTest());
//     await tester.pump(); // Rebuild the widget

//     // Assert
//     expect(find.byType(CircularProgressIndicator), findsOneWidget);
//   });

//   testWidgets('Displays movie details when data is loaded',
//       (WidgetTester tester) async {
//     // Arrange
//     when(() => mockMovieDetailBloc.state).thenAnswer(
//       (_) => MovieDetailState(
//         movieState: RequestState.loaded,
//         recommendationState: RequestState.loaded,
//         movie: Movie(
//             id: 1,
//             title: 'Test Movie',
//             posterPath: '/path.jpg',
//             voteAverage: 7.0,
//             genres: const [],
//             runtime: 120,
//             overview: 'Test Overview'),
//         movieRecommendations: const [],
//         isAddedToWatchlist: false,
//         message: '',
//       ),
//     );

//     // Act
//     await tester.pumpWidget(createWidgetUnderTest());
//     await tester.pump(); // Rebuild the widget

//     // Assert
//     expect(find.text('Test Movie'), findsOneWidget);
//     expect(find.text('Overview'), findsOneWidget);
//   });

//   testWidgets('Displays recommendations when recommendation data is loaded',
//       (WidgetTester tester) async {
//     // Arrange
//     when(() => mockMovieDetailBloc.state).thenAnswer(
//       (_) => MovieDetailState(
//         movieState: RequestState.loaded,
//         recommendationState: RequestState.loaded,
//         movie: Movie(
//             id: 1,
//             title: 'Test Movie',
//             posterPath: '/path.jpg',
//             voteAverage: 7.0,
//             genres: const [],
//             runtime: 120,
//             overview: 'Test Overview'),
//         movieRecommendations: [
//           Movie(
//               id: 2,
//               title: 'Recommended Movie',
//               posterPath: '/recommendation.jpg',
//               voteAverage: 8.0,
//               genres: const [],
//               runtime: 110,
//               overview: 'Recommended Overview')
//         ],
//         isAddedToWatchlist: false,
//         message: '',
//       ),
//     );

//     // Act
//     await tester.pumpWidget(createWidgetUnderTest());
//     await tester.pump(); // Rebuild the widget

//     // Assert
//     expect(find.byType(CachedNetworkImage), findsOneWidget);
//     expect(find.text('Recommended Movie'), findsOneWidget);
//   });
// }
