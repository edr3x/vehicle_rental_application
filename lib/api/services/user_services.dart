import "dart:convert";

import "package:http/http.dart" as http;
import 'package:rental_system_app/api/api.dart';
import "package:rental_system_app/api/models/user/get_user_data_model.dart";
import "package:rental_system_app/utils/shared_preferences.dart";

import "../../utils/http_error_handler.dart";
import "../models/user/update_basic_details_model.dart";

class GetUserDataService {
  Future<GetUserDataModel> data() async {
    http.Client client = http.Client();

    String token = await UtilSharedPreferences.getToken();

    final Uri url = Uri.parse("$api/user/profile");
    try {
      final http.Response response = await client.get(
        url,
        headers: {
          ...apiHeader,
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }

      return getUserDataModelFromJson(response.body);
    } catch (e) {
      rethrow;
    }
  }
}

class UpdateBasicUserDetailsService {
  Future<UpdateBasicUserDetailsModel> data({
    required String fullName,
    required String gender, //note: "male" | "female" | "other"
    required String email,
  }) async {
    http.Client client = http.Client();

    String token = await UtilSharedPreferences.getToken();

    final Uri url = Uri.parse("$api/user/profile");
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

class UpdateUserAddressService {
  Future<dynamic> data({
    required String province,
    required String district,
    required String municipality,
    required String city,
    required String street,
  }) async {}
}
