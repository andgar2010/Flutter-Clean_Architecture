import 'package:clean_architecture_counter/features/counter/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock.dart';

void main() {
  late CounterUseCase counterUseCase;
  late CounterGateway api;
  setUp(() {
    api = MockApi();
    counterUseCase = CounterUseCase(api);
  });
  group('Domain - UseCase Counter', () {
    test('getCounter() test', (() async {
      //Arrenge
      int expectedCounter = 5;
      when(() => api.getCount())
          .thenAnswer((_) => Future.value(const CounterEntity(count: 5)));
      //Act
      CounterEntity counter = await counterUseCase.getCounter();
      //Assert
      expect(expectedCounter, counter.count);
    }));
    test('getAllCounts() test', (() async {
      //Arrenge
      var expectedItemsCounters = 3;
      when(() => api.getAllCounts()).thenAnswer(
        (_) => Future.value(const [
          CounterEntity(count: 1),
          CounterEntity(count: 2),
          CounterEntity(count: 3),
        ]),
      );
      //Act
      List<CounterEntity> counters = await counterUseCase.getAllCounts();
      //Assert
      expect(expectedItemsCounters, counters.length);
    }));
  });
}
