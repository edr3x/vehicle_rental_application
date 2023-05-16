import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rental_system_app/api/models/booking/booking_requests_model.dart';
import 'package:rental_system_app/api/repo/booking_repo.dart';
import 'package:rental_system_app/excepitions/custom_error.dart';

part 'booking_requests_state.dart';

class BookingRequestsCubit extends Cubit<BookingRequestsState> {
  final BookingRepository bookingRepository;
  BookingRequestsCubit({
    required this.bookingRepository,
  }) : super(BookingRequestsState.initial());

  Future<void> listBookingRequests() async {
    emit(state.copyWith(status: BookingRequestsStatus.loading));
    try {
      final BookingRequestsModel response = await bookingRepository.bookingRequests();

      emit(
        state.copyWith(
          status: BookingRequestsStatus.loaded,
          data: response,
        ),
      );
    } on CustomError catch (e) {
      emit(state.copyWith(status: BookingRequestsStatus.error, error: e));
    }
  }
}
