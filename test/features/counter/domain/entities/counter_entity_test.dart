import 'package:clean_architecture_counter/features/counter/counter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Domain - Entity Counter', () {
    const CounterEntity counter = CounterEntity(count: 1);
    test("toString() test", () {
      expect(counter.toString(), 'CounterEntity(count: 1)');
    });
    test("get value of count test", () {
      expect(counter.count, 1);
    });
    test("get props of count test", () {
      expect(counter.props, [1]);
    });
    test("copy for change value of count updated test", () {
      final CounterEntity counterUpdated = counter.copyWith(count: 2);
      expect(counterUpdated.count, 2);
    });
  });
}
