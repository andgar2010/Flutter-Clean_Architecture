import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../../data/data.dart';
import '../../../../domain/domain.dart';
import 'errors/counter_api_error.dart';

class RemoteCounterApi extends CounterGateway {
  RemoteCounterApi(this.client);

  final http.Client client;

  static const url = 'https://fakestoreapi.com/products';

  @override
  Future<CounterEntity> getCount() async {
    final Uri url = Uri.parse('${RemoteCounterApi.url}/products/1');

    try {
      final http.Response response = await client.get(url);
      if (response.reasonPhrase != 'OK') {
        throw CounterApiError(
            'Failed to get count: HTTP ${response.statusCode}');
      }

      final RemoteCounterModel counterDataRemote =
          RemoteCounterModel.fromJson(response.body);
      final CounterEntity countEntity = counterDataRemote.toEntity();
      return countEntity;
    } catch (e) {
      throw CounterApiError('Failed to get count: $e');
    }
  }

  @override
  Future<List<CounterEntity>> getAllCounts() async {
    Uri url = Uri.parse(RemoteCounterApi.url);

    try {
      final http.Response response = await client.get(url);
      if (response.reasonPhrase != 'OK') {
        throw CounterApiError(
            'Network error: Failed to get count: HTTP ${response.statusCode}');
      }

      final List countersJson = json.decode(response.body);
      final List<CounterEntity> countsEntities =
          countersJson.map((counterJson) {
        assert(counterJson != null);
        final CounterEntity countEntity =
            RemoteCounterModel.fromMap(counterJson).toEntity();
        return countEntity;
      }).toList();
      return countsEntities;
    } catch (e) {
      rethrow;
    }
  }
}
