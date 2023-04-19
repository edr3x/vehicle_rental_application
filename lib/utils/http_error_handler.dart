import 'dart:convert';

import 'package:http/http.dart' as http;

String httpErrorHandler(http.Response response) {
  final statusCode = response.statusCode;
  final errorResponse = jsonDecode(response.body);

  final String errorMessage =
      'Request failed\n Status Code: $statusCode\n Reason: ${errorResponse["message"]}';

  return errorMessage;
}
