// To parse this JSON data, do
//
//     final verifyOtpModel = verifyOtpModelFromJson(jsonString);

import 'dart:convert';

VerifyOtpModel verifyOtpModelFromJson(String str) =>
    VerifyOtpModel.fromJson(json.decode(str));

String verifyOtpModelToJson(VerifyOtpModel data) => json.encode(data.toJson());

class VerifyOtpModel {
  VerifyOtpModel({
    this.success,
    this.data,
  });

  bool? success;
  Data? data;

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) => VerifyOtpModel(
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
    this.token,
    this.message,
  });

  String? token;
  String? message;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "message": message,
      };
}
