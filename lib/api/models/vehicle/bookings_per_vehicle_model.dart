// To parse this JSON data, do
//
//     final bookingsPerVehicleModel = bookingsPerVehicleModelFromJson(jsonString);

import 'dart:convert';

BookingsPerVehicleModel bookingsPerVehicleModelFromJson(String str) =>
    BookingsPerVehicleModel.fromJson(json.decode(str));

String bookingsPerVehicleModelToJson(BookingsPerVehicleModel data) => json.encode(data.toJson());

class BookingsPerVehicleModel {
  bool? success;
  Data? data;

  BookingsPerVehicleModel({
    this.success,
    this.data,
  });

  factory BookingsPerVehicleModel.initial() => BookingsPerVehicleModel(
        success: false,
        data: Data.initial(),
      );

  factory BookingsPerVehicleModel.fromJson(Map<String, dynamic> json) => BookingsPerVehicleModel(
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
  List<Booking>? bookings;

  Data({
    this.msg,
    this.bookings,
  });

  factory Data.initial() => Data(msg: '', bookings: []);

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        msg: json["msg"],
        bookings: json["bookings"] == null
            ? []
            : List<Booking>.from(json["bookings"]!.map((x) => Booking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "bookings": bookings == null ? [] : List<dynamic>.from(bookings!.map((x) => x.toJson())),
      };
}

class Booking {
  String? id;
  String? vehicleId;
  DateTime? startDate;
  DateTime? endDate;
  String? status;
  String? description;
  String? bookedById;
  DateTime? createdAt;
  DateTime? updatedAt;
  BookedBy? bookedBy;
  Vehicle? vehicle;

  Booking({
    this.id,
    this.vehicleId,
    this.startDate,
    this.endDate,
    this.status,
    this.description,
    this.bookedById,
    this.createdAt,
    this.updatedAt,
    this.bookedBy,
    this.vehicle,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["id"],
        vehicleId: json["vehicleId"],
        startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
        endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        status: json["status"],
        description: json["description"],
        bookedById: json["bookedById"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        bookedBy: json["bookedBy"] == null ? null : BookedBy.fromJson(json["bookedBy"]),
        vehicle: json["Vehicle"] == null ? null : Vehicle.fromJson(json["Vehicle"]),
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
        "bookedBy": bookedBy?.toJson(),
        "Vehicle": vehicle?.toJson(),
      };
}

class BookedBy {
  String? fullName;
  String? profileImage;

  BookedBy({
    this.fullName,
    this.profileImage,
  });

  factory BookedBy.fromJson(Map<String, dynamic> json) => BookedBy(
        fullName: json["fullName"],
        profileImage: json["profileImage"],
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "profileImage": profileImage,
      };
}

class Vehicle {
  String? rate;

  Vehicle({
    this.rate,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        rate: json["rate"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
      };
}
