// To parse this JSON data, do
//
//     final recommendedVehiclesModel = recommendedVehiclesModelFromJson(jsonString);

import 'dart:convert';

RecommendedVehiclesModel recommendedVehiclesModelFromJson(String str) =>
    RecommendedVehiclesModel.fromJson(json.decode(str));

String recommendedVehiclesModelToJson(RecommendedVehiclesModel data) => json.encode(data.toJson());

class RecommendedVehiclesModel {
  bool? success;
  Data? data;

  RecommendedVehiclesModel({
    this.success,
    this.data,
  });

  factory RecommendedVehiclesModel.fromJson(Map<String, dynamic> json) => RecommendedVehiclesModel(
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
  String? thumbnail;
  String? title;
  String? rate;

  Result({
    this.id,
    this.thumbnail,
    this.title,
    this.rate,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        thumbnail: json["thumbnail"],
        title: json["title"],
        rate: json["rate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "thumbnail": thumbnail,
        "title": title,
        "rate": rate,
      };
}
