import 'dart:convert';

import 'package:http/http.dart' show Client, Response;

import '../../constants/string_constants.dart';

class NetworkUtility {
  final Client client = Client();

  Future<Response> post(
    Uri uri, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    try {
      final response = await client.post(uri, headers: headers, body: body);
      _validateResponse(response);
      return response;
    } catch (e) {
      throw Exception('Error en POST request: $e');
    }
  }

  Future<Response> postJson(
    Uri uri, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    final jsonHeaders = {'Content-Type': 'application/json', ...?headers};

    final jsonBody = body != null ? jsonEncode(body) : null;

    return post(uri, headers: jsonHeaders, body: jsonBody);
  }

  void _validateResponse(Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        '${StringConstants.errorFetchingDataHttp} ${response.statusCode} - ${response.reasonPhrase}',
      );
    }
  }

  void dispose() {
    client.close();
  }
}
