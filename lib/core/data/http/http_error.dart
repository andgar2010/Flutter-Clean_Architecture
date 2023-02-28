export 'package:http_exception/http_exception.dart';

/// A bas class for specific Format Data Http exception classes.
/// [data] data can be provided to add additional information as the response
/// body.
class InvalidJSONResponseException extends FormatException {
  const InvalidJSONResponseException({
    required this.missingKeys,
    this.data,
    this.uri,
  });

  final List<String> missingKeys;
  final Map<String, dynamic>? data;
  final Uri? uri;

  @override
  String toString() {
    final b = StringBuffer()
      ..write('Invalid JSON response - Key not found = ')
      ..write('[');

    for (int i = 0; i < missingKeys.length; i++) {
      String key = missingKeys[i];
      b.write("'$key'");
      b.write(i == (missingKeys.length - 1) ? ']; ' : ",");
    }

    b.write(uri != null ? 'uri = $uri, ' : '');

    if (data != null) {
      b.write('Current HTTP data = $data');
    }
    return b.toString();
  }
}
