import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:http_exception/http_exception.dart';

/// Entry class for [Counter]
///
/// * [count] is the number of times the counter
class Counter extends Equatable {
  const Counter({
    required this.count,
  });

  factory Counter.fromJson(String source) {
    final Map<String, dynamic> counterJson = json.decode(source);
    return Counter.fromMap(counterJson);
  }

  factory Counter.fromMap(Map<String, dynamic> json) {
    if (!json.containsKey(<String>['count'])) {
      throw HttpStatus4xxErrorClient.unprocessableEntity.exception(
        data: json,
        detail: 'Not found key "count" in JSON',
      );
    }
    // if (!json.keys.toSet().containsAll(<String>['countA', 'countB'])) {
    //   throw Exception('Not found key "countA" or "countB" in JSON');
    // }

    return Counter(
      count: json['count'].toInt(),
      // count: int.parse(json['count']),
    );
  }

  /// [count] is the number of times the counter
  final int count;

  @override
  List<Object> get props => [count];

  @override
  String toString() => 'Counter(count: $count)';

  Counter copyWith({int? count}) {
    return Counter(
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'count': count,
    };
  }

  String toJson() => json.encode(toMap());
}
