import "dart:convert";

import "package:http/http.dart" as http;
import 'package:rental_system_app/api/api.dart';
import "package:rental_system_app/api/models/vehicle/add_vehicle_response_model.dart";
import "package:rental_system_app/api/models/vehicle/bookings_per_vehicle_model.dart";
import "package:rental_system_app/api/models/vehicle/my_vehicles_model.dart";
import "package:rental_system_app/api/models/vehicle/recommended_vehicle_model.dart";
import "package:rental_system_app/api/models/vehicle/search_vehicle_model.dart";
import "package:rental_system_app/api/services/common/image_upload_widget.dart";
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

class GetRecommendedVehicleService {
  Future<RecommendedVehiclesModel> data() async {
    http.Client client = http.Client();

    String token = await UtilSharedPreferences.getToken();

    final Uri url = Uri.parse("$api/vehicle/rec");
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

      return recommendedVehiclesModelFromJson(response.body);
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

class BookingsPerVehicleService {
  Future<BookingsPerVehicleModel> data({required String vehicleId}) async {
    http.Client client = http.Client();

    String token = await UtilSharedPreferences.getToken();

    final Uri url = Uri.parse("$api/vehicle/booking/$vehicleId");
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

      return bookingsPerVehicleModelFromJson(response.body);
    } catch (e) {
      rethrow;
    }
  }
}

class SearchVehicleService {
  Future<SearchVehicleModel> data({required String searchString}) async {
    http.Client client = http.Client();

    String token = await UtilSharedPreferences.getToken();

    final Uri url = Uri.parse("$api/vehicle/search?q=$searchString");
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

      return searchVehicleModelFromJson(response.body);
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
    required String type,
    required String subCategoryId,
    required String brandId,
    required String model,
    required String vehicleNumber,
    required String description,
    required String rentGuidelines,
    required String transmission,
    required String rate,
    required String lat,
    required String lon,
    required String driveTrain,
    required String color,
    int noOfSeats = 2,
    int noOfDoors = 0,
    bool hasAC = false,
    bool hasABS = false,
    bool hasAirbag = false,
    bool hasSunRoof = false,
    bool hasPowerSteering = false,
    bool hasUSBPort = false,
    bool hasBluetooth = false,
    bool hasKeylessEntry = false,
    bool hasHeatedSeats = false,
    bool hasBackCamera = false,
    bool hasParkingSensors = false,
    bool hasAutoDrive = false,
    int groundClearance = 5,
    int fuelTankCapacity = 1,
  }) async {
    http.Client client = http.Client();

    String token = await UtilSharedPreferences.getToken();

    final Uri url = Uri.parse("$api/vehicle");
    try {
      String uploadedImage = await uploadImage(imageFile, token);

      final http.Response response = await client.post(
        url,
        headers: {
          ...apiHeader,
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "title": title,
          "category": category,
          "type": type,
          "subCategoryId": subCategoryId,
          "brandId": brandId,
          "model": model,
          "thumbnail": uploadedImage,
          "vehicleNumber": vehicleNumber,
          "description": description,
          "rentGuidelines": rentGuidelines,
          "rate": rate,
          "pickupAddress": [lat, lon],
          "driveTrain": driveTrain,
          "features": {
            "color": color,
            "noOfSeats": noOfSeats,
            "noOfDoors": noOfDoors,
            "hasAC": hasAC,
            "hasABS": hasABS,
            "hasAirbag": hasAirbag,
            "hasSunRoof": hasSunRoof,
            "hasPowerSteering": hasPowerSteering,
            "hasUSBPort": hasUSBPort,
            "hasBluetooth": hasBluetooth,
            "hasKeylessEntry": hasKeylessEntry,
            "hasHeatedSeats": hasHeatedSeats,
            "hasBackCamera": hasBackCamera,
            "hasParkingSensors": hasParkingSensors,
            "hasAutoDrive": hasAutoDrive,
            "transmission": transmission,
            "gClearance": groundClearance,
            "fuelTank": fuelTankCapacity,
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
