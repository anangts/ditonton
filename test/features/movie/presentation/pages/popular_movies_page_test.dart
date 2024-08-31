import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/movie/presentation/bloc/bloc_export.dart';
import 'package:ditonton/features/movie/presentation/pages/page.dart';
import 'package:ditonton/features/movie/domain/entities/movie.dart';
import 'package:ditonton/features/movie/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'popular_movies_page_test.mocks.dart';

@GenerateMocks([PopularMoviesBloc])
void main() {
  late MockPopularMoviesBloc mockPopularMoviesBloc;

  setUp(() {
    mockPopularMoviesBloc = MockPopularMoviesBloc();

    // Stub the stream and close methods
    when(mockPopularMoviesBloc.stream).thenAnswer((_) => const Stream.empty());
    when(mockPopularMoviesBloc.state).thenReturn(const PopularMoviesState());
    when(mockPopularMoviesBloc.close()).thenAnswer((_) async {
      return;
    });
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularMoviesBloc>.value(
      value: mockPopularMoviesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should display CircularProgressIndicator when state is loading',
      (WidgetTester tester) async {
    // Arrange
    when(mockPopularMoviesBloc.state).thenReturn(const PopularMoviesState(
      state: RequestState.loading,
    ));

    // Act
    await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));
    await tester.pump();

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should display ListView when state is loaded',
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
    when(mockPopularMoviesBloc.state).thenReturn(PopularMoviesState(
      state: RequestState.loaded,
      movies: movies,
    ));

    // Act
    await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));
    await tester.pump();

    // Assert
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(MovieCard), findsOneWidget);
  });

  testWidgets('should display error message when state is error',
      (WidgetTester tester) async {
    // Arrange
    const errorMessage = 'Failed to fetch data';
    when(mockPopularMoviesBloc.state).thenReturn(const PopularMoviesState(
      state: RequestState.error,
      message: errorMessage,
    ));

    // Act
    await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));
    await tester.pump();

    // Assert
    expect(find.byKey(const Key('error_message')), findsOneWidget);
    expect(find.text(errorMessage), findsOneWidget);
  });
}
