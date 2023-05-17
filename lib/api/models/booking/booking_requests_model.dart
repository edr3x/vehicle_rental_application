// To parse this JSON data, do
//
//     final bookingRequestsModel = bookingRequestsModelFromJson(jsonString);

import 'dart:convert';

BookingRequestsModel bookingRequestsModelFromJson(String str) =>
    BookingRequestsModel.fromJson(json.decode(str));

String bookingRequestsModelToJson(BookingRequestsModel data) => json.encode(data.toJson());

class BookingRequestsModel {
  bool? success;
  Data? data;

  BookingRequestsModel({
    this.success,
    this.data,
  });

  factory BookingRequestsModel.initial() => BookingRequestsModel(
        success: false,
        data: Data.initial(),
      );

  factory BookingRequestsModel.fromJson(Map<String, dynamic> json) => BookingRequestsModel(
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

  factory Data.initial() => Data(
        msg: "",
        bookings: [],
      );

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
  Vehicle? vehicle;
  DateTime? createdAt;
  DateTime? updatedAt;
  BookedBy? bookedBy;

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

  factory Booking.initial() => Booking(
        id: "",
        vehicleId: "",
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        status: "",
        description: "",
        bookedById: "",
        vehicle: Vehicle.initial(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        bookedBy: BookedBy.initial(),
      );

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
        vehicle: json["Vehicle"] == null ? null : Vehicle.fromJson(json["Vehicle"]),
        bookedBy: json["bookedBy"] == null ? null : BookedBy.fromJson(json["bookedBy"]),
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
        "vehicle": vehicle?.toJson(),
      };
}

class BookedBy {
  String? profileImage;
  String? fullName;

  BookedBy({
    this.profileImage,
    this.fullName,
  });

  factory BookedBy.initial() => BookedBy(
        profileImage: "",
        fullName: "",
      );

  factory BookedBy.fromJson(Map<String, dynamic> json) => BookedBy(
        profileImage: json["profileImage"],
        fullName: json["fullName"],
      );

  Map<String, dynamic> toJson() => {
        "profileImage": profileImage,
        "fullName": fullName,
      };
}

class Vehicle {
  String? title;

  Vehicle({
    this.title,
  });

  factory Vehicle.initial() => Vehicle(
        title: "",
      );

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
      };
}
