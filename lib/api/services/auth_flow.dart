import "package:http/http.dart" as http;
import 'package:rental_system_app/api/api.dart';

import "../../utils/http_error_handler.dart";
import "../models/auth/verify_otp_model.dart";
import '../models/auth/verify_phone_model.dart';

class SendCodeService {
  Future<dynamic> data({required int phoneNumber}) async {
    http.Client client = http.Client();

    final Uri url = Uri.parse("$api/auth/sendotp");
    try {
      final http.Response response = await client.post(
        url,
        body: {
          "phone": phoneNumber,
        },
        headers: apiHeader,
      );

      if (response.statusCode != 201) {
        throw Exception(httpErrorHandler(response));
      }

      return verifyPhoneModelFromJson(response.body);
    } catch (e) {
      rethrow;
    }
  }
}

class VerifyCodeService {
  Future<dynamic> data({required int phoneNumber, required int otp}) async {
    http.Client client = http.Client();

    final Uri url = Uri.parse("$api/auth/verifyotp");
    try {
      final http.Response response = await client.post(
        url,
        body: {
          "phone": phoneNumber,
          "otp": otp,
        },
        headers: apiHeader,
      );

      if (response.statusCode != 201) {
        throw Exception(httpErrorHandler(response));
      }
      return verifyOtpModelFromJson(response.body);
    } catch (e) {
      rethrow;
    }
  }
}
