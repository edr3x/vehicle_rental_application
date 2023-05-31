import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rental_system_app/api/models/vehicle/add_vehicle_response_model.dart';
import 'package:rental_system_app/api/repo/vehicle_repo.dart';
import 'package:rental_system_app/excepitions/custom_error.dart';

part 'add_vehicle_state.dart';

class AddVehicleCubit extends Cubit<AddVehicleState> {
  final VehicleRepository vehicleRepository;
  AddVehicleCubit({
    required this.vehicleRepository,
  }) : super(AddVehicleState.initial());

  Future<void> addVehicle({
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
    emit(state.copyWith(status: AddVehicleStatus.loading));
    try {
      final AddVehicleResponseModel response = await vehicleRepository.addVehicle(
        imageFile: imageFile,
        title: title,
        category: category,
        type: type,
        subCategoryId: subCategoryId,
        brandId: brandId,
        model: model,
        vehicleNumber: vehicleNumber,
        description: description,
        rentGuidelines: rentGuidelines,
        transmission: transmission,
        rate: rate,
        lat: lat,
        lon: lon,
        driveTrain: driveTrain,
        color: color,
      );

      await Future.delayed(const Duration(seconds: 3));

      emit(
        state.copyWith(
          status: AddVehicleStatus.loaded,
          data: response,
        ),
      );
    } on CustomError catch (e) {
      emit(state.copyWith(status: AddVehicleStatus.error, error: e));
    }
  }
}
