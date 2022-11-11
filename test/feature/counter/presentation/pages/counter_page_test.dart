// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:clean_architecture_counter/app.dart';

void main() {
  group("Page Counter", () {
    testWidgets('increments smoke test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const App());

      // Verify that our counter starts at 0.
      expect(find.text('0'), findsOneWidget);
      expect(find.text('1'), findsNothing);

      // Tap the '+' icon and trigger a frame.
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // Verify that our counter has incremented.
      expect(find.text('0'), findsNothing);
      expect(find.text('1'), findsOneWidget);
    });
    testWidgets('decrements smoke test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const App());

      // Verify that our counter starts at 0.
      expect(find.text('0'), findsOneWidget);
      expect(find.text('-1'), findsNothing);

      // Tap the '-' icon and trigger a frame.
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();

      // Verify that our counter has decremented.
      expect(find.text('0'), findsNothing);
      expect(find.text('-1'), findsOneWidget);
    });
    testWidgets('reset smoke test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const App());

      // Verify that our counter starts at 0.
      expect(find.text('0'), findsOneWidget);
      expect(find.text('2'), findsNothing);

      // Tap the '+' icon and trigger a frame.
      await tester.tap(find.byIcon(Icons.add));
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // Verify that our counter has incremented.
      expect(find.text('0'), findsNothing);
      expect(find.text('2'), findsOneWidget);

      // Tap the '🔄' icon and trigger a frame.
      await tester.tap(find.byIcon(Icons.refresh));
      await tester.pump();

      // Verify that our counter has reseted.
      expect(find.text('2'), findsNothing);
      expect(find.text('0'), findsOneWidget);
    });
  });
}
