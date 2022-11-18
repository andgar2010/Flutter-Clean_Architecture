import '../../../domain/entities/entities.dart';
import '../../../../../core/domain/helpers/domain_error.dart';
import '../../../domain/usecases/usecases.dart';

class LocalLoadCurrentCounter implements LoadCurrentCounter {
  // ignore: prefer_typing_uninitialized_variables
  final /*FetchSecureCacheStorage*/ fetchSecureCacheStorage;

  LocalLoadCurrentCounter({required this.fetchSecureCacheStorage});

  @override
  Future<CounterEntity> load() async {
    CounterEntity? counterEntity;

    try {
      final int? count = await fetchSecureCacheStorage.fetch('counter');
      if (count == null) throw Error();
      counterEntity = CounterEntity(count: count);
      return counterEntity;
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
