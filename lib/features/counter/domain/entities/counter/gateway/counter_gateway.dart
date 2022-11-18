import '../../entities.dart';
import '../counter_entity.dart';

abstract class CounterGateway {
  Future<CounterEntity> getCount();
  Future<List<CounterEntity>> getAllCounts();
}
