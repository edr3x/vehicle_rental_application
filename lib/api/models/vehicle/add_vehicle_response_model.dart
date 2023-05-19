// To parse this JSON data, do
//
//     final addVehicleResponseModel = addVehicleResponseModelFromJson(jsonString);

import 'dart:convert';

AddVehicleResponseModel addVehicleResponseModelFromJson(String str) =>
    AddVehicleResponseModel.fromJson(json.decode(str));

String addVehicleResponseModelToJson(AddVehicleResponseModel data) => json.encode(data.toJson());

class AddVehicleResponseModel {
  bool? success;
  Data? data;

  AddVehicleResponseModel({
    this.success,
    this.data,
  });

  factory AddVehicleResponseModel.initial() => AddVehicleResponseModel(
        success: false,
        data: Data.initial(),
      );

  factory AddVehicleResponseModel.fromJson(Map<String, dynamic> json) => AddVehicleResponseModel(
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
