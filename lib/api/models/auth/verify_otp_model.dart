// To parse this JSON data, do
//
//     final verifyOtpModel = verifyOtpModelFromJson(jsonString);

import 'dart:convert';

VerifyOtpModel verifyOtpModelFromJson(String str) => VerifyOtpModel.fromJson(json.decode(str));

String verifyOtpModelToJson(VerifyOtpModel data) => json.encode(data.toJson());

class VerifyOtpModel {
  VerifyOtpModel({
    this.success,
    this.data,
  });

  bool? success;
  Data? data;

  factory VerifyOtpModel.initial() => VerifyOtpModel(
        success: false,
        data: Data.initial(),
      );

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
    this.isProfileUpdated,
    this.role,
    this.message,
  });

  String? token;
  bool? isProfileUpdated;
  String? role;
  String? message;

  factory Data.initial() => Data(
        token: "none",
        message: "no message",
        isProfileUpdated: false,
        role: "none",
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        isProfileUpdated: json["isProfileUpdated"],
        role: json["role"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "isProfileUpdated": isProfileUpdated,
        "role": role,
        "message": message,
      };
}
