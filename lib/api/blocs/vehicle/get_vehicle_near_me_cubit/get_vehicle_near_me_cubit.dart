import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rental_system_app/api/models/vehicle/vehicle_near_me_model.dart';
import 'package:rental_system_app/api/repo/vehicle_repo.dart';
import 'package:rental_system_app/excepitions/custom_error.dart';

part 'get_vehicle_near_me_state.dart';

class GetVehicleNearMeCubit extends Cubit<GetVehicleNearMeState> {
  final VehicleRepository vehicleRepository;

  GetVehicleNearMeCubit({
    required this.vehicleRepository,
  }) : super(GetVehicleNearMeState.initial());

  Future<void> getNearbyVehicle({
    required String lat,
    required String lon,
    required String category,
  }) async {
    emit(state.copyWith(status: GetVehicleNearMeConnectionStatus.loading));
    try {
      final VehicleNearMeModel response = await vehicleRepository.getNearbyVehicle(
        lat: lat,
        lon: lon,
        category: category,
      );

      emit(
        state.copyWith(
          status: GetVehicleNearMeConnectionStatus.loaded,
          data: response,
        ),
      );
    } on CustomError catch (e) {
      emit(state.copyWith(status: GetVehicleNearMeConnectionStatus.error, error: e));
    }
  }
}