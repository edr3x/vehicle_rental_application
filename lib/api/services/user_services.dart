import "dart:convert";

import "package:http/http.dart" as http;
import 'package:rental_system_app/api/api.dart';
import "package:rental_system_app/api/models/user/get_user_data_model.dart";
import "package:rental_system_app/api/models/user/post_kyc_model.dart";
import "package:rental_system_app/api/models/user/update_address_model.dart";
import "package:rental_system_app/api/services/common/image_upload_widget.dart";
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
    required String profileImage,
  }) async {
    http.Client client = http.Client();

    String token = await UtilSharedPreferences.getToken();

    final Uri url = Uri.parse("$api/user/profile");
    try {
      String uploadedImage = await uploadImage(profileImage, token);

      final http.Response response = await client.patch(
        url,
        body: jsonEncode({
          "fullName": fullName,
          "gender": gender,
          "email": email,
          "profileImage": uploadedImage,
        }),
        headers: {
          ...apiHeader,
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }

      return updateBasicUserDetailsModelFromJson(response.body);
    } catch (e) {
      rethrow;
    }
  }
}

class UpdateUserAddressService {
  Future<UpdateAddressModel> data({
    required String province,
    required String district,
    required String municipality,
    required String city,
    required String street,
  }) async {
    http.Client client = http.Client();

    String token = await UtilSharedPreferences.getToken();

    final Uri url = Uri.parse("$api/user/address");

    try {
      final http.Response response = await client.patch(
        url,
        body: jsonEncode({
          "province": province,
          "district": district,
          "municipality": municipality,
          "city": city,
          "street": street,
        }),
        headers: {
          ...apiHeader,
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }

      return updateAddressModelFromJson(response.body);
    } catch (e) {
      rethrow;
    }
  }
}

class PostKycService {
  Future<PostKycModel> data({
    required String frontImage,
    required String backImage,
    required String citizenshipNo,
    required String issuedDistrict,
    required String issuedDate,
  }) async {
    http.Client client = http.Client();

    String token = await UtilSharedPreferences.getToken();

    final Uri url = Uri.parse("$api/user/kyc");

    try {
      String front = await uploadImage(frontImage, token);
      String back = await uploadImage(backImage, token);

      final http.Response response = await client.post(
        url,
        body: jsonEncode({
          "citizenshipFront": front,
          "citizenshipBack": back,
          "citizenshipNo": citizenshipNo,
          "issuedDistrict": issuedDistrict,
          "issuedDate": issuedDate,
        }),
        headers: {
          ...apiHeader,
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 201) {
        throw Exception(httpErrorHandler(response));
      }

      return postKycModelFromJson(response.body);
    } catch (e) {
      rethrow;
    }
  }
}
