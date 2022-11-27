import 'package:clean_architecture_counter/features/counter/counter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_exception/http_exception.dart';

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
      } on HttpException catch (e) {
        expect(
            e.toString(),
            endsWith(
                "HTTP Status 422 - Unprocessable Entity: Not found key 'count' "
                "in JSON, HTTP data = {countA: 2000, countB: 1000}"));
        expect(e.message, endsWith("Not found key 'count' in JSON"));
        expect(e.status.toString(), endsWith('422'));
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
      } on HttpException catch (e) {
        expect(
            e.toString(),
            endsWith(
                "HTTP Status 422 - Unprocessable Entity: Not found key 'count' "
                "in JSON, HTTP data = {countA: 1000, countB: 500}"));
        expect(e.message, endsWith("Not found key 'count' in JSON"));
        expect(e.status.toString(), endsWith('422'));
      }
    });
  });
}
