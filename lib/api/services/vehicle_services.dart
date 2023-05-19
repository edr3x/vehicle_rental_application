import "dart:convert";
import "dart:io";

import "package:http/http.dart" as http;
import 'package:rental_system_app/api/api.dart';
import "package:rental_system_app/api/models/vehicle/add_vehicle_response_model.dart";
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

class AddVehicleService {
  Future<AddVehicleResponseModel> data({
    required String imageFile,
    required String title,
    required String category,
  }) async {
    http.Client client = http.Client();

    String token = await UtilSharedPreferences.getToken();

    final Uri url = Uri.parse("$api/vehicle");
    try {
      http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse("$api/upload"));
      request.files.add(await http.MultipartFile.fromPath("image", imageFile));
      request.headers.addAll({
        "Content-Type": "multipart/form-data",
        'Authorization': 'Bearer $token',
      });
      http.StreamedResponse res = await request.send();
      if (res.statusCode != 201) {
        print("Got BIGGGGGGG ERROR ON UPLOADING IMAGE");
      }
      String responseString = await res.stream.bytesToString();
      String uploadedImage = jsonDecode(responseString)["data"] as String;

      final http.Response response = await client.post(
        url,
        headers: {
          ...apiHeader,
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "title": title,
          "category": category,
          "type": "electric",
          "subCategoryId": "cee914e3-0c2d-4284-9bda-0f5f8765fefc",
          "brandId": "bfb48a75-cd07-4e8c-b5c3-1f373f906acd",
          "model": "27785",
          "thumbnail": uploadedImage,
          "vehicleNumber": "Ba-2-Pa-2356",
          "description": "hello there this is another vehicle",
          "rentGuidelines": "drive with care",
          "rate": "2000/day",
          "pickupAddress": ["10.287422", "9.2542368"],
          "driveTrain": "rearWheel",
          "features": {
            "color": "white",
            "noOfSeats": 2,
            "noOfDoors": 0,
            "hasAC": false,
            "hasABS": false,
            "hasAirbag": false,
            "hasSunRoof": false,
            "hasPowerSteering": false,
            "hasUSBPort": false,
            "hasBluetooth": false,
            "hasKeylessEntry": true,
            "hasHeatedSeats": false,
            "hasBackCamera": false,
            "hasParkingSensors": false,
            "hasAutoDrive": false,
            "transmission": "automatic",
            "gClearance": 5,
            "fuelTank": 1
          }
        }),
      );

      if (response.statusCode != 201) {
        throw Exception(httpErrorHandler(response));
      }

      return addVehicleResponseModelFromJson(response.body);
    } catch (e) {
      rethrow;
    }
  }
}
