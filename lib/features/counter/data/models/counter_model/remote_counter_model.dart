import 'dart:convert';

import '../../../domain/entities/counter_entity.dart';
import '../../../../../core/data/http/http_error.dart';

/// Model class for [RemoteCounterModel]
///
/// * [count] is the number of times the counter
class RemoteCounterModel extends CounterEntity {
  const RemoteCounterModel({required this.countA, required this.countB})
      : super(count: countA);

  factory RemoteCounterModel.fromEntity(CounterEntity entity) =>
      RemoteCounterModel(countA: entity.count, countB: 0);

  factory RemoteCounterModel.fromJson(String source) {
    final Map<String, dynamic> counterJson = json.decode(source);
    return RemoteCounterModel.fromMap(counterJson);
  }

  factory RemoteCounterModel.fromMap(Map<String, dynamic> json) {
    if (!json.keys.toSet().containsAll(<String>['countA', 'countB'])) {
      throw HttpStatus4xxErrorClient.unprocessableEntity_422.exception(
        data: json,
        detail: "Not found key 'countA' and 'countB' in JSON",
      );
    }

    late int countA;
    late int countB;

    try {
      countA = json['countA'].toInt();
    } catch (_) {
      countA = int.parse(json['countA']);
    }

    try {
      countB = json['countB'].toInt();
    } catch (_) {
      countB = int.parse(json['countB']);
    }

    return RemoteCounterModel(
      countA: countA,
      countB: countB,
    );
  }

  /// [countA] is the number of times the counterA
  final int countA;

  /// [countB] is the number of times the counterB
  final int countB;

  @override
  String toString() => 'RemoteCounterModel(countA: $countA, countB: $countB)';

  Map<String, dynamic> toMap() {
    return {
      'countA': countA,
      'countB': countB,
    };
  }

  String toJson() => json.encode(toMap());

  CounterEntity toEntity() => CounterEntity(count: countA);
}
