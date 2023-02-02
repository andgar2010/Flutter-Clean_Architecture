import 'package:clean_architecture_counter/features/counter/counter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Infrastructure - Driven Adapter - API - Error', () {
    Never throwError() {
      throw CounterApiError();
    }

    test('should throw CounterApiError with message', () {
      expect(throwError, throwsException);
      expect(throwError, throwsA(isA<CounterApiError>()));
      expect(
        throwError,
        throwsA(
          isA<CounterApiError>().having(
            (CounterApiError x) => x.toString(),
            'message',
            contains("Error al obtener valor de un counter"),
          ),
        ),
      );
      expect(
        throwError,
        throwsA(
          predicate((Object? x) {
            return x is CounterApiError &&
                x.toString() == "Error al obtener valor de un counter";
          }),
        ),
      );
    });
  });
}
