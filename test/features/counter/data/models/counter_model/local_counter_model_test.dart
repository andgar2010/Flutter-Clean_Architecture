import 'package:clean_architecture_counter/core/core.dart';
import 'package:clean_architecture_counter/features/counter/counter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Data - Model LocalCounter', () {
    const LocalCounterModel localCounterModel = LocalCounterModel(count: 1);
    test('get field count test', () {
      expect(localCounterModel.count, 1);
    });
    test('toEntity() test', () {
      final CounterEntity counterEntity = localCounterModel.toEntity();
      expect(counterEntity, isA<CounterEntity>());
      expect(counterEntity.toString(), 'CounterEntity(count: 1)');
    });
    test('toJson() test', () {
      expect(localCounterModel.toJson(), '{"count":1}');
    });
    test('toMap() test', () {
      expect(localCounterModel.toMap(), {'count': 1});
    });
    test("toString() test", () {
      expect(localCounterModel.toString(), 'LocalCounterModel(count: 1)');
    });
    test('factory LocalCounterModel fromEntity() test', () {
      final LocalCounterModel localCounterModel =
          LocalCounterModel.fromEntity(const CounterEntity(count: 1));
      expect(localCounterModel, isA<LocalCounterModel>());
      expect(localCounterModel.toString(), 'LocalCounterModel(count: 1)');
    });
    test('factory LocalCounterModel fromJson() value int test', () {
      const String dataJson = '{"count":2000, "countA":1000}';
      final LocalCounterModel localCounterModel =
          LocalCounterModel.fromJson(dataJson);
      expect(localCounterModel, isA<LocalCounterModel>());
      expect(localCounterModel.toString(), 'LocalCounterModel(count: 2000)');
    });
    test('factory LocalCounterModel fromJson() value string test', () {
      const String dataJson = '{"count":"4000", "countA":1000}';
      final LocalCounterModel localCounterModel =
          LocalCounterModel.fromJson(dataJson);
      expect(localCounterModel, isA<LocalCounterModel>());
      expect(localCounterModel.toString(), 'LocalCounterModel(count: 4000)');
    });
    test('factory LocalCounterModel fromJson() failure test', () {
      try {
        const String dataJson = '{"countA":2000, "countB":1000}';
        LocalCounterModel.fromJson(dataJson);
      } on InvalidJSONResponseException catch (e) {
        expect(
          e.toString(),
          contains("Invalid JSON response - Key not found = ['count']; "
              "Current HTTP data = {countA: 2000, countB: 1000}"),
        );

        expect(e.missingKeys, ['count']);
      }
    });
    test('factory LocalCounterModel fromMap() test', () {
      const Map<String, dynamic> dataMap = {
        'countA': '1000',
        'countB': 500,
        'count': 2000,
      };
      final LocalCounterModel localCounterModel =
          LocalCounterModel.fromMap(dataMap);
      expect(localCounterModel, isA<LocalCounterModel>());
      expect(localCounterModel.toString(), 'LocalCounterModel(count: 2000)');
    });
    test('factory LocalCounterModel fromMap() failure test', () {
      try {
        const Map<String, dynamic> dataMap = {
          'countA': '1000',
          'countB': 500,
        };
        LocalCounterModel.fromMap(dataMap);
      } on InvalidJSONResponseException catch (e) {
        expect(
          e.toString(),
          contains("Invalid JSON response - Key not found = ['count']; "
              "Current HTTP data = {countA: 1000, countB: 500}"),
        );

        expect(e.missingKeys, ['count']);
      }
    });
  });
}
