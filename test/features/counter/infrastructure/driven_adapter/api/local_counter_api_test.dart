import 'dart:convert';

import 'package:clean_architecture_counter/core/core.dart';
import 'package:clean_architecture_counter/features/counter/domain/domain.dart';
import 'package:clean_architecture_counter/features/counter/infrastructure/driven_adapter/api/counter_api/counter_api.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock.dart';


void main() {
  group('Infrastructure - Local Counter Api', () {
    late http.Client httpClient;
    late LocalCounterApi localCounterApi;

    final Uri urlApiCount = Uri.parse(LocalCounterApi.url);
    final Uri urlApiCounts = Uri.parse('${LocalCounterApi.url}/counts');

    setUp(() {
      httpClient = MockHttpClient();
      localCounterApi = LocalCounterApi(httpClient);
    });
    setUpAll(() {
      registerFallbackValue(Uri());
    });

    test('getCount returns count from server', () async {
      final responseBody = jsonEncode({'count': 42});
      when(() => httpClient.get(any()))
          .thenAnswer((_) async => http.Response(responseBody, 200));

      final count = await localCounterApi.getCount();

      expect(count, equals(const CounterEntity(count: 42)));
      verify(() => httpClient.get(urlApiCount)).called(1);
    });

    test('getCount throws exception for non-200 status code', () async {
      when(() => httpClient.get(any()))
          .thenAnswer((_) async => http.Response('', 404));

      expect(() async => await localCounterApi.getCount(),
          throwsA(isA<CounterApiError>()));
      verify(() => httpClient.get(urlApiCount)).called(1);
    });

    test('getCount throws exception for invalid JSON response', () async {
      when(() => httpClient.get(any()))
          .thenAnswer((_) async => http.Response('invalid json', 200));

      expect(() async => await localCounterApi.getCount(),
          throwsA(isA<CounterApiError>()));
      verify(() => httpClient.get(urlApiCount)).called(1);
    });

    test('getCount throws exception for missing count field', () async {
      final responseBody = jsonEncode({'foo': 'bar'});
      when(() => httpClient.get(any()))
          .thenAnswer((_) async => http.Response(responseBody, 200));

      expect(() async => await localCounterApi.getCount(),
          throwsA(isA<CounterApiError>()));
      verify(() => httpClient.get(urlApiCount)).called(1);
    });

    test('getCount throws exception for non-integer count field', () async {
      final responseBody = jsonEncode({'count': 'foo'});
      when(() => httpClient.get(any()))
          .thenAnswer((_) async => http.Response(responseBody, 200));

      expect(() async => await localCounterApi.getCount(),
          throwsA(isA<CounterApiError>()));
      verify(() => httpClient.get(urlApiCount)).called(1);
    });

    test('getCount throws exception for network error', () async {
      when(() => httpClient.get(any())).thenThrow(Exception('Network error'));

      expect(() async => await localCounterApi.getCount(),
          throwsA(isA<CounterApiError>()));
      verify(() => httpClient.get(urlApiCount)).called(1);
    });

    test('getAllCounts returns 2 items counts from server', () async {
      final responseBody = jsonEncode([
        {'count': 42},
        {'count': 99}
      ]);
      when(() => httpClient.get(any()))
          .thenAnswer((_) async => http.Response(responseBody, 200));

      final counts = await localCounterApi.getAllCounts();

      expect(
        counts,
        equals(
          const [
            CounterEntity(count: 42),
            CounterEntity(count: 99),
          ],
        ),
      );
      verify(() => httpClient.get(urlApiCounts)).called(1);
    });

    test('getAllCounts returns 20 items counts from server', () async {
      final responseBody = jsonEncode([
        {"count": 1},
        {"count": 2},
        {"count": 3},
        {"count": 4},
        {"count": 5},
        {"count": 6},
        {"count": 7},
        {"count": 8},
        {"count": 9},
        {"count": 10},
        {"count": 11},
        {"count": 12},
        {"count": 13},
        {"count": 14},
        {"count": 15},
        {"count": 16},
        {"count": 17},
        {"count": 18},
        {"count": 19},
        {"count": 20}
      ]);

      when(() => httpClient.get(any()))
          .thenAnswer((_) async => http.Response(responseBody, 200));

      final counts = await localCounterApi.getAllCounts();

      expect(
          counts,
          equals(
            const [
              CounterEntity(count: 1),
              CounterEntity(count: 2),
              CounterEntity(count: 3),
              CounterEntity(count: 4),
              CounterEntity(count: 5),
              CounterEntity(count: 6),
              CounterEntity(count: 7),
              CounterEntity(count: 8),
              CounterEntity(count: 9),
              CounterEntity(count: 10),
              CounterEntity(count: 11),
              CounterEntity(count: 12),
              CounterEntity(count: 13),
              CounterEntity(count: 14),
              CounterEntity(count: 15),
              CounterEntity(count: 16),
              CounterEntity(count: 17),
              CounterEntity(count: 18),
              CounterEntity(count: 19),
              CounterEntity(count: 20),
            ],
          ));
      verify(() => httpClient.get(urlApiCounts)).called(1);
    });

    test('getAllCounts throws exception for non-200 status code', () async {
      when(() => httpClient.get(any()))
          .thenAnswer((_) async => http.Response('', 404));

      expect(() async => await localCounterApi.getAllCounts(),
          throwsA(isA<CounterApiError>()));
      verify(() => httpClient.get(urlApiCounts)).called(1);
    });

    test('getAllCounts throws exception for invalid JSON response', () async {
      when(() => httpClient.get(any()))
          .thenAnswer((_) async => http.Response('invalid json', 200));

      expect(() async => await localCounterApi.getAllCounts(),
          throwsA(isA<FormatException>()));
      verify(() => httpClient.get(urlApiCounts)).called(1);
    });

    test('getAllCounts throws exception for missing count field', () async {
      final responseBody = jsonEncode([
        {'foo': 'bar'}
      ]);
      when(() => httpClient.get(any()))
          .thenAnswer((_) async => http.Response(responseBody, 200));

      expect(() async => await localCounterApi.getAllCounts(),
          throwsA(isA<InvalidJSONResponseException>()));
      verify(() => httpClient.get(urlApiCounts)).called(1);
    });

    test('getAllCounts throws exception for non-integer count field', () async {
      final responseBody = jsonEncode([
        {'count': 'foo'}
      ]);
      when(() => httpClient.get(any()))
          .thenAnswer((_) async => http.Response(responseBody, 200));

      expect(
        () async => await localCounterApi.getAllCounts(),
        throwsA(isA<FormatException>()),
      );
      verify(() => httpClient.get(urlApiCounts)).called(1);
    });

    test('getAllCounts throws exception for network error', () async {
      when(() => httpClient.get(any()))
          .thenThrow(CounterApiError('Network error'));

      expect(
        () async => await localCounterApi.getAllCounts(),
        throwsA(isA<CounterApiError>()),
      );
      verify(() => httpClient.get(urlApiCounts)).called(1);
    });
  });
}
