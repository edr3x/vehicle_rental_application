// To parse this JSON data, do
//
//     final postKycModel = postKycModelFromJson(jsonString);

import 'dart:convert';

PostKycModel postKycModelFromJson(String str) => PostKycModel.fromJson(json.decode(str));

String postKycModelToJson(PostKycModel data) => json.encode(data.toJson());

class PostKycModel {
  bool? success;
  String? data;

  PostKycModel({
    this.success,
    this.data,
  });

  factory PostKycModel.fromJson(Map<String, dynamic> json) => PostKycModel(
        success: json["success"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data,
      };
}
