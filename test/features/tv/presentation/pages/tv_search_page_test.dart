import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv/domain/entities/tv.dart';
import 'package:ditonton/features/tv/presentation/bloc/bloc_export.dart';
import 'package:ditonton/features/tv/presentation/pages/tv_search_page.dart';
import 'package:ditonton/features/tv/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'tv_search_page_test.mocks.dart';

@GenerateMocks([TvSearchBloc])
void main() {
  late MockTvSearchBloc mockTvSearchBloc;

  setUp(() {
    mockTvSearchBloc = MockTvSearchBloc();

    // Stub the stream and close methods
    when(mockTvSearchBloc.stream).thenAnswer((_) => const Stream.empty());
    when(mockTvSearchBloc.state).thenReturn(const TvSearchState());
    when(mockTvSearchBloc.close()).thenAnswer((_) async {
      return;
    });
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvSearchBloc>.value(
      value: mockTvSearchBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should display CircularProgressIndicator when state is loading',
      (WidgetTester tester) async {
    // Arrange
    when(mockTvSearchBloc.state).thenReturn(const TvSearchState(
      state: RequestState.loading,
    ));

    // Act
    await tester.pumpWidget(makeTestableWidget(const TvSearchPage()));
    await tester.pump();

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets(
      'should display ListView when state is loaded with search results',
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
    when(mockTvSearchBloc.state).thenReturn(TvSearchState(
      state: RequestState.loaded,
      searchResult: tvs,
    ));

    // Act
    await tester.pumpWidget(makeTestableWidget(const TvSearchPage()));
    await tester.pump();

    // Assert
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(TvCard), findsOneWidget);
  });

  testWidgets('should display error message when state is error',
      (WidgetTester tester) async {
    // Arrange
    const errorMessage = 'Failed to fetch data';
    when(mockTvSearchBloc.state).thenReturn(const TvSearchState(
      state: RequestState.error,
      message: errorMessage,
    ));

    // Act
    await tester.pumpWidget(makeTestableWidget(const TvSearchPage()));
    await tester.pump();

    // Assert
    expect(find.text(errorMessage), findsOneWidget);
  });

  testWidgets('should trigger search on submitting query',
      (WidgetTester tester) async {
    // Arrange
    when(mockTvSearchBloc.state).thenReturn(const TvSearchState());

    // Act
    await tester.pumpWidget(makeTestableWidget(const TvSearchPage()));
    await tester.enterText(find.byType(TextField), 'test');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pump();

    // Assert
    verify(mockTvSearchBloc.add(const FetchTvSearch('test'))).called(1);
  });
}
