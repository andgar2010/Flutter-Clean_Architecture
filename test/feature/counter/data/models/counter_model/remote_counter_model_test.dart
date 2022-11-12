import 'package:clean_architecture_counter/features/counter/counter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_exception/http_exception.dart';

void main() {
  group('Model RemoteCounter', () {
    const RemoteCounterModel remoteCounterModel = RemoteCounterModel(
      countA: 1,
      countB: 2,
    );

    test('get field count test', () {
      expect(remoteCounterModel.countA, 1);
      expect(remoteCounterModel.countB, 2);
    });
    test('toEntity() test', () {
      final CounterEntity counterEntity = remoteCounterModel.toEntity();
      expect(counterEntity, isA<CounterEntity>());
      expect(counterEntity.toString(), 'CounterEntity(count: 1)');
    });
    test('toJson() test', () {
      expect(remoteCounterModel.toJson(), '{"countA":1,"countB":2}');
    });
    test('toMap() test', () {
      expect(remoteCounterModel.toMap(), {'countA': 1, 'countB': 2});
    });
    test("toString() test", () {
      expect(remoteCounterModel.toString(),
          'RemoteCounterModel(countA: 1, countB: 2)');
    });
    test('factory RemoteCounterModel fromEntity() test', () {
      final RemoteCounterModel remoteCounterModel =
          RemoteCounterModel.fromEntity(const CounterEntity(count: 1));
      expect(remoteCounterModel, isA<RemoteCounterModel>());
      expect(
        remoteCounterModel.toString(),
        'RemoteCounterModel(countA: 1, countB: 0)',
      );
    });
    test('factory RemoteCounterModel fromJson() test', () {
      const String dataJson = '{"countA":2000, "countB":1000}';
      final RemoteCounterModel remoteCounterModel =
          RemoteCounterModel.fromJson(dataJson);
      expect(remoteCounterModel, isA<RemoteCounterModel>());
      expect(remoteCounterModel.toString(),
          'RemoteCounterModel(countA: 2000, countB: 1000)');
    });
    test('factory RemoteCounterModel fromJson() failure test', () {
      try {
        const String dataJson = '{"countA":2000, "count":1000}';
        RemoteCounterModel.fromJson(dataJson);
      } on HttpException catch (e) {
        expect(
          e.toString(),
          endsWith(
              "HTTP Status 422 - Unprocessable Entity: Not found key 'countA' "
              "and 'countB' in JSON, HTTP data = {countA: 2000, count: 1000}"),
        );
        expect(
          e.message,
          endsWith("Not found key 'countA' and 'countB' in JSON"),
        );
        expect(e.status.toString(), endsWith('422'));
      }
    });
    test('factory RemoteCounterModel fromMap() [countA String] test', () {
      const Map<String, dynamic> dataMap = {
        'count': 2000,
        'countA': '1000',
        'countB': 500,
      };
      final RemoteCounterModel remoteCounterModel =
          RemoteCounterModel.fromMap(dataMap);
      expect(remoteCounterModel, isA<RemoteCounterModel>());
      expect(
        remoteCounterModel.toString(),
        'RemoteCounterModel(countA: 1000, countB: 500)',
      );
    });
    test('factory RemoteCounterModel fromMap() [countB String] test', () {
      const Map<String, dynamic> dataMap = {
        'count': 2000,
        'countA': 1000,
        'countB': '500',
      };
      final RemoteCounterModel remoteCounterModel =
          RemoteCounterModel.fromMap(dataMap);
      expect(remoteCounterModel, isA<RemoteCounterModel>());
      expect(
        remoteCounterModel.toString(),
        'RemoteCounterModel(countA: 1000, countB: 500)',
      );
    });
    test('factory RemoteCounterModel fromMap() failure test', () {
      try {
        const Map<String, dynamic> dataMap = {
          'count': '1000',
          'countB': 500,
        };
        RemoteCounterModel.fromMap(dataMap);
      } on HttpException catch (e) {
        expect(
          e.toString(),
          endsWith(
              "HTTP Status 422 - Unprocessable Entity: Not found key 'countA' "
              "and 'countB' in JSON, HTTP data = {count: 1000, countB: 500}"),
        );
        expect(
          e.message,
          endsWith("Not found key 'countA' and 'countB' in JSON"),
        );
        expect(e.status.toString(), endsWith('422'));
      }
    });
  });
}
