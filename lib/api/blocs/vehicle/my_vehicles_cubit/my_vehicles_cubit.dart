import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rental_system_app/api/models/vehicle/my_vehicles_model.dart';
import 'package:rental_system_app/api/repo/vehicle_repo.dart';
import 'package:rental_system_app/excepitions/custom_error.dart';

part 'my_vehicles_state.dart';

class MyVehiclesCubit extends Cubit<MyVehiclesState> {
  final VehicleRepository vehicleRepository;
  MyVehiclesCubit({
    required this.vehicleRepository,
  }) : super(MyVehiclesState.initial());

  Future<void> getMyVehicles() async {
    emit(state.copyWith(status: MyVehiclesStatus.loading));
    try {
      final MyVehiclesModel response = await vehicleRepository.getMyVehicles();

      emit(state.copyWith(
        status: MyVehiclesStatus.loaded,
        data: response,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(status: MyVehiclesStatus.error, error: e));
    }
  }
}
