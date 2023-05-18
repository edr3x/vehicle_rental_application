// To parse this JSON data, do
//
//     final handleBookingRequestModel = handleBookingRequestModelFromJson(jsonString);

import 'dart:convert';

HandleBookingRequestModel handleBookingRequestModelFromJson(String str) =>
    HandleBookingRequestModel.fromJson(json.decode(str));

String handleBookingRequestModelToJson(HandleBookingRequestModel data) =>
    json.encode(data.toJson());

class HandleBookingRequestModel {
  bool? success;
  Data? data;

  HandleBookingRequestModel({
    this.success,
    this.data,
  });

  factory HandleBookingRequestModel.initial() => HandleBookingRequestModel(
        success: false,
        data: Data.initial(),
      );

  factory HandleBookingRequestModel.fromJson(Map<String, dynamic> json) =>
      HandleBookingRequestModel(
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
