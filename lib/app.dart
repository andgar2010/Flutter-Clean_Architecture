import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'features/counter/counter.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = const Color(0xff2196f3);
    HSLColor hslColor = HSLColor.fromColor(primaryColor);
    HSLColor darkerColor =
        hslColor.withLightness((hslColor.lightness - 0.1).clamp(0.0, 1.0));
    // ignore: unused_local_variable
    Color darkPrimaryColor = darkerColor.toColor();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CounterProvider(
            counterUseCase: CounterUseCase(RemoteCounterApi(http.Client())),
          ),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        darkTheme: ThemeData.dark(
          useMaterial3: true,

          // primaryColor: darkPrimaryColor,
          // iconTheme: IconThemeData(color: Colors.black),
          // primarySwatch: Colors.blue,
        ).copyWith(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: darkPrimaryColor,
            foregroundColor: Colors.white70,
          ),
        ),
        theme: ThemeData(
          useMaterial3: true,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            // backgroundColor: darkPrimaryColor,
            foregroundColor: Colors.white,
            backgroundColor: darkPrimaryColor,
          ),
          // primarySwatch: Colors.red,
        ),
        home: const CounterPage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
