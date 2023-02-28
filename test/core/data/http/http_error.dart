import 'package:clean_architecture_counter/core/data/http/http_error.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('check throw InvalidJSONResponseException', () {
    try {
      final json = <String, String>{'abc': 'xyz'};
      if (!json.keys.toSet().containsAll(<String>['count'])) {
        throw InvalidJSONResponseException(
          data: json,
          missingKeys: ['count'],
        );
      }
    } on InvalidJSONResponseException catch (e) {
      expect(
          e.toString(),
          contains("Invalid JSON response - Key not found = ['count']; "
              "Current HTTP data = {abc: xyz}"));
      expect(e.data, {'abc': 'xyz'});
      expect(e.missingKeys, ['count']);
    }
  });

  test('check throw InvalidJSONResponseException values JSON', () {
    const object = Object();
    try {
      final json = <String, Object?>{
        'abc': 'xyz',
        'abc123': 'xyz987',
        'zyx': 1,
        'cde': true,
        'feg': null,
        'countB': object,
      };

      if (!json.keys.toSet().containsAll(<String>['countA', 'countB'])) {
        throw InvalidJSONResponseException(
          data: json,
          missingKeys: ['countA', 'countB'],
          uri: Uri.parse('http://localhost'),
        );
      }
    } on InvalidJSONResponseException catch (e) {
      expect(
        e.toString(),
        contains(
          "Invalid JSON response - Key not found = ['countA','countB']; "
          "uri = http://localhost, Current HTTP data = {abc: xyz, "
          "abc123: xyz987, zyx: 1, cde: true, feg: null, "
          "countB: Instance of 'Object'}",
        ),
      );
      expect(
        e.data,
        {
          'abc': 'xyz',
          'abc123': 'xyz987',
          'zyx': 1,
          'cde': true,
          'feg': null,
          'countB': object,
        },
      );
      expect(e.missingKeys, ['countA', 'countB']);
      expect(e.uri, Uri.parse('http://localhost'));
    }
  });
}
