import 'package:clean_architecture_counter/features/counter/presentation/pages/counter_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

MultiProvider baseApp({required List<ChangeNotifierProvider> providers}) {
  return MultiProvider(
    providers: providers,
    child: const MaterialApp(
      home: CounterPage(title: 'Test Counter Page'),
    ),
  );
}
