import 'package:clean_architecture_counter/core/data/http/http_error.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('toMap', () {
    const InvalidJSONResponseException invalidJSONResponse =
        InvalidJSONResponseException(
      missingKeys: ['keyTest'],
      data: <String, dynamic>{'foo': 'foo value', 'bar': 'bar value'},
    );

    final Map<String, dynamic> map = invalidJSONResponse.toMap();

    expect(map.length, 5);
    expect(map['missingKeys'], ['keyTest']);
    expect(map['message'], contains('Invalid JSON response - Key not found ='));
    expect(map['foo'], 'foo value');
    expect(map['bar'], 'bar value');
    expect(map['uri'], null);
  });

  test('toMap with null as data', () {
    const InvalidJSONResponseException invalidJSONResponse =
        InvalidJSONResponseException(
      missingKeys: ['keyTest'],
      data: null,
    );

    final map = invalidJSONResponse.toMap();

    expect(map.length, 3);
    expect(map['message'], contains('Invalid JSON response - Key not found ='));
    expect(map['missingKeys'], ['keyTest']);
    expect(map['uri'], null);
  });
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
          contains(
              "Invalid JSON response - Key not found = ['count']; Current HTTP data = {abc: xyz}"));
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
