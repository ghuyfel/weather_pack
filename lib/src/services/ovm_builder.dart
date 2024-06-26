import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../api/api_exception.dart';

/// The class is intended for single http requests and subsequent error handling.
class OWMBuilder {
  OWMBuilder([http.Client? client]) : _client = client ?? http.Client();

  final http.Client _client;

  static const int _statusOk = 200;

  /// Make a service request and get a response-data from the service OWM.
  ///
  /// Also handles errors.
  Future<T> getData<T>({
    required Uri uri,
    required T Function(dynamic data) builder,
  }) async {
    try {
      final http.Response response = await _client.get(uri);

      switch (response.statusCode) {
        case _statusOk:
          return builder(json.decode(response.body));
        default:
          throw OwmApiException(response.statusCode, response.body);
      }
    } catch (error, stackTrace) {
      throw OwmApiException(0, error.toString() + stackTrace.toString());
    }
  }
}
