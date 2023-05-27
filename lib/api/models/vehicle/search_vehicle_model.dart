// To parse this JSON data, do
//
//     final searchVehicleModel = searchVehicleModelFromJson(jsonString);

import 'dart:convert';

SearchVehicleModel searchVehicleModelFromJson(String str) =>
    SearchVehicleModel.fromJson(json.decode(str));

String searchVehicleModelToJson(SearchVehicleModel data) => json.encode(data.toJson());

class SearchVehicleModel {
  bool? success;
  Data? data;

  SearchVehicleModel({
    this.success,
    this.data,
  });

  factory SearchVehicleModel.initial() => SearchVehicleModel(
        success: false,
        data: Data.initial(),
      );

  factory SearchVehicleModel.fromJson(Map<String, dynamic> json) => SearchVehicleModel(
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
        result: [],
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
  String? thumbnail;
  String? rate;

  Result({
    this.id,
    this.title,
    this.thumbnail,
    this.rate,
  });

  factory Result.initial() => Result(
        id: '',
        title: '',
        thumbnail: '',
        rate: '',
      );

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        title: json["title"],
        thumbnail: json["thumbnail"],
        rate: json["rate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "thumbnail": thumbnail,
        "rate": rate,
      };
}
