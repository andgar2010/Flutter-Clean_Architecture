class CounterApiError implements Exception {
  // ignore: prefer_typing_uninitialized_variables
  final e;

  CounterApiError([this.e = "Error al obtener valor de un counter"]);
  @override
  toString() => e.toString(); // Error getting value from a counter
}
