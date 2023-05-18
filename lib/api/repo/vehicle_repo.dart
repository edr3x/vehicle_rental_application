import 'package:rental_system_app/api/models/vehicle/my_vehicles_model.dart';
import 'package:rental_system_app/api/models/vehicle/vehicle_details_model.dart';
import 'package:rental_system_app/api/models/vehicle/vehicle_near_me_model.dart';
import 'package:rental_system_app/api/services/vehicle_services.dart';
import 'package:rental_system_app/excepitions/custom_error.dart';
import 'package:rental_system_app/excepitions/data_exception.dart';

class VehicleRepository {
  final GetNearbyVehicleService getNearbyVehicleService;
  final GetVehicleDetailsService getVehicleDetailsService;
  final MyVehiclesService myVehiclesService;

  VehicleRepository({
    required this.getNearbyVehicleService,
    required this.getVehicleDetailsService,
    required this.myVehiclesService,
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
}
