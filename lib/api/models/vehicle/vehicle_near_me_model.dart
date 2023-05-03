// To parse this JSON data, do
//
//     final vehicleNearMeModel = vehicleNearMeModelFromJson(jsonString);

import 'dart:convert';

VehicleNearMeModel vehicleNearMeModelFromJson(String str) =>
    VehicleNearMeModel.fromJson(json.decode(str));

String vehicleNearMeModelToJson(VehicleNearMeModel data) => json.encode(data.toJson());

class VehicleNearMeModel {
  bool? success;
  Data? data;

  VehicleNearMeModel({
    this.success,
    this.data,
  });

  factory VehicleNearMeModel.initial() => VehicleNearMeModel(
        success: false,
        data: Data.initial(),
      );

  factory VehicleNearMeModel.fromJson(Map<String, dynamic> json) => VehicleNearMeModel(
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
  List<Result>? result;

  Data({
    this.msg,
    this.result,
  });

  factory Data.initial() => Data(
        msg: '',
        result: List<Result>.from(['result'].map((x) => Result.initial())),
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        msg: json["msg"],
        result: json["result"] == null
            ? []
            : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class Result {
  String? id;
  String? title;
  String? addedById;
  String? type;
  String? category;
  Brand? subCategory;
  Brand? brand;
  String? model;
  String? thumbnail;
  String? rate;
  List<String>? pickupAddress;
  bool? isBooked;
  int? distance;

  Result({
    this.id,
    this.title,
    this.addedById,
    this.type,
    this.category,
    this.subCategory,
    this.brand,
    this.model,
    this.rate,
    this.thumbnail,
    this.pickupAddress,
    this.isBooked,
    this.distance,
  });

  factory Result.initial() => Result(
        id: '',
        title: '',
        addedById: '',
        type: '',
        category: '',
        subCategory: Brand.initial(),
        brand: Brand.initial(),
        model: '',
        rate: '',
        thumbnail: '',
        pickupAddress: [],
        isBooked: false,
        distance: 0,
      );

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        title: json["title"],
        addedById: json["addedById"],
        type: json["type"],
        rate: json["rate"],
        category: json["category"],
        subCategory: json["subCategory"] == null ? null : Brand.fromJson(json["subCategory"]),
        brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
        model: json["model"],
        thumbnail: json["thumbnail"],
        pickupAddress: json["pickupAddress"] == null
            ? []
            : List<String>.from(json["pickupAddress"]!.map((x) => x)),
        isBooked: json["isBooked"],
        distance: json["distance"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "addedById": addedById,
        "type": type,
        "category": category,
        "rate": rate,
        "subCategory": subCategory?.toJson(),
        "brand": brand?.toJson(),
        "model": model,
        "thumbnail": thumbnail,
        "pickupAddress":
            pickupAddress == null ? [] : List<dynamic>.from(pickupAddress!.map((x) => x)),
        "isBooked": isBooked,
        "distance": distance,
      };
}

class Brand {
  String? id;
  String? title;

  Brand({
    this.id,
    this.title,
  });

  factory Brand.initial() => Brand(
        id: '',
        title: '',
      );

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
