import '../counter_entity.dart';
import '../entities.dart';

abstract class CounterGateway {
  Future<CounterEntity> getCount();

  Future<List<CounterEntity>> getAllCounts();
}
