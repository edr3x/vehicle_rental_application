import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rental_system_app/api/models/booking/my_bookings_model.dart';
import 'package:rental_system_app/api/repo/booking_repo.dart';
import 'package:rental_system_app/excepitions/custom_error.dart';

part 'my_bookings_state.dart';

class MyBookingsCubit extends Cubit<MyBookingsState> {
  final BookingRepository bookingRepository;
  MyBookingsCubit({
    required this.bookingRepository,
  }) : super(MyBookingsState.initial());

  Future<void> myBookingsHistory() async {
    try {
      final MyBookingsModel response = await bookingRepository.myBookings();

      emit(
        state.copyWith(
          status: MyBookingsStatus.loaded,
          myBookings: response,
        ),
      );
    } on CustomError catch (e) {
      emit(state.copyWith(status: MyBookingsStatus.error, error: e));
    }
  }
}
