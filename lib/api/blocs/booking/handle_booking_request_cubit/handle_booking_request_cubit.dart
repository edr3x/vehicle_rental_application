import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rental_system_app/api/models/booking/handle_booking_request_model.dart';
import 'package:rental_system_app/api/repo/booking_repo.dart';
import 'package:rental_system_app/excepitions/custom_error.dart';

part 'handle_booking_request_state.dart';

class HandleBookingRequestCubit extends Cubit<HandleBookingRequestState> {
  final BookingRepository bookingRepository;
  HandleBookingRequestCubit({
    required this.bookingRepository,
  }) : super(HandleBookingRequestState.initial());

  Future<void> handleBookingRequest({
    required String bookingId,
    required String action,
  }) async {
    emit(state.copyWith(status: HandleBookingRequestStatus.loading));
    try {
      final HandleBookingRequestModel response = await bookingRepository.handleBookingRequest(
        action: action,
        bookingId: bookingId,
      );

      emit(state.copyWith(status: HandleBookingRequestStatus.loaded, data: response));
    } on CustomError catch (e) {
      emit(state.copyWith(status: HandleBookingRequestStatus.error, error: e));
    }
  }
}
