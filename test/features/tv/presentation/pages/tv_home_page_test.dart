import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv/domain/entities/tv.dart';
import 'package:ditonton/features/tv/presentation/bloc/bloc_export.dart';
import 'package:ditonton/features/tv/presentation/pages/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'tv_home_page_test.mocks.dart';

@GenerateMocks([TvListBloc])
void main() {
  late MockTvListBloc mockTvListBloc;

  setUp(() {
    mockTvListBloc = MockTvListBloc();

    // Stub the stream and close methods
    when(mockTvListBloc.stream).thenAnswer((_) => const Stream.empty());
    when(mockTvListBloc.state).thenReturn(const TvListState());
    when(mockTvListBloc.close()).thenAnswer((_) async {
      return;
    });
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvListBloc>.value(
      value: mockTvListBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should display CircularProgressIndicator when state is loading',
      (WidgetTester tester) async {
    // Arrange
    when(mockTvListBloc.state).thenReturn(const TvListState(
      nowPlayingState: RequestState.loading,
      tvNowPlaying: [],
      tvPopularState: RequestState.loading,
      popularTvs: [],
      tvTopRatedState: RequestState.loading,
      tvTopRated: [],
    ));

    // Act
    await tester.pumpWidget(makeTestableWidget(const TvHomePage()));
    await tester.pump();

    // Assert
    expect(find.byType(CircularProgressIndicator), findsWidgets);
  });

  testWidgets('should display TvList when state is loaded',
      (WidgetTester tester) async {
    // Arrange
    final tvs = [
      Tv(
        id: 1,
        name: 'Test Tv',
        overview: 'Test Overview',
        posterPath: '/test.jpg',
      ),
    ];
    when(mockTvListBloc.state).thenReturn(TvListState(
      nowPlayingState: RequestState.loaded,
      tvNowPlaying: tvs,
      tvPopularState: RequestState.loaded,
      popularTvs: tvs,
      tvTopRatedState: RequestState.loaded,
      tvTopRated: tvs,
    ));

    // Act
    await tester.pumpWidget(makeTestableWidget(const TvHomePage()));
    await tester.pump();

    // Assert
    expect(find.byType(TvList), findsNWidgets(3));
  });

  testWidgets('should display error message when state is error',
      (WidgetTester tester) async {
    // Arrange
    when(mockTvListBloc.state).thenReturn(const TvListState(
      nowPlayingState: RequestState.error,
      tvNowPlaying: [],
      tvPopularState: RequestState.error,
      popularTvs: [],
      tvTopRatedState: RequestState.error,
      tvTopRated: [],
    ));

    // Act
    await tester.pumpWidget(makeTestableWidget(const TvHomePage()));
    await tester.pump();

    // Assert
    expect(find.text('Failed'), findsWidgets);
  });
}
