import "dart:convert";

import "package:http/http.dart" as http;
import 'package:rental_system_app/api/api.dart';
import "package:rental_system_app/utils/shared_preferences.dart";

import "../../utils/http_error_handler.dart";
import "../models/vehicle/vehicle_near_me_model.dart";

class GetNearbyVehicleService {
  Future<VehicleNearMeModel> data({
    required String lat,
    required String lon,
    required String category,
  }) async {
    http.Client client = http.Client();

    String token = await UtilSharedPreferences.getToken();

    final Uri url = Uri.parse("$api/vehicle/nearme");

    try {
      final http.Response response = await client.post(
        url,
        body: jsonEncode({
          "lat": lat,
          "lon": lon,
          "category": category,
        }),
        headers: {
          ...apiHeader,
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }

      return vehicleNearMeModelFromJson(response.body);
    } catch (e) {
      rethrow;
    }
  }
}
