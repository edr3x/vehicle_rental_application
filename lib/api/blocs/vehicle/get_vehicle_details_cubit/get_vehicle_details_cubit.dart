import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rental_system_app/api/models/vehicle/vehicle_details_model.dart';
import 'package:rental_system_app/api/repo/vehicle_repo.dart';
import 'package:rental_system_app/excepitions/custom_error.dart';

part 'get_vehicle_details_state.dart';

class GetVehicleDetailsCubit extends Cubit<GetVehicleDetailsState> {
  final VehicleRepository vehicleRepository;
  GetVehicleDetailsCubit({
    required this.vehicleRepository,
  }) : super(GetVehicleDetailsState.initial());

  Future<void> getVehicleDetails({
    required String vehicleId,
  }) async {
    emit(state.copyWith(status: GetVehicleDetailsStatus.loading));
    try {
      final VehicleDetailsModel response =
          await vehicleRepository.getVehicleDetails(vehicleId: vehicleId);

      emit(
        state.copyWith(
          status: GetVehicleDetailsStatus.loaded,
          data: response,
        ),
      );
    } on CustomError catch (e) {
      emit(state.copyWith(status: GetVehicleDetailsStatus.error, error: e));
    }
  }
}
