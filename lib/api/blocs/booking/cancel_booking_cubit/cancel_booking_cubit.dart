import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rental_system_app/api/models/booking/cancel_booking_model.dart';
import 'package:rental_system_app/api/repo/booking_repo.dart';
import 'package:rental_system_app/excepitions/custom_error.dart';

part 'cancel_booking_state.dart';

class CancelBookingCubit extends Cubit<CancelBookingState> {
  final BookingRepository bookingRepository;

  CancelBookingCubit({
    required this.bookingRepository,
  }) : super(CancelBookingState.initial());

  Future<void> cancelBooking({
    required String bookingId,
  }) async {
    emit(state.copyWith(status: CancelBookingStatus.loading));

    try {
      final CancelBookingModel response =
          await bookingRepository.cancelBooking(bookingId: bookingId);

      emit(
        state.copyWith(
          status: CancelBookingStatus.loaded,
          data: response,
        ),
      );
    } on CustomError catch (e) {
      emit(state.copyWith(status: CancelBookingStatus.error, error: e));
    }
  }
}
