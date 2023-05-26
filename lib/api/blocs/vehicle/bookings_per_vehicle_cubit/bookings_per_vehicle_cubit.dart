import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rental_system_app/api/models/vehicle/bookings_per_vehicle_model.dart';
import 'package:rental_system_app/api/repo/vehicle_repo.dart';
import 'package:rental_system_app/excepitions/custom_error.dart';

part 'bookings_per_vehicle_state.dart';

class BookingsPerVehicleCubit extends Cubit<BookingsPerVehicleState> {
  final VehicleRepository vehicleRepository;
  BookingsPerVehicleCubit({
    required this.vehicleRepository,
  }) : super(BookingsPerVehicleState.initial());

  Future<void> getBookingsPerVehicle({required String vehicleId}) async {
    emit(state.copyWith(status: BookingsPerVehicleStatus.loading));
    try {
      final BookingsPerVehicleModel response =
          await vehicleRepository.getBookingsPerVehicle(vehicleId: vehicleId);

      emit(
        state.copyWith(
          status: BookingsPerVehicleStatus.loaded,
          data: response,
        ),
      );
    } on CustomError catch (e) {
      emit(state.copyWith(status: BookingsPerVehicleStatus.error, error: e));
    }
  }
}
