import 'package:flutter/material.dart';

import '../../domain/usecases/usecases.dart';

class CounterProvider extends ChangeNotifier {
  CounterProvider({required this.counterUseCase});

  final CounterUseCase counterUseCase;
}
