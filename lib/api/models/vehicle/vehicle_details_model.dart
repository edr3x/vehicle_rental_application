// To parse this JSON data, do
//
//     final vehicleDetailsModel = vehicleDetailsModelFromJson(jsonString);

import 'dart:convert';

VehicleDetailsModel vehicleDetailsModelFromJson(String str) =>
    VehicleDetailsModel.fromJson(json.decode(str));

String vehicleDetailsModelToJson(VehicleDetailsModel data) => json.encode(data.toJson());

class VehicleDetailsModel {
  bool? success;
  Data? data;

  VehicleDetailsModel({
    this.success,
    this.data,
  });

  factory VehicleDetailsModel.initial() => VehicleDetailsModel(
        success: false,
        data: Data.initial(),
      );

  factory VehicleDetailsModel.fromJson(Map<String, dynamic> json) => VehicleDetailsModel(
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
        msg: "",
        result: Result.inital(),
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
  String? title;
  AddedBy? addedBy;
  String? type;
  String? category;
  String? thumbnail;
  SubCategory? subCategory;
  Brand? brand;
  String? model;
  List<String>? images;
  String? vehicleNumber;
  String? description;
  String? rentGuidelines;
  String? rate;
  List<String>? pickupAddress;
  String? driveTrain;
  Features? features;

  Result({
    this.id,
    this.title,
    this.addedBy,
    this.type,
    this.category,
    this.thumbnail,
    this.subCategory,
    this.brand,
    this.model,
    this.images,
    this.vehicleNumber,
    this.description,
    this.rentGuidelines,
    this.rate,
    this.pickupAddress,
    this.driveTrain,
    this.features,
  });

  factory Result.inital() => Result(
        id: "",
        title: "",
        addedBy: AddedBy.initial(),
        type: "",
        category: "",
        subCategory: SubCategory.initial(),
        brand: Brand.initial(),
        model: "",
        images: [],
        vehicleNumber: "",
        description: "",
        rentGuidelines: "",
        rate: "",
        pickupAddress: [],
        driveTrain: "",
        features: Features.initial(),
      );

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        title: json["title"],
        addedBy: json["addedBy"] == null ? null : AddedBy.fromJson(json["addedBy"]),
        type: json["type"],
        category: json["category"],
        thumbnail: json["thumbnail"],
        subCategory: json["subCategory"] == null ? null : SubCategory.fromJson(json["subCategory"]),
        brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
        model: json["model"],
        images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
        vehicleNumber: json["vehicleNumber"],
        description: json["description"],
        rentGuidelines: json["rentGuidelines"],
        rate: json["rate"],
        pickupAddress: json["pickupAddress"] == null
            ? []
            : List<String>.from(json["pickupAddress"]!.map((x) => x)),
        driveTrain: json["driveTrain"],
        features: json["features"] == null ? null : Features.fromJson(json["features"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "addedBy": addedBy?.toJson(),
        "type": type,
        "category": category,
        "thumbnail": thumbnail,
        "subCategory": subCategory?.toJson(),
        "brand": brand?.toJson(),
        "model": model,
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "vehicleNumber": vehicleNumber,
        "description": description,
        "rentGuidelines": rentGuidelines,
        "rate": rate,
        "pickupAddress":
            pickupAddress == null ? [] : List<dynamic>.from(pickupAddress!.map((x) => x)),
        "driveTrain": driveTrain,
        "features": features?.toJson(),
      };
}

class AddedBy {
  String? id;
  int? phone;
  String? profileImage;
  String? fullName;

  AddedBy({
    this.id,
    this.phone,
    this.profileImage,
    this.fullName,
  });

  factory AddedBy.initial() => AddedBy(
        id: "",
        phone: 0,
        fullName: "",
        profileImage: "",
      );

  factory AddedBy.fromJson(Map<String, dynamic> json) => AddedBy(
        id: json["id"],
        phone: json["phone"],
        profileImage: json["profileImage"],
        fullName: json["fullName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "profileImage": profileImage,
        "fullName": fullName,
      };
}

class Brand {
  String? id;
  String? title;
  String? logo;

  Brand({
    this.id,
    this.title,
    this.logo,
  });

  factory Brand.initial() => Brand(
        id: '',
        title: '',
        logo: '',
      );

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        title: json["title"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "logo": logo,
      };
}

class Features {
  String? id;
  String? vehicleId;
  String? color;
  int? noOfSeats;
  int? noOfDoors;
  bool? hasAc;
  bool? hasAbs;
  bool? hasAirbag;
  bool? hasSunRoof;
  bool? hasPowerSteering;
  bool? hasUsbPort;
  bool? hasBluetooth;
  bool? hasKeylessEntry;
  bool? hasHeatedSeats;
  bool? hasBackCamera;
  bool? hasParkingSensors;
  bool? hasAutoDrive;
  String? transmission;
  int? gClearance;
  int? fuelTank;

  Features({
    this.id,
    this.vehicleId,
    this.color,
    this.noOfSeats,
    this.noOfDoors,
    this.hasAc,
    this.hasAbs,
    this.hasAirbag,
    this.hasSunRoof,
    this.hasPowerSteering,
    this.hasUsbPort,
    this.hasBluetooth,
    this.hasKeylessEntry,
    this.hasHeatedSeats,
    this.hasBackCamera,
    this.hasParkingSensors,
    this.hasAutoDrive,
    this.transmission,
    this.gClearance,
    this.fuelTank,
  });

  factory Features.initial() => Features(
        id: "",
        vehicleId: "",
        color: "",
        noOfSeats: 0,
        noOfDoors: 0,
        hasAc: false,
        hasAbs: false,
        hasAirbag: false,
        hasSunRoof: false,
        hasPowerSteering: false,
        hasUsbPort: false,
        hasBluetooth: false,
        hasKeylessEntry: false,
        hasHeatedSeats: false,
        hasBackCamera: false,
        hasParkingSensors: false,
        hasAutoDrive: false,
        transmission: "",
        gClearance: 0,
        fuelTank: 0,
      );

  factory Features.fromJson(Map<String, dynamic> json) => Features(
        id: json["id"],
        vehicleId: json["vehicleId"],
        color: json["color"],
        noOfSeats: json["noOfSeats"],
        noOfDoors: json["noOfDoors"],
        hasAc: json["hasAC"],
        hasAbs: json["hasABS"],
        hasAirbag: json["hasAirbag"],
        hasSunRoof: json["hasSunRoof"],
        hasPowerSteering: json["hasPowerSteering"],
        hasUsbPort: json["hasUSBPort"],
        hasBluetooth: json["hasBluetooth"],
        hasKeylessEntry: json["hasKeylessEntry"],
        hasHeatedSeats: json["hasHeatedSeats"],
        hasBackCamera: json["hasBackCamera"],
        hasParkingSensors: json["hasParkingSensors"],
        hasAutoDrive: json["hasAutoDrive"],
        transmission: json["transmission"],
        gClearance: json["gClearance"],
        fuelTank: json["fuelTank"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vehicleId": vehicleId,
        "color": color,
        "noOfSeats": noOfSeats,
        "noOfDoors": noOfDoors,
        "hasAC": hasAc,
        "hasABS": hasAbs,
        "hasAirbag": hasAirbag,
        "hasSunRoof": hasSunRoof,
        "hasPowerSteering": hasPowerSteering,
        "hasUSBPort": hasUsbPort,
        "hasBluetooth": hasBluetooth,
        "hasKeylessEntry": hasKeylessEntry,
        "hasHeatedSeats": hasHeatedSeats,
        "hasBackCamera": hasBackCamera,
        "hasParkingSensors": hasParkingSensors,
        "hasAutoDrive": hasAutoDrive,
        "transmission": transmission,
        "gClearance": gClearance,
        "fuelTank": fuelTank,
      };
}

class SubCategory {
  String? id;
  String? title;

  SubCategory({
    this.id,
    this.title,
  });

  factory SubCategory.initial() => SubCategory(
        id: '',
        title: '',
      );

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
