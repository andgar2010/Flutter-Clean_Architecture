import 'dart:async';

import '../entities/counter_entity.dart';

// import '../entities/entities.dart';

abstract class LoadCurrentCounter {
  Future<CounterEntity?> load();
}
