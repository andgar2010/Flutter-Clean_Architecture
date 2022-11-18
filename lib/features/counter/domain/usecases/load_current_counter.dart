import 'dart:async';

import '../entities/entities.dart';

abstract class LoadCurrentCounter {
  Future<CounterEntity?> load();
}
