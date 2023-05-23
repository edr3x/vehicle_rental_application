import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rental_system_app/api/models/vehicle/recommended_vehicle_model.dart';
import 'package:rental_system_app/api/repo/vehicle_repo.dart';
import 'package:rental_system_app/excepitions/custom_error.dart';

part 'recommended_vehicles_state.dart';

class RecommendedVehiclesCubit extends Cubit<RecommendedVehiclesState> {
  final VehicleRepository vehicleRepository;
  RecommendedVehiclesCubit({
    required this.vehicleRepository,
  }) : super(RecommendedVehiclesState.initial());

  Future<void> getRecommendedVehicles() async {
    emit(state.copyWith(status: RecommendedVehiclesStatus.loading));
    try {
      final RecommendedVehiclesModel response = await vehicleRepository.getRecommendedVehicle();

      emit(
        state.copyWith(
          status: RecommendedVehiclesStatus.loaded,
          data: response,
        ),
      );
    } on CustomError catch (e) {
      emit(state.copyWith(status: RecommendedVehiclesStatus.error, error: e));
    }
  }
}
