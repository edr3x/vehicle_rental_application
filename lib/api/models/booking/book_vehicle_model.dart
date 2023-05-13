// To parse this JSON data, do
//
//     final bookVehicleModel = bookVehicleModelFromJson(jsonString);

import 'dart:convert';

BookVehicleModel bookVehicleModelFromJson(String str) =>
    BookVehicleModel.fromJson(json.decode(str));

String bookVehicleModelToJson(BookVehicleModel data) => json.encode(data.toJson());

class BookVehicleModel {
  bool? success;
  Data? data;

  BookVehicleModel({
    this.success,
    this.data,
  });

  factory BookVehicleModel.initial() => BookVehicleModel(
        success: false,
        data: Data.initial(),
      );

  factory BookVehicleModel.fromJson(Map<String, dynamic> json) => BookVehicleModel(
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
        msg: '',
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
      };
}
