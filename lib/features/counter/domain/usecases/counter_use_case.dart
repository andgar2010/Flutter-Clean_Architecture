import '../entities/entities.dart';

class CounterUseCase {
  CounterUseCase(this._counterGateway);

  final CounterGateway _counterGateway;

  Future<CounterEntity> getCounter() {
    return _counterGateway.getCount();
  }

  Future<List<CounterEntity>> getAllCounts() {
    return _counterGateway.getAllCounts();
  }
}
