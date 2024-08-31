import 'package:ditonton/features/movie/domain/entities/entites.dart';
import 'package:ditonton/features/movie/presentation/bloc/bloc_export.dart';
import 'package:ditonton/features/movie/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([MovieDetailBloc])
void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();

    // Stub the stream and close methods
    when(mockMovieDetailBloc.stream).thenAnswer((_) => const Stream.empty());
    when(mockMovieDetailBloc.close()).thenAnswer((_) async {});
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<MovieDetailBloc>(
      create: (_) => mockMovieDetailBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const testMovieDetail = MovieDetail(
    originalTitle: 'Movie',
    adult: false,
    id: 1,
    title: 'Test Movie',
    overview: 'Test Overview',
    posterPath: '/test.jpg',
    voteAverage: 8.0,
    voteCount: 100,
    runtime: 120,
    releaseDate: '2021-01-01',
    genres: [Genre(id: 1, name: 'Action')],
    backdropPath: '/test_backdrop.jpg',
  );

  final testMoviesList = [
    Movie(
      id: 1,
      title: 'Test Movie',
      overview: 'Test Overview',
      posterPath: '/test.jpg',
    ),
  ];
  testWidgets('should display CircularProgressIndicator when state is loading',
      (WidgetTester tester) async {
    // Arrange
    when(mockMovieDetailBloc.state).thenReturn(const MovieDetailState(
      movieState: RequestState.loading,
    ));
    when(mockMovieDetailBloc.stream).thenAnswer((_) => Stream.value(
          const MovieDetailState(movieState: RequestState.loading),
        ));

    // Act
    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));
    await tester.pump(); // Use pump instead of pumpAndSettle

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should display error message when state is error',
      (WidgetTester tester) async {
    when(mockMovieDetailBloc.state).thenReturn(const MovieDetailState(
      movieState: RequestState.error,
      message: 'Failed to fetch data',
    ));

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));
    await tester.pumpAndSettle();

    expect(find.text('Failed to fetch data'), findsOneWidget);
  });
  testWidgets('should display DetailContent when state is loaded',
      (WidgetTester tester) async {
    // Arrange
    when(mockMovieDetailBloc.state).thenReturn(MovieDetailState(
      movieState: RequestState.loaded,
      movie: testMovieDetail,
      movieRecommendations: testMoviesList,
      recommendationState: RequestState.loaded,
      isAddedToWatchlist: false,
    ));
    when(mockMovieDetailBloc.stream).thenAnswer((_) => Stream.value(
          MovieDetailState(
            movieState: RequestState.loaded,
            movie: testMovieDetail,
            movieRecommendations: testMoviesList,
            recommendationState: RequestState.loaded,
            isAddedToWatchlist: false,
          ),
        ));

    // Act
    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    // Reduce the animation duration or skip animation
    await tester.pump(const Duration(milliseconds: 500));

    // Assert
    expect(find.byType(DetailContent), findsOneWidget);
    expect(find.text('Test Movie'), findsOneWidget);
  });

  testWidgets('should create the widget without errors',
      (WidgetTester tester) async {
    // Arrange
    when(mockMovieDetailBloc.state).thenReturn(const MovieDetailState(
      movieState: RequestState.loading,
    ));
    when(mockMovieDetailBloc.stream).thenAnswer((_) => Stream.value(
          const MovieDetailState(movieState: RequestState.loading),
        ));

    // Act
    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    // Assert
    expect(find.byType(MovieDetailPage), findsOneWidget);
  });
}
