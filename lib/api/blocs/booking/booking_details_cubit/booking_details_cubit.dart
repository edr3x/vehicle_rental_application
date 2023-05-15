import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rental_system_app/api/models/booking/booking_details_model.dart';
import 'package:rental_system_app/api/repo/booking_repo.dart';
import 'package:rental_system_app/excepitions/custom_error.dart';

part 'booking_details_state.dart';

class BookingDetailsCubit extends Cubit<BookingDetailsState> {
  final BookingRepository bookingRepository;
  BookingDetailsCubit({
    required this.bookingRepository,
  }) : super(BookingDetailsState.initial());

  Future<void> bookingDetails({
    required String bookingId,
  }) async {
    emit(state.copyWith(status: BookingDetailsStatus.loading));
    try {
      final BookingDetailsModel response = await bookingRepository.bookingDetails(
        bookingId: bookingId,
      );

      emit(state.copyWith(status: BookingDetailsStatus.loaded, data: response));
    } on CustomError catch (e) {
      emit(state.copyWith(status: BookingDetailsStatus.error, error: e));
    }
  }
}
