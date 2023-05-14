// To parse this JSON data, do
//
//     final myBookingsModel = myBookingsModelFromJson(jsonString);

import 'dart:convert';

MyBookingsModel myBookingsModelFromJson(String str) => MyBookingsModel.fromJson(json.decode(str));

String myBookingsModelToJson(MyBookingsModel data) => json.encode(data.toJson());

class MyBookingsModel {
  bool? success;
  List<Datum>? data;

  MyBookingsModel({
    this.success,
    this.data,
  });

  factory MyBookingsModel.initial() => MyBookingsModel(
        success: false,
        data: [],
      );

  factory MyBookingsModel.fromJson(Map<String, dynamic> json) => MyBookingsModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
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

  Datum({
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
  });

  factory Datum.initial() => Datum(
        id: '',
        vehicleId: '',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        status: '',
        description: '',
        bookedById: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        vehicle: Vehicle(
          title: '',
          thumbnail: '',
        ),
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
      };
}

class Vehicle {
  String? title;
  String? thumbnail;

  Vehicle({
    this.title,
    this.thumbnail,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        title: json["title"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "thumbnail": thumbnail,
      };
}
