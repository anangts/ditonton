import 'package:ditonton/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Text styles are applied correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          textTheme: kTextTheme,
          colorScheme: kColorScheme,
        ),
        home: Scaffold(
          body: Column(
            children: [
              Text('Heading 5', style: kHeading5),
              Text('Heading 6', style: kHeading6),
              Text('Subtitle', style: kSubtitle),
              Text('Body Text', style: kBodyText),
            ],
          ),
        ),
      ),
    );

    // Verify text styles
    final heading5Text = tester.widget<Text>(find.text('Heading 5'));
    expect(heading5Text.style, kHeading5);

    final heading6Text = tester.widget<Text>(find.text('Heading 6'));
    expect(heading6Text.style, kHeading6);

    final subtitleText = tester.widget<Text>(find.text('Subtitle'));
    expect(subtitleText.style, kSubtitle);

    final bodyText = tester.widget<Text>(find.text('Body Text'));
    expect(bodyText.style, kBodyText);
  });

  testWidgets('Color scheme is applied correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          colorScheme: kColorScheme,
        ),
        home: Scaffold(
          backgroundColor: kColorScheme.surface,
        ),
      ),
    );

    // Verify background color
    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
    expect(scaffold.backgroundColor, kColorScheme.surface);
  });
}
