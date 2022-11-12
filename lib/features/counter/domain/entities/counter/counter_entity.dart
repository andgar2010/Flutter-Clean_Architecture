import 'package:equatable/equatable.dart';

export 'gateway/counter_gateway.dart';


/// Entry class for [CounterEntity]
///
/// * [count] is the number of times the counter
class CounterEntity extends Equatable {
  const CounterEntity({required this.count});

  /// [count] is the number of times the counter
  final int count;

  @override
  List get props => [count];

  @override
  String toString() => 'CounterEntity(count: $count)';

  CounterEntity copyWith({int? count}) =>
      CounterEntity(count: count ?? this.count);
}
