import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv/presentation/bloc/bloc_export.dart';
import 'package:ditonton/features/tv/presentation/pages/page.dart';
import 'package:ditonton/features/tv/domain/entities/tv.dart';
import 'package:ditonton/features/tv/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'tv_popular_page_test.mocks.dart';

@GenerateMocks([TvPopularBloc])
void main() {
  late MockTvPopularBloc mockPopularTvBloc;

  setUp(() {
    mockPopularTvBloc = MockTvPopularBloc();

    // Stub the stream and close methods
    when(mockPopularTvBloc.stream).thenAnswer((_) => const Stream.empty());
    when(mockPopularTvBloc.state).thenReturn(const TvPopularState());
    when(mockPopularTvBloc.close()).thenAnswer((_) async {
      return;
    });
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvPopularBloc>.value(
      value: mockPopularTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should display CircularProgressIndicator when state is loading',
      (WidgetTester tester) async {
    // Arrange
    when(mockPopularTvBloc.state).thenReturn(const TvPopularState(
      state: RequestState.loading,
    ));

    // Act
    await tester.pumpWidget(makeTestableWidget(const TvPopularPage()));
    await tester.pump();

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should display ListView when state is loaded',
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
    when(mockPopularTvBloc.state).thenReturn(TvPopularState(
      state: RequestState.loaded,
      tvs: tvs,
    ));

    // Act
    await tester.pumpWidget(makeTestableWidget(const TvPopularPage()));
    await tester.pump();

    // Assert
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(TvCard), findsOneWidget);
  });

  testWidgets('should display error message when state is error',
      (WidgetTester tester) async {
    // Arrange
    const errorMessage = 'Failed to fetch data';
    when(mockPopularTvBloc.state).thenReturn(const TvPopularState(
      state: RequestState.error,
      message: errorMessage,
    ));

    // Act
    await tester.pumpWidget(makeTestableWidget(const TvPopularPage()));
    await tester.pump();

    // Assert
    expect(find.byKey(const Key('error_message')), findsOneWidget);
    expect(find.text(errorMessage), findsOneWidget);
  });
}
