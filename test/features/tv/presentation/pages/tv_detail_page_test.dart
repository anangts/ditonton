import 'package:ditonton/features/tv/domain/entities/entites.dart';
import 'package:ditonton/features/tv/presentation/bloc/bloc_export.dart';
import 'package:ditonton/features/tv/presentation/pages/tv_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/common/state_enum.dart';

import 'tv_detail_page_test.mocks.dart';

@GenerateMocks([TvDetailBloc])
void main() {
  late MockTvDetailBloc mockTvDetailBloc;

  setUp(() {
    mockTvDetailBloc = MockTvDetailBloc();

    // Stub the stream and close methods
    when(mockTvDetailBloc.stream).thenAnswer((_) => const Stream.empty());
    when(mockTvDetailBloc.close()).thenAnswer((_) async {
      return;
    });
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvDetailBloc>(
      create: (_) => mockTvDetailBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const testTvDetail = TvDetail(
    originalName: 'Tv',
    adult: false,
    id: 1,
    name: 'Test Tv',
    overview: 'Test Overview',
    posterPath: '/test.jpg',
    voteAverage: 8.0,
    voteCount: 100,
    runtime: 120,
    releaseDate: '2021-01-01',
    genres: [TvGenre(id: 1, name: 'Action')],
    backdropPath: '/test_backdrop.jpg',
  );

  final testTvList = [
    Tv(
      id: 1,
      name: 'Test Tv',
      overview: 'Test Overview',
      posterPath: '/test.jpg',
    ),
  ];
  testWidgets('should display CircularProgressIndicator when state is loading',
      (WidgetTester tester) async {
    // Arrange
    when(mockTvDetailBloc.state).thenReturn(const TvDetailState(
      tvState: RequestState.loading,
    ));
    when(mockTvDetailBloc.stream).thenAnswer((_) => Stream.value(
          const TvDetailState(tvState: RequestState.loading),
        ));

    // Act
    await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));
    await tester.pump(); // Use pump instead of pumpAndSettle

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should display error message when state is error',
      (WidgetTester tester) async {
    when(mockTvDetailBloc.state).thenReturn(const TvDetailState(
      tvState: RequestState.error,
      message: 'Failed to fetch data',
    ));

    await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));
    await tester.pumpAndSettle();

    expect(find.text('Failed to fetch data'), findsOneWidget);
  });
  testWidgets('should display DetailContent when state is loaded',
      (WidgetTester tester) async {
    // Arrange
    when(mockTvDetailBloc.state).thenReturn(TvDetailState(
      tvState: RequestState.loaded,
      tv: testTvDetail,
      tvRecommendations: testTvList,
      recommendationState: RequestState.loaded,
      isAddedToWatchlist: false,
    ));
    when(mockTvDetailBloc.stream).thenAnswer((_) => Stream.value(
          TvDetailState(
            tvState: RequestState.loaded,
            tv: testTvDetail,
            tvRecommendations: testTvList,
            recommendationState: RequestState.loaded,
            isAddedToWatchlist: false,
          ),
        ));

    // Act
    await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

    // Reduce the animation duration or skip animation
    await tester.pump(const Duration(milliseconds: 500));

    // Assert
    expect(find.byType(DetailContent), findsOneWidget);
    expect(find.text('Test Tv'), findsOneWidget);
  });

  testWidgets('should create the widget without errors',
      (WidgetTester tester) async {
    // Arrange
    when(mockTvDetailBloc.state).thenReturn(const TvDetailState(
      tvState: RequestState.loading,
    ));
    when(mockTvDetailBloc.stream).thenAnswer((_) => Stream.value(
          const TvDetailState(tvState: RequestState.loading),
        ));

    // Act
    await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

    // Assert
    expect(find.byType(TvDetailPage), findsOneWidget);
  });
}
