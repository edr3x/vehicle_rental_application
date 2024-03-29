import "dart:convert";

import "package:http/http.dart" as http;
import "package:rental_system_app/api/api.dart";
import "package:rental_system_app/api/models/booking/book_vehicle_model.dart";
import "package:rental_system_app/api/models/booking/booking_details_model.dart";
import "package:rental_system_app/api/models/booking/booking_requests_model.dart";
import "package:rental_system_app/api/models/booking/cancel_booking_model.dart";
import "package:rental_system_app/api/models/booking/handle_booking_request_model.dart";
import "package:rental_system_app/api/models/booking/my_bookings_model.dart";
import "package:rental_system_app/utils/http_error_handler.dart";
import "package:rental_system_app/utils/shared_preferences.dart";

class BookVehicleService {
  Future<BookVehicleModel> data({
    required String vehicleId,
    required String startDate,
    required String endDate,
  }) async {
    http.Client client = http.Client();

    String token = await UtilSharedPreferences.getToken();

    final Uri url = Uri.parse("$api/booking/vehicle");
    try {
      final http.Response response = await client.post(
        url,
        body: jsonEncode({
          "vehicleId": vehicleId,
          "startDate": startDate,
          "endDate": endDate,
        }),
        headers: {
          ...apiHeader,
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 201) {
        throw Exception(httpErrorHandler(response));
      }

      return bookVehicleModelFromJson(response.body);
    } catch (e) {
      rethrow;
    }
  }
}

class MyBookingsService {
  Future<MyBookingsModel> data() async {
    http.Client client = http.Client();

    String token = await UtilSharedPreferences.getToken();

    final Uri url = Uri.parse("$api/booking/list");
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

      return myBookingsModelFromJson(response.body);
    } catch (e) {
      rethrow;
    }
  }
}

class BookingDetailsService {
  Future<BookingDetailsModel> data({
    required String bookingId,
  }) async {
    http.Client client = http.Client();

    String token = await UtilSharedPreferences.getToken();

    final Uri url = Uri.parse("$api/booking/details/$bookingId");
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

      return bookingDetailsModelFromJson(response.body);
    } catch (e) {
      rethrow;
    }
  }
}

class CancelBookingService {
  Future<CancelBookingModel> data({
    required String bookingId,
  }) async {
    http.Client client = http.Client();

    String token = await UtilSharedPreferences.getToken();

    final Uri url = Uri.parse("$api/booking/cancel/$bookingId");
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

      return cancelBookingModelFromJson(response.body);
    } catch (e) {
      rethrow;
    }
  }
}

class BookingRequestsService {
  Future<BookingRequestsModel> data() async {
    http.Client client = http.Client();

    String token = await UtilSharedPreferences.getToken();

    final Uri url = Uri.parse("$api/booking/requests");
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

      return bookingRequestsModelFromJson(response.body);
    } catch (e) {
      rethrow;
    }
  }
}

class HandleBookingRequestService {
  Future<HandleBookingRequestModel> data({
    required String bookingId,
    required String action,
  }) async {
    http.Client client = http.Client();

    String token = await UtilSharedPreferences.getToken();

    final Uri url = Uri.parse("$api/booking/requests/$bookingId?action=$action");
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

      return handleBookingRequestModelFromJson(response.body);
    } catch (e) {
      rethrow;
    }
  }
}
