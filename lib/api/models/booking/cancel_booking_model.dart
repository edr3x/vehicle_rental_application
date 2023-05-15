// To parse this JSON data, do
//
//     final cancelBookingModel = cancelBookingModelFromJson(jsonString);

import 'dart:convert';

CancelBookingModel cancelBookingModelFromJson(String str) =>
    CancelBookingModel.fromJson(json.decode(str));

String cancelBookingModelToJson(CancelBookingModel data) => json.encode(data.toJson());

class CancelBookingModel {
  bool? success;
  Data? data;

  CancelBookingModel({
    this.success,
    this.data,
  });

  factory CancelBookingModel.initial() => CancelBookingModel(
        success: false,
        data: Data.initial(),
      );

  factory CancelBookingModel.fromJson(Map<String, dynamic> json) => CancelBookingModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
      };
}

class Data {
  String? msg;

  Data({
    this.msg,
  });

  factory Data.initial() => Data(
        msg: "",
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
      };
}
