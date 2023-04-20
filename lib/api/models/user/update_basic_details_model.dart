// To parse this JSON data, do
//
//     final updateBasicUserDetailsModel = updateBasicUserDetailsModelFromJson(jsonString);

import 'dart:convert';

UpdateBasicUserDetailsModel updateBasicUserDetailsModelFromJson(String str) =>
    UpdateBasicUserDetailsModel.fromJson(json.decode(str));

String updateBasicUserDetailsModelToJson(UpdateBasicUserDetailsModel data) =>
    json.encode(data.toJson());

class UpdateBasicUserDetailsModel {
  UpdateBasicUserDetailsModel({
    this.success,
    this.data,
  });

  bool? success;
  Data? data;

  factory UpdateBasicUserDetailsModel.fromJson(Map<String, dynamic> json) =>
      UpdateBasicUserDetailsModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.fullName,
    this.phone,
    this.email,
    this.gender,
  });

  String? fullName;
  int? phone;
  String? email;
  String? gender;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        fullName: json["fullName"],
        phone: json["phone"],
        email: json["email"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "phone": phone,
        "email": email,
        "gender": gender,
      };
}
