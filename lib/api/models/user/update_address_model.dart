// To parse this JSON data, do
//
//     final updateAddressModel = updateAddressModelFromJson(jsonString);

import 'dart:convert';

UpdateAddressModel updateAddressModelFromJson(String str) =>
    UpdateAddressModel.fromJson(json.decode(str));

String updateAddressModelToJson(UpdateAddressModel data) => json.encode(data.toJson());

class UpdateAddressModel {
  bool? success;
  String? data;

  UpdateAddressModel({
    this.success,
    this.data,
  });

  factory UpdateAddressModel.initial() => UpdateAddressModel(
        success: false,
        data: "",
      );

  factory UpdateAddressModel.fromJson(Map<String, dynamic> json) => UpdateAddressModel(
        success: json["success"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data,
      };
}
