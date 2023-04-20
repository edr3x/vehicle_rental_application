import "dart:convert";

import "package:http/http.dart" as http;
import 'package:rental_system_app/api/api.dart';
import "package:rental_system_app/utils/shared_preferences.dart";

import "../../utils/http_error_handler.dart";
import "../models/user/update_basic_details_model.dart";

class UpdateBasicUserDetailsService {
  Future<UpdateBasicUserDetailsModel> data({
    required String fullName,
    required String gender, //note: "male" | "female" | "other"
    required String email,
  }) async {
    http.Client client = http.Client();

    String token = await UtilSharedPreferences.getToken();

    final Uri url = Uri.parse("$api/auth/sendotp");
    try {
      final http.Response response = await client.patch(
        url,
        body: jsonEncode({
          "fullName": fullName,
          "gender": gender,
          "email": email,
        }),
        headers: {
          ...apiHeader,
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 201) {
        throw Exception(httpErrorHandler(response));
      }

      return updateBasicUserDetailsModelFromJson(response.body);
    } catch (e) {
      rethrow;
    }
  }
}
