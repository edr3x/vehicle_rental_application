// To parse this JSON data, do
//
//     final getKycModel = getKycModelFromJson(jsonString);

import 'dart:convert';

GetKycModel getKycModelFromJson(String str) => GetKycModel.fromJson(json.decode(str));

String getKycModelToJson(GetKycModel data) => json.encode(data.toJson());

class GetKycModel {
  bool? success;
  Data? data;

  GetKycModel({
    this.success,
    this.data,
  });

  factory GetKycModel.fromJson(Map<String, dynamic> json) => GetKycModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  factory GetKycModel.initial() => GetKycModel(
        success: false,
        data: Data.initial(),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
      };
}

class Data {
  String? citizenshipFront;
  String? citizenshipBack;
  String? issuedDate;
  String? citizenshipNo;
  String? issuedDistrict;

  Data({
    this.citizenshipFront,
    this.citizenshipBack,
    this.issuedDate,
    this.citizenshipNo,
    this.issuedDistrict,
  });

  factory Data.initial() => Data(
        citizenshipFront: "",
        citizenshipBack: "",
        issuedDate: "",
        citizenshipNo: "",
        issuedDistrict: "",
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        citizenshipFront: json["citizenshipFront"],
        citizenshipBack: json["citizenshipBack"],
        issuedDate: json["issuedDate"],
        citizenshipNo: json["citizenshipNo"],
        issuedDistrict: json["issuedDistrict"],
      );

  Map<String, dynamic> toJson() => {
        "citizenshipFront": citizenshipFront,
        "citizenshipBack": citizenshipBack,
        "issuedDate": issuedDate,
        "citizenshipNo": citizenshipNo,
        "issuedDistrict": issuedDistrict,
      };
}
