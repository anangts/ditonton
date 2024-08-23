import 'package:ditonton/features/movie/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton/features/movie/domain/entities/movie.dart';
import 'package:ditonton/features/movie/presentation/pages/movie_detail_page.dart';

void main() {
  testWidgets('MovieCard displays movie title and overview',
      (WidgetTester tester) async {
    // Create a sample movie
    final movie = Movie(
      id: 1,
      title: 'Movie Title',
      overview: 'Movie Overview',
      posterPath: 'assets/circle-g.png',
    );

    // Build the MovieCard widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MovieCard(movie),
        ),
        routes: {
          MovieDetailPage.routeName: (context) =>
              const Scaffold(body: Text('Movie Detail Page')),
        },
      ),
    );

    // Verify movie title is displayed
    expect(find.text('Movie Title'), findsOneWidget);

    // Verify movie overview is displayed
    expect(find.text('Movie Overview'), findsOneWidget);
  });

  testWidgets('MovieCard navigates to MovieDetailPage on tap',
      (WidgetTester tester) async {
    // Create a sample movie
    final movie = Movie(
      id: 1,
      title: 'Movie Title',
      overview: 'Movie Overview',
      posterPath: 'assets/circle-g.png',
    );

    // Build the app with routes
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MovieCard(movie),
        ),
        routes: {
          MovieDetailPage.routeName: (context) =>
              const Scaffold(body: Text('Movie Detail Page')),
        },
      ),
    );

    // Tap the MovieCard
    await tester.tap(find.byType(MovieCard));
    await tester.pumpAndSettle(); // Wait for navigation to complete

    // Verify the MovieDetailPage is displayed
    expect(find.text('Movie Detail Page'), findsOneWidget);
  });
}
