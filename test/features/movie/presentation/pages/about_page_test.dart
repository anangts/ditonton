import 'package:ditonton/features/movie/presentation/pages/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AboutPage has an Image and Text', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(
      const MaterialApp(
        home: AboutPage(),
      ),
    );

    // Verify that there is one Image widget with the correct asset
    final imageFinder = find.byType(Image);
    expect(imageFinder, findsOneWidget);
    final image = tester.widget<Image>(imageFinder);
    expect(
      (image.image as AssetImage).assetName,
      'assets/circle-g.png',
    );

    // Verify that the Text widget is displayed
    expect(
        find.text(
          'Ditonton merupakan sebuah aplikasi katalog film yang dikembangkan oleh Dicoding Indonesia sebagai contoh proyek aplikasi untuk kelas Menjadi Flutter Developer Expert.',
        ),
        findsOneWidget);

    // Verify that the correct Stack widget is present
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Stack &&
            widget.alignment == AlignmentDirectional.topStart &&
            widget.children.length == 2, // Adjust this as needed
      ),
      findsOneWidget,
    );

    // Verify the presence of the back button
    expect(find.byType(IconButton), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);

    // Tap on the back button and check if it triggers navigation
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester
        .pumpAndSettle(); // Rebuild the widget after the state has changed
  });
}
