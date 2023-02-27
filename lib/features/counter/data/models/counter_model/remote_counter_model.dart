import 'dart:convert';

import '../../../domain/entities/counter_entity.dart';
import '../../../../../core/data/http/http_error.dart';

/// Model class for [RemoteCounterModel]
///
/// * [id] is the number of times the counter
class RemoteCounterModel extends CounterEntity {
  const RemoteCounterModel({required this.id}) : super(count: id);

  factory RemoteCounterModel.fromEntity(CounterEntity entity) =>
      RemoteCounterModel(id: entity.count);

  factory RemoteCounterModel.fromJson(String source) {
    final Map<String, dynamic> counterJson = json.decode(source);
    return RemoteCounterModel.fromMap(counterJson);
  }

  factory RemoteCounterModel.fromMap(Map<String, dynamic> json) {
    if (!json.keys.toSet().containsAll(<String>['id'])) {
      throw InvalidJSONResponseException(
        data: json,
        missingKeys: ['id'],
      );
    }

    late int id;

    try {
      id = json['id'].toInt();
    } catch (_) {
      id = int.parse(json['id']);
    }

    return RemoteCounterModel(id: id);
  }

  /// [id] is the number of times the counterId
  final int id;

  @override
  String toString() => 'RemoteCounterModel(id: $id)';

  Map<String, dynamic> toMap() => {'id': id};

  String toJson() => json.encode(toMap());

  CounterEntity toEntity() => CounterEntity(count: id);
}
