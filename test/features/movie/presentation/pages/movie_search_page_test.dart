import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/movie/domain/entities/movie.dart';
import 'package:ditonton/features/movie/presentation/bloc/bloc_export.dart';
import 'package:ditonton/features/movie/presentation/pages/movie_search_page.dart';
import 'package:ditonton/features/movie/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movie_search_page_test.mocks.dart';

@GenerateMocks([MovieSearchBloc])
void main() {
  late MockMovieSearchBloc mockMovieSearchBloc;

  setUp(() {
    mockMovieSearchBloc = MockMovieSearchBloc();

    // Stub the stream and close methods
    when(mockMovieSearchBloc.stream).thenAnswer((_) => const Stream.empty());
    when(mockMovieSearchBloc.state).thenReturn(const MovieSearchState());
    when(mockMovieSearchBloc.close()).thenAnswer((_) async {
      return;
    });
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<MovieSearchBloc>.value(
      value: mockMovieSearchBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should display CircularProgressIndicator when state is loading',
      (WidgetTester tester) async {
    // Arrange
    when(mockMovieSearchBloc.state).thenReturn(const MovieSearchState(
      state: RequestState.loading,
    ));

    // Act
    await tester.pumpWidget(makeTestableWidget(const MovieSearchPage()));
    await tester.pump();

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets(
      'should display ListView when state is loaded with search results',
      (WidgetTester tester) async {
    // Arrange
    final movies = [
      Movie(
        id: 1,
        title: 'Test Movie',
        overview: 'Test Overview',
        posterPath: '/test.jpg',
      ),
    ];
    when(mockMovieSearchBloc.state).thenReturn(MovieSearchState(
      state: RequestState.loaded,
      searchResult: movies,
    ));

    // Act
    await tester.pumpWidget(makeTestableWidget(const MovieSearchPage()));
    await tester.pump();

    // Assert
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(MovieCard), findsOneWidget);
  });

  testWidgets('should display error message when state is error',
      (WidgetTester tester) async {
    // Arrange
    const errorMessage = 'Failed to fetch data';
    when(mockMovieSearchBloc.state).thenReturn(const MovieSearchState(
      state: RequestState.error,
      message: errorMessage,
    ));

    // Act
    await tester.pumpWidget(makeTestableWidget(const MovieSearchPage()));
    await tester.pump();

    // Assert
    expect(find.text(errorMessage), findsOneWidget);
  });

  testWidgets('should trigger search on submitting query',
      (WidgetTester tester) async {
    // Arrange
    when(mockMovieSearchBloc.state).thenReturn(const MovieSearchState());

    // Act
    await tester.pumpWidget(makeTestableWidget(const MovieSearchPage()));
    await tester.enterText(find.byType(TextField), 'test');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pump();

    // Assert
    verify(mockMovieSearchBloc.add(const FetchMovieSearch('test'))).called(1);
  });
}
