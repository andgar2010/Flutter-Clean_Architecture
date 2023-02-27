import 'dart:convert';

import 'package:clean_architecture_counter/core/core.dart';
import 'package:clean_architecture_counter/features/counter/domain/domain.dart';
import 'package:clean_architecture_counter/features/counter/infrastructure/driven_adapter/api/counter_api/counter_api.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock.dart';

void main() {
  group('Infrastructure - Remote Counter Api', () {
    late http.Client httpClient;
    late RemoteCounterApi remoteCounterApi;

    final Uri urlApiCount = Uri.parse('${RemoteCounterApi.url}/products/1');
    final Uri urlApiCounts = Uri.parse(RemoteCounterApi.url);

    setUp(() {
      httpClient = MockHttpClient();
      remoteCounterApi = RemoteCounterApi(httpClient);
    });
    setUpAll(() {
      registerFallbackValue(Uri());
    });

    test('getCount returns count from server', () async {
      final responseBody = jsonEncode({'id': 42});
      when(() => httpClient.get(any())).thenAnswer(
          (_) async => http.Response(responseBody, 200, reasonPhrase: 'OK'));

      final count = await remoteCounterApi.getCount();

      expect(count, equals(const CounterEntity(count: 42)));
      verify(() => httpClient.get(urlApiCount)).called(1);
    });

    test('getCount throws exception for non-200 status code', () async {
      when(() => httpClient.get(any()))
          .thenAnswer((_) async => http.Response('', 404));

      expect(() async => await remoteCounterApi.getCount(),
          throwsA(isA<CounterApiError>()));
      verify(() => httpClient.get(urlApiCount)).called(1);
    });

    test('getCount throws exception for invalid JSON response', () async {
      when(() => httpClient.get(any())).thenAnswer(
          (_) async => http.Response('invalid json', 200, reasonPhrase: 'OK'));

      expect(() async => await remoteCounterApi.getCount(),
          throwsA(isA<CounterApiError>()));
      verify(() => httpClient.get(urlApiCount)).called(1);
    });

    test('getCount throws exception for missing count field', () async {
      final responseBody = jsonEncode({'foo': 'bar'});
      when(() => httpClient.get(any())).thenAnswer(
          (_) async => http.Response(responseBody, 200, reasonPhrase: 'OK'));

      expect(() async => await remoteCounterApi.getCount(),
          throwsA(isA<CounterApiError>()));
      verify(() => httpClient.get(urlApiCount)).called(1);
    });

    test('getCount throws exception for non-integer count field', () async {
      final responseBody = jsonEncode({'id': 'foo'});
      when(() => httpClient.get(any())).thenAnswer(
          (_) async => http.Response(responseBody, 200, reasonPhrase: 'OK'));

      expect(() async => await remoteCounterApi.getCount(),
          throwsA(isA<CounterApiError>()));
      verify(() => httpClient.get(urlApiCount)).called(1);
    });

    test('getCount throws exception for network error', () async {
      when(() => httpClient.get(any())).thenThrow(Exception('Network error'));

      expect(() async => await remoteCounterApi.getCount(),
          throwsA(isA<CounterApiError>()));
      verify(() => httpClient.get(urlApiCount)).called(1);
    });

    test('getAllCounts returns 2 items counts from server', () async {
      final responseBody = jsonEncode([
        {'id': 42},
        {'id': 99}
      ]);
      when(() => httpClient.get(any())).thenAnswer(
          (_) async => http.Response(responseBody, 200, reasonPhrase: 'OK'));

      final counts = await remoteCounterApi.getAllCounts();

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
        {"id": 1},
        {"id": 2},
        {"id": 3},
        {"id": 4},
        {"id": 5},
        {"id": 6},
        {"id": 7},
        {"id": 8},
        {"id": 9},
        {"id": 10},
        {"id": 11},
        {"id": 12},
        {"id": 13},
        {"id": 14},
        {"id": 15},
        {"id": 16},
        {"id": 17},
        {"id": 18},
        {"id": 19},
        {"id": 20}
      ]);

      when(() => httpClient.get(any())).thenAnswer(
          (_) async => http.Response(responseBody, 200, reasonPhrase: 'OK'));

      final counts = await remoteCounterApi.getAllCounts();

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

      expect(() async => await remoteCounterApi.getAllCounts(),
          throwsA(isA<CounterApiError>()));
      verify(() => httpClient.get(urlApiCounts)).called(1);
    });

    test('getAllCounts throws exception for invalid JSON response', () async {
      when(() => httpClient.get(any())).thenAnswer(
          (_) async => http.Response('invalid json', 200, reasonPhrase: 'OK'));

      expect(() async => await remoteCounterApi.getAllCounts(),
          throwsA(isA<FormatException>()));
      verify(() => httpClient.get(urlApiCounts)).called(1);
    });

    test('getAllCounts throws exception for missing count field', () async {
      final responseBody = jsonEncode([
        {'foo': 'bar'}
      ]);
      when(() => httpClient.get(any())).thenAnswer(
          (_) async => http.Response(responseBody, 200, reasonPhrase: 'OK'));

      expect(() async => await remoteCounterApi.getAllCounts(),
          throwsA(isA<InvalidJSONResponseException>()));
      verify(() => httpClient.get(urlApiCounts)).called(1);
    });

    test('getAllCounts throws exception for non-integer count field', () async {
      final responseBody = jsonEncode([
        {'id': 'foo'}
      ]);
      when(() => httpClient.get(any())).thenAnswer(
          (_) async => http.Response(responseBody, 200, reasonPhrase: 'OK'));

      expect(
        () async => await remoteCounterApi.getAllCounts(),
        throwsA(isA<FormatException>()),
      );
      verify(() => httpClient.get(urlApiCounts)).called(1);
    });

    test('getAllCounts throws exception for network error', () async {
      when(() => httpClient.get(any()))
          .thenThrow(CounterApiError('Network error'));

      expect(
        () async => await remoteCounterApi.getAllCounts(),
        throwsA(isA<CounterApiError>()),
      );
      verify(() => httpClient.get(urlApiCounts)).called(1);
    });
  });
}
