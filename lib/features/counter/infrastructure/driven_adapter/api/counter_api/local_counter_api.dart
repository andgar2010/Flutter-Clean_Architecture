import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../data/data.dart';
import '../../../../domain/domain.dart';
import 'errors/counter_api_error.dart';

class LocalCounterApi extends CounterGateway {
  LocalCounterApi(this.client);

  static const url = 'https://counter.free.beeceptor.com';

  final http.Client client;

  @override
  Future<List<CounterEntity>> getAllCounts() async {
    final Uri url = Uri.parse('${LocalCounterApi.url}/counts');

    try {
      final http.Response response = await client.get(url);
      if (response.statusCode != 200) {
        throw CounterApiError(
            'Network error: Failed to get count: HTTP ${response.statusCode}');
      }
      final List countersJson = json.decode(response.body);
      final List<CounterEntity> countsEntities = [];
      for (final Map<String, dynamic> counterJson in countersJson) {
        countsEntities.add(LocalCounterModel.fromMap(counterJson).toEntity());
      }
      return countsEntities;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CounterEntity> getCount() async {
    final Uri url = Uri.parse(LocalCounterApi.url);

    try {
      final http.Response response = await client.get(url);
      if (response.statusCode != 200) {
        throw CounterApiError(
            'Failed to get count: HTTP ${response.statusCode}');
      }
      final LocalCounterModel counterDataLocal =
          LocalCounterModel.fromJson(response.body);
      final CounterEntity countEntity = counterDataLocal.toEntity();
      return countEntity;
    } catch (e) {
      throw CounterApiError('Failed to get count: $e');
    }
  }

// incrementCounter
}
