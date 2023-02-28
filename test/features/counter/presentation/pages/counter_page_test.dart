import 'package:clean_architecture_counter/features/counter/config/provider/counter_provider.dart';
import 'package:clean_architecture_counter/features/counter/domain/entities/counter_entity.dart';
import 'package:clean_architecture_counter/features/counter/domain/usecases/counter_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../../../base_test_app.dart';
import '../../mock.dart';

void main() {
  late CounterProvider counterProvider;
  // late MockHttpClient mockHttpClient;
  late CounterUseCase counterUseCase;
  late MultiProvider ui;

  setUp(() {
    ui = baseApp(
      providers: [
        ChangeNotifierProvider(
          create: (_) => counterProvider,
        ),
      ],
    );
    counterUseCase = MockCounterUseCase();
    counterProvider = CounterProvider(counterUseCase: counterUseCase);
    // mockHttpClient = MockHttpClient();
    when(() => counterUseCase.getCounter())
        .thenAnswer((_) async => const CounterEntity(count: 42));
    when(() => counterUseCase.getAllCounts()).thenAnswer((_) async =>
        const [CounterEntity(count: 42), CounterEntity(count: 92)]);
    // when(() => counterUseCase.remoteCounterApi.httpClient)
    //     .thenReturn(mockHttpClient);
  });
  group("Presentation - Page Counter", () {
    testWidgets('increments smoke test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(ui);

      // Verify that our counter starts at 0.
      expect(find.text('0'), findsOneWidget);
      expect(find.text('1'), findsNothing);

      // Tap the '+' icon and trigger a frame.
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // Verify that our counter has incremented.
      expect(find.text('0'), findsNothing);
      expect(find.text('1'), findsOneWidget);

      // verify(() => counterUseCase.getCounter()).called(1);
      // verify(() => counterUseCase.increment()).called(1);
    });
    testWidgets('decrements smoke test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(ui);

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
      await tester.pumpWidget(ui);

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
