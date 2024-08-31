import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/movie/domain/entities/movie.dart';
import 'package:ditonton/features/movie/presentation/bloc/bloc_export.dart';
import 'package:ditonton/features/movie/presentation/pages/movie_watchlist_page.dart';
import 'package:ditonton/features/movie/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'watchlist_movies_page_test.mocks.dart';

@GenerateMocks([MovieWatchlistBloc])
void main() {
  late MockMovieWatchlistBloc mockMovieWatchlistBloc;

  setUp(() {
    mockMovieWatchlistBloc = MockMovieWatchlistBloc();

    // Stub the stream and close methods
    when(mockMovieWatchlistBloc.stream).thenAnswer((_) => const Stream.empty());
    when(mockMovieWatchlistBloc.state).thenReturn(const MovieWatchlistState());
    when(mockMovieWatchlistBloc.close()).thenAnswer((_) async {
      return;
    });
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<MovieWatchlistBloc>.value(
      value: mockMovieWatchlistBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should display CircularProgressIndicator when state is loading',
      (WidgetTester tester) async {
    // Arrange
    when(mockMovieWatchlistBloc.state).thenReturn(const MovieWatchlistState(
      watchlistState: RequestState.loading,
    ));

    // Act
    await tester.pumpWidget(makeTestableWidget(const MovieWatchlistPage()));
    await tester.pump();

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should display ListView when state is loaded with movies',
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
    when(mockMovieWatchlistBloc.state).thenReturn(MovieWatchlistState(
      watchlistState: RequestState.loaded,
      watchlistMovies: movies,
    ));

    // Act
    await tester.pumpWidget(makeTestableWidget(const MovieWatchlistPage()));
    await tester.pump();

    // Assert
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(MovieCard), findsOneWidget);
  });

  testWidgets('should display empty message when watchlist is empty',
      (WidgetTester tester) async {
    // Arrange
    when(mockMovieWatchlistBloc.state).thenReturn(const MovieWatchlistState(
      watchlistState: RequestState.loaded,
      watchlistMovies: [],
    ));

    // Act
    await tester.pumpWidget(makeTestableWidget(const MovieWatchlistPage()));
    await tester.pump();

    // Assert
    expect(find.text('Watchlist is empty'), findsOneWidget);
  });

  testWidgets('should display error message when state is error',
      (WidgetTester tester) async {
    // Arrange
    const errorMessage = 'Failed to fetch data';
    when(mockMovieWatchlistBloc.state).thenReturn(const MovieWatchlistState(
      watchlistState: RequestState.error,
      message: errorMessage,
    ));

    // Act
    await tester.pumpWidget(makeTestableWidget(const MovieWatchlistPage()));
    await tester.pump();

    // Assert
    expect(find.byKey(const Key('error_message')), findsOneWidget);
    expect(find.text(errorMessage), findsOneWidget);
  });
}
