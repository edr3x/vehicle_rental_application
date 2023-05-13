import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rental_system_app/api/models/booking/book_vehicle_model.dart';
import 'package:rental_system_app/api/repo/booking_repo.dart';
import 'package:rental_system_app/excepitions/custom_error.dart';

part 'book_vehicle_state.dart';

class BookVehicleCubit extends Cubit<BookVehicleState> {
  final BookingRepository bookingRepository;
  BookVehicleCubit({
    required this.bookingRepository,
  }) : super(BookVehicleState.initial());

  Future<void> bookVehicle({
    required String vehicleId,
    required String startDate,
    required String endDate,
  }) async {
    emit(state.copyWith(status: BookVehicleStatus.initial));

    try {
      final BookVehicleModel response = await bookingRepository.bookVehicle(
        vehicleId: vehicleId,
        startDate: startDate,
        endDate: endDate,
      );

      emit(
        state.copyWith(
          status: BookVehicleStatus.loaded,
          data: response,
        ),
      );
    } on CustomError catch (e) {
      emit(state.copyWith(status: BookVehicleStatus.error, error: e));
    }
  }
}
