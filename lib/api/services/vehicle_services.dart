import "dart:convert";

import "package:http/http.dart" as http;
import 'package:rental_system_app/api/api.dart';
import "package:rental_system_app/api/models/vehicle/my_vehicles_model.dart";
import "package:rental_system_app/utils/shared_preferences.dart";

import "../../utils/http_error_handler.dart";
import "../models/vehicle/vehicle_near_me_model.dart";
import "../models/vehicle/vehicle_details_model.dart";

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

class GetVehicleDetailsService {
  Future<VehicleDetailsModel> data({
    required String vehicleId,
  }) async {
    http.Client client = http.Client();

    String token = await UtilSharedPreferences.getToken();

    final Uri url = Uri.parse("$api/vehicle/$vehicleId");

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

      return vehicleDetailsModelFromJson(response.body);
    } catch (e) {
      rethrow;
    }
  }
}

class MyVehiclesService {
  Future<MyVehiclesModel> data() async {
    http.Client client = http.Client();

    String token = await UtilSharedPreferences.getToken();

    final Uri url = Uri.parse("$api/vehicle/self");
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

      return myVehiclesModelFromJson(response.body);
    } catch (e) {
      rethrow;
    }
  }
}
