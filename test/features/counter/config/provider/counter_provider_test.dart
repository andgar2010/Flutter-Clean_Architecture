import 'package:clean_architecture_counter/features/counter/counter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../infrastructure/driven_adapter/api/remote_counter_api_test.dart';

void main() {
  group('Config - Provider Counter', () {
    test('UseCase Counter', () {});
    late CounterProvider counterProvider;

    setUp(() {
      counterProvider = CounterProvider(
        counterUseCase: CounterUseCase(MockRemoteCounterApi()),
      );
    });

    test('getCounter() from CounterUseCase test', () async {
      CounterUseCase counterUseCase = counterProvider.counterUseCase;
      when(() => counterUseCase.getCounter())
          .thenAnswer((_) => Future.value(const CounterEntity(count: 1)));
      CounterEntity counterEntity = await counterUseCase.getCounter();
      expect(counterEntity.count, 1);
    });
  });
}
