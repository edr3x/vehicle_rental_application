// To parse this JSON data, do
//
//     final verifyPhoneModel = verifyPhoneModelFromJson(jsonString);

import 'dart:convert';

VerifyPhoneModel verifyPhoneModelFromJson(String str) =>
    VerifyPhoneModel.fromJson(json.decode(str));

String verifyPhoneModelToJson(VerifyPhoneModel data) =>
    json.encode(data.toJson());

class VerifyPhoneModel {
  VerifyPhoneModel({
    this.success,
    this.data,
  });

  factory VerifyPhoneModel.initial() =>
      VerifyPhoneModel(success: false, data: "Failed to get data");

  bool? success;
  String? data;

  factory VerifyPhoneModel.fromJson(Map<String, dynamic> json) =>
      VerifyPhoneModel(
        success: json["success"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data,
      };
}
