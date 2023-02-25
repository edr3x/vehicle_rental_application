import "package:http/http.dart" as http;
import 'package:rental_system_app/api/api.dart';

import "../../utils/http_error_handler.dart";

class SendCodeService {
  Future<dynamic> data({required int phoneNumber}) async {
    http.Client client = http.Client();

    final Uri url = Uri.parse("$api/sendcode");
    try {
      final http.Response response = await client.post(url, body: {});

      if (response.statusCode != 201) {
        throw Exception(httpErrorHandler(response));
      }
    } catch (e) {
      rethrow;
    }
  }
}
