import 'dart:convert';

import '../../../../../core/core.dart';
import '../../../domain/domain.dart';

/// Model class for [LocalCounterModel]
///
/// * [count] is the number of times the counter
class LocalCounterModel extends CounterEntity {
  const LocalCounterModel({required super.count});

  factory LocalCounterModel.fromEntity(CounterEntity entity) =>
      LocalCounterModel(count: entity.count);

  factory LocalCounterModel.fromJson(String sourceJson) {
    final Map<String, dynamic> counterJson = json.decode(sourceJson);
    return LocalCounterModel.fromMap(counterJson);
  }

  factory LocalCounterModel.fromMap(Map<String, dynamic> json) {
    // var abc = !json.containsKey(<String>['count']);
    if (!json.keys.toSet().containsAll(<String>['count'])) {
      throw HttpStatus4xxErrorClient.unprocessableEntity_422.exception(
        data: json,
        detail: "Not found key 'count' in JSON",
      );
    }

    late int count;

    try {
      count = json['count'].toInt();
    } catch (_) {
      // From String of JSON to Int
      count = int.parse(json['count']);
    }

    return LocalCounterModel(count: count);
  }

  @override
  String toString() => 'LocalCounterModel(count: $count)';

  Map<String, dynamic> toMap() => <String, dynamic>{'count': count};

  String toJson() => json.encode(toMap());

  CounterEntity toEntity() => CounterEntity(count: count);
}
