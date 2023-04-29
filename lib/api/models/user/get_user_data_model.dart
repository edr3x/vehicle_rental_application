// To parse this JSON data, do
//
//     final getUserDataModel = getUserDataModelFromJson(jsonString);

import 'dart:convert';

GetUserDataModel getUserDataModelFromJson(String str) =>
    GetUserDataModel.fromJson(json.decode(str));

String getUserDataModelToJson(GetUserDataModel data) => json.encode(data.toJson());

class GetUserDataModel {
  GetUserDataModel({
    this.success,
    this.data,
  });

  factory GetUserDataModel.initial() => GetUserDataModel(
        success: false,
        data: Data.initial(),
      );

  bool? success;
  Data? data;

  factory GetUserDataModel.fromJson(Map<String, dynamic> json) => GetUserDataModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.fullName,
    this.phone,
    this.email,
    this.gender,
    this.role,
    this.isProfileUpdated,
    this.isAddressUpdated,
    this.profileImage,
    this.address,
  });

  String? fullName;
  int? phone;
  String? email;
  String? gender;
  String? role;
  bool? isProfileUpdated;
  bool? isAddressUpdated;
  String? profileImage;
  Address? address;

  factory Data.initial() => Data(
        fullName: "",
        phone: 0,
        email: "",
        gender: "",
        role: "",
        isProfileUpdated: false,
        isAddressUpdated: false,
        profileImage: "",
        address: Address.initial(),
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        fullName: json["fullName"],
        phone: json["phone"],
        email: json["email"],
        gender: json["gender"],
        role: json["role"],
        isProfileUpdated: json["isProfileUpdated"],
        isAddressUpdated: json["isAddressUpdated"],
        profileImage: json["profileImage"],
        address: json["address"] == null ? null : Address.fromJson(json["address"]),
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "phone": phone,
        "email": email,
        "gender": gender,
        "role": role,
        "isProfileUpdated": isProfileUpdated,
        "isAddressUpdated": isAddressUpdated,
        "profileImage": profileImage,
        "address": address?.toJson(),
      };
}

class Address {
  Address({
    this.province,
    this.district,
    this.municipality,
    this.city,
    this.street,
  });

  String? province;
  String? district;
  String? municipality;
  String? city;
  String? street;

  factory Address.initial() => Address(
        province: "",
        district: "",
        municipality: "",
        city: "",
        street: "",
      );

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        province: json["province"],
        district: json["district"],
        municipality: json["municipality"],
        city: json["city"],
        street: json["street"],
      );

  Map<String, dynamic> toJson() => {
        "province": province,
        "district": district,
        "municipality": municipality,
        "city": city,
        "street": street,
      };
}
