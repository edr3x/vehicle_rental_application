import 'package:rental_system_app/api/models/vehicle/add_vehicle_response_model.dart';
import 'package:rental_system_app/api/models/vehicle/bookings_per_vehicle_model.dart';
import 'package:rental_system_app/api/models/vehicle/my_vehicles_model.dart';
import 'package:rental_system_app/api/models/vehicle/recommended_vehicle_model.dart';
import 'package:rental_system_app/api/models/vehicle/vehicle_details_model.dart';
import 'package:rental_system_app/api/models/vehicle/vehicle_near_me_model.dart';
import 'package:rental_system_app/api/services/vehicle_services.dart';
import 'package:rental_system_app/excepitions/custom_error.dart';
import 'package:rental_system_app/excepitions/data_exception.dart';

class VehicleRepository {
  final GetNearbyVehicleService getNearbyVehicleService;
  final GetRecommendedVehicleService getRecommendedVehicleService;
  final GetVehicleDetailsService getVehicleDetailsService;
  final MyVehiclesService myVehiclesService;
  final AddVehicleService addVehicleService;
  final BookingsPerVehicleService bookingsPerVehicleService;

  VehicleRepository({
    required this.getNearbyVehicleService,
    required this.getRecommendedVehicleService,
    required this.getVehicleDetailsService,
    required this.myVehiclesService,
    required this.addVehicleService,
    required this.bookingsPerVehicleService,
  });

  Future<VehicleNearMeModel> getNearbyVehicle({
    required String lat,
    required String lon,
    required String category,
  }) async {
    try {
      final VehicleNearMeModel response = await getNearbyVehicleService.data(
        lat: lat,
        lon: lon,
        category: category,
      );

      return response;
    } on DataException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }

  Future<RecommendedVehiclesModel> getRecommendedVehicle() async {
    try {
      final RecommendedVehiclesModel response = await getRecommendedVehicleService.data();

      return response;
    } on DataException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }

  Future<VehicleDetailsModel> getVehicleDetails({
    required String vehicleId,
  }) async {
    try {
      final VehicleDetailsModel response =
          await getVehicleDetailsService.data(vehicleId: vehicleId);

      return response;
    } on DataException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }

  Future<MyVehiclesModel> getMyVehicles() async {
    try {
      final MyVehiclesModel response = await myVehiclesService.data();

      return response;
    } on DataException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }

  Future<BookingsPerVehicleModel> getBookingsPerVehicle({required String vehicleId}) async {
    try {
      final BookingsPerVehicleModel response =
          await bookingsPerVehicleService.data(vehicleId: vehicleId);

      return response;
    } on DataException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }

  Future<AddVehicleResponseModel> addVehicle({
    required String imageFile,
    required String title,
    required String category,
    required String type,
    required String subCategoryId,
    required String brandId,
    required String model,
    required String vehicleNumber,
    required String description,
    required String rentGuidelines,
    required String transmission,
    required String rate,
    required String lat,
    required String lon,
    required String driveTrain,
    required String color,
    int noOfSeats = 2,
    int noOfDoors = 0,
    bool hasAC = false,
    bool hasABS = false,
    bool hasAirbag = false,
    bool hasSunRoof = false,
    bool hasPowerSteering = false,
    bool hasUSBPort = false,
    bool hasBluetooth = false,
    bool hasKeylessEntry = false,
    bool hasHeatedSeats = false,
    bool hasBackCamera = false,
    bool hasParkingSensors = false,
    bool hasAutoDrive = false,
    int groundClearance = 5,
    int fuelTankCapacity = 1,
  }) async {
    try {
      final AddVehicleResponseModel response = await addVehicleService.data(
        imageFile: imageFile,
        title: title,
        category: category,
        type: type,
        subCategoryId: subCategoryId,
        lat: lat,
        lon: lon,
        brandId: brandId,
        model: model,
        vehicleNumber: vehicleNumber,
        description: description,
        rentGuidelines: rentGuidelines,
        transmission: transmission,
        rate: rate,
        driveTrain: driveTrain,
        color: color,
        noOfSeats: noOfSeats,
        noOfDoors: noOfDoors,
        hasAC: hasAC,
        hasABS: hasABS,
        hasAirbag: hasAirbag,
        hasSunRoof: hasSunRoof,
        hasPowerSteering: hasPowerSteering,
        hasUSBPort: hasUSBPort,
        hasBluetooth: hasBluetooth,
        hasKeylessEntry: hasKeylessEntry,
        hasHeatedSeats: hasHeatedSeats,
        hasBackCamera: hasBackCamera,
        hasParkingSensors: hasParkingSensors,
        hasAutoDrive: hasAutoDrive,
        groundClearance: groundClearance,
        fuelTankCapacity: fuelTankCapacity,
      );

      return response;
    } on DataException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }
}
