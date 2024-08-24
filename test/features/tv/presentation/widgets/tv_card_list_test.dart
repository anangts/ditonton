import 'package:ditonton/features/tv/presentation/pages/tv_movie_detail_page.dart';
import 'package:ditonton/features/tv/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton/features/tv/domain/entities/tv.dart';

void main() {
  testWidgets('TvCard displays tv title and overview',
      (WidgetTester tester) async {
    // Create a sample tv
    final tv = Tv(
      id: 1,
      name: 'Tv Title',
      overview: 'Tv Overview',
      posterPath: 'assets/circle-g.png',
    );

    // Build the TvCard widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TvCard(tv),
        ),
        routes: {
          TvDetailPage.routeName: (context) =>
              const Scaffold(body: Text('Tv Detail Page')),
        },
      ),
    );

    // Verify tv title is displayed
    expect(find.text('Tv Title'), findsOneWidget);

    // Verify tv overview is displayed
    expect(find.text('Tv Overview'), findsOneWidget);
  });

  testWidgets('TvCard navigates to TvDetailPage on tap',
      (WidgetTester tester) async {
    // Create a sample tv
    final tv = Tv(
      id: 1,
      name: 'Tv Title',
      overview: 'Tv Overview',
      posterPath: 'assets/circle-g.png',
    );

    // Build the app with routes
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TvCard(tv),
        ),
        routes: {
          TvDetailPage.routeName: (context) =>
              const Scaffold(body: Text('Tv Detail Page')),
        },
      ),
    );

    // Tap the TvCard
    await tester.tap(find.byType(TvCard));
    await tester.pumpAndSettle(); // Wait for navigation to complete

    // Verify the TvDetailPage is displayed
    expect(find.text('Tv Detail Page'), findsOneWidget);
  });
}
