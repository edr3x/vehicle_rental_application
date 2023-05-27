import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rental_system_app/api/models/vehicle/search_vehicle_model.dart';
import 'package:rental_system_app/api/repo/vehicle_repo.dart';
import 'package:rental_system_app/excepitions/custom_error.dart';

part 'search_vehicle_state.dart';

class SearchVehicleCubit extends Cubit<SearchVehicleState> {
  final VehicleRepository vehicleRepository;
  SearchVehicleCubit({
    required this.vehicleRepository,
  }) : super(SearchVehicleState.initial());

  Future<void> searchVehicle({required String searchString}) async {
    emit(state.copyWith(status: SearchVehicleStatus.loading));

    try {
      final SearchVehicleModel response = await vehicleRepository.searchVehicle(
        searchString: searchString,
      );

      await Future.delayed(const Duration(milliseconds: 20));
      emit(
        state.copyWith(
          status: SearchVehicleStatus.loaded,
          data: response,
        ),
      );
    } on CustomError catch (e) {
      emit(state.copyWith(status: SearchVehicleStatus.error, error: e));
    }
  }
}
