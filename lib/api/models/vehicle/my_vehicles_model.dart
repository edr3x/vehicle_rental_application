// To parse this JSON data, do
//
//     final myVehiclesModel = myVehiclesModelFromJson(jsonString);

import 'dart:convert';

MyVehiclesModel myVehiclesModelFromJson(String str) => MyVehiclesModel.fromJson(json.decode(str));

String myVehiclesModelToJson(MyVehiclesModel data) => json.encode(data.toJson());

class MyVehiclesModel {
  bool? success;
  Data? data;

  MyVehiclesModel({
    this.success,
    this.data,
  });

  factory MyVehiclesModel.initial() => MyVehiclesModel(
        success: false,
        data: Data.initial(),
      );

  factory MyVehiclesModel.fromJson(Map<String, dynamic> json) => MyVehiclesModel(
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
  String? addedById;
  String? type;
  String? category;
  String? subCategoryId;
  String? brandId;
  String? model;
  String? thumbnail;
  List<String>? images;
  bool? isBooked;
  bool? isVerified;
  List<String>? bluebookPics;
  String? vehicleNumber;
  String? description;
  String? rentGuidelines;
  String? rate;
  List<String>? pickupAddress;
  String? driveTrain;
  String? insurancePaperPhoto;
  DateTime? createdAt;
  DateTime? updatedAt;
  Brand? subCategory;
  Brand? brand;
  List<Booking>? booking;

  Result({
    this.id,
    this.title,
    this.addedById,
    this.type,
    this.category,
    this.subCategoryId,
    this.brandId,
    this.model,
    this.thumbnail,
    this.images,
    this.isBooked,
    this.isVerified,
    this.bluebookPics,
    this.vehicleNumber,
    this.description,
    this.rentGuidelines,
    this.rate,
    this.pickupAddress,
    this.driveTrain,
    this.insurancePaperPhoto,
    this.createdAt,
    this.updatedAt,
    this.subCategory,
    this.brand,
    this.booking,
  });

  factory Result.initial() => Result(
        id: '',
        title: '',
        addedById: '',
        type: '',
        category: '',
        subCategoryId: '',
        brandId: '',
        model: '',
        thumbnail: '',
        images: [],
        isBooked: false,
        isVerified: false,
        bluebookPics: [],
        vehicleNumber: '',
        description: '',
        rentGuidelines: '',
        rate: '',
        pickupAddress: [],
        driveTrain: '',
        insurancePaperPhoto: '',
        createdAt: null,
        updatedAt: null,
        subCategory: null,
        brand: null,
        booking: [],
      );

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        title: json["title"],
        addedById: json["addedById"],
        type: json["type"],
        category: json["category"],
        subCategoryId: json["subCategoryId"],
        brandId: json["brandId"],
        model: json["model"],
        thumbnail: json["thumbnail"],
        images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
        isBooked: json["isBooked"],
        isVerified: json["isVerified"],
        bluebookPics: json["bluebookPics"] == null
            ? []
            : List<String>.from(json["bluebookPics"]!.map((x) => x)),
        vehicleNumber: json["vehicleNumber"],
        description: json["description"],
        rentGuidelines: json["rentGuidelines"],
        rate: json["rate"],
        pickupAddress: json["pickupAddress"] == null
            ? []
            : List<String>.from(json["pickupAddress"]!.map((x) => x)),
        driveTrain: json["driveTrain"],
        insurancePaperPhoto: json["insurancePaperPhoto"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        subCategory: json["subCategory"] == null ? null : Brand.fromJson(json["subCategory"]),
        brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
        booking: json["Booking"] == null
            ? []
            : List<Booking>.from(json["Booking"]!.map((x) => Booking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "addedById": addedById,
        "type": type,
        "category": category,
        "subCategoryId": subCategoryId,
        "brandId": brandId,
        "model": model,
        "thumbnail": thumbnail,
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "isBooked": isBooked,
        "isVerified": isVerified,
        "bluebookPics": bluebookPics == null ? [] : List<dynamic>.from(bluebookPics!.map((x) => x)),
        "vehicleNumber": vehicleNumber,
        "description": description,
        "rentGuidelines": rentGuidelines,
        "rate": rate,
        "pickupAddress":
            pickupAddress == null ? [] : List<dynamic>.from(pickupAddress!.map((x) => x)),
        "driveTrain": driveTrain,
        "insurancePaperPhoto": insurancePaperPhoto,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "subCategory": subCategory?.toJson(),
        "brand": brand?.toJson(),
        "Booking": booking == null ? [] : List<dynamic>.from(booking!.map((x) => x.toJson())),
      };
}

class Booking {
  String? id;
  String? status;

  Booking({
    this.id,
    this.status,
  });

  factory Booking.initial() => Booking(
        id: '',
        status: '',
      );

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["id"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
      };
}

class Brand {
  String? id;
  String? title;
  String? description;
  String? logo;
  String? category;

  Brand({
    this.id,
    this.title,
    this.description,
    this.logo,
    this.category,
  });

  factory Brand.initial() => Brand(
        id: '',
        title: '',
        description: '',
        logo: '',
        category: '',
      );

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        logo: json["logo"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "logo": logo,
        "category": category,
      };
}
