// To parse this JSON data, do
//
//     final bookingDetailsModel = bookingDetailsModelFromJson(jsonString);

import 'dart:convert';

BookingDetailsModel bookingDetailsModelFromJson(String str) =>
    BookingDetailsModel.fromJson(json.decode(str));

String bookingDetailsModelToJson(BookingDetailsModel data) => json.encode(data.toJson());

class BookingDetailsModel {
  bool? success;
  Data? data;

  BookingDetailsModel({
    this.success,
    this.data,
  });

  factory BookingDetailsModel.initial() => BookingDetailsModel(
        success: false,
        data: Data.initial(),
      );

  factory BookingDetailsModel.fromJson(Map<String, dynamic> json) => BookingDetailsModel(
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
  Result? result;

  Data({
    this.msg,
    this.result,
  });

  factory Data.initial() => Data(
        msg: '',
        result: Result.initial(),
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        msg: json["msg"],
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "result": result?.toJson(),
      };
}

class Result {
  String? id;
  String? vehicleId;
  DateTime? startDate;
  DateTime? endDate;
  String? status;
  String? description;
  String? bookedById;
  DateTime? createdAt;
  DateTime? updatedAt;
  Vehicle? vehicle;
  EdBy? bookedBy;

  Result({
    this.id,
    this.vehicleId,
    this.startDate,
    this.endDate,
    this.status,
    this.description,
    this.bookedById,
    this.createdAt,
    this.updatedAt,
    this.vehicle,
    this.bookedBy,
  });

  factory Result.initial() => Result(
        id: '',
        vehicleId: '',
        startDate: null,
        endDate: null,
        status: '',
        description: '',
        bookedById: '',
        createdAt: null,
        updatedAt: null,
        vehicle: Vehicle.initial(),
        bookedBy: EdBy.initial(),
      );

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        vehicleId: json["vehicleId"],
        startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
        endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        status: json["status"],
        description: json["description"],
        bookedById: json["bookedById"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        vehicle: json["Vehicle"] == null ? null : Vehicle.fromJson(json["Vehicle"]),
        bookedBy: json["bookedBy"] == null ? null : EdBy.fromJson(json["bookedBy"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vehicleId": vehicleId,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "status": status,
        "description": description,
        "bookedById": bookedById,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "Vehicle": vehicle?.toJson(),
        "bookedBy": bookedBy?.toJson(),
      };
}

class EdBy {
  String? fullName;
  int? phone;
  String? email;
  Address? address;
  String? profileImage;

  EdBy({
    this.fullName,
    this.phone,
    this.email,
    this.address,
    this.profileImage,
  });

  factory EdBy.initial() => EdBy(
        fullName: '',
        phone: 0,
        email: '',
        address: Address.initial(),
        profileImage: '',
      );

  factory EdBy.fromJson(Map<String, dynamic> json) => EdBy(
        fullName: json["fullName"],
        phone: json["phone"],
        email: json["email"],
        address: json["address"] == null ? null : Address.fromJson(json["address"]),
        profileImage: json["profileImage"],
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "phone": phone,
        "email": email,
        "address": address?.toJson(),
        "profileImage": profileImage,
      };
}

class Address {
  String? id;
  String? province;
  String? district;
  String? municipality;
  String? city;
  String? street;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userId;

  Address({
    this.id,
    this.province,
    this.district,
    this.municipality,
    this.city,
    this.street,
    this.createdAt,
    this.updatedAt,
    this.userId,
  });

  factory Address.initial() => Address(
        id: '',
        province: '',
        district: '',
        municipality: '',
        city: '',
        street: '',
        createdAt: null,
        updatedAt: null,
        userId: '',
      );

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        province: json["province"],
        district: json["district"],
        municipality: json["municipality"],
        city: json["city"],
        street: json["street"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "province": province,
        "district": district,
        "municipality": municipality,
        "city": city,
        "street": street,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "userId": userId,
      };
}

class Vehicle {
  String? id;
  String? title;
  String? description;
  bool? isBooked;
  String? thumbnail;
  String? rate;
  String? type;
  Brand? brand;
  String? model;
  EdBy? addedBy;

  Vehicle({
    this.id,
    this.title,
    this.description,
    this.isBooked,
    this.thumbnail,
    this.rate,
    this.type,
    this.brand,
    this.model,
    this.addedBy,
  });

  factory Vehicle.initial() => Vehicle(
        id: '',
        title: '',
        description: '',
        isBooked: false,
        thumbnail: '',
        rate: '',
        type: '',
        brand: Brand.initial(),
        model: '',
        addedBy: EdBy.initial(),
      );

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        isBooked: json["isBooked"],
        thumbnail: json["thumbnail"],
        rate: json["rate"],
        type: json["type"],
        brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
        model: json["model"],
        addedBy: json["addedBy"] == null ? null : EdBy.fromJson(json["addedBy"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "isBooked": isBooked,
        "thumbnail": thumbnail,
        "rate": rate,
        "type": type,
        "brand": brand?.toJson(),
        "model": model,
        "addedBy": addedBy?.toJson(),
      };
}

class Brand {
  String? id;
  String? title;
  String? description;
  String? logo;

  Brand({
    this.id,
    this.title,
    this.description,
    this.logo,
  });

  factory Brand.initial() => Brand(
        id: '',
        title: '',
        description: '',
        logo: '',
      );

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "logo": logo,
      };
}
