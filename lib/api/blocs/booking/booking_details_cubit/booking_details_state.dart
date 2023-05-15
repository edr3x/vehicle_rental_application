part of 'booking_details_cubit.dart';

enum BookingDetailsStatus {
  initial,
  loading,
  loaded,
  error,
}

class BookingDetailsState extends Equatable {
  final BookingDetailsStatus status;
  final CustomError error;
  final BookingDetailsModel data;

  const BookingDetailsState({
    required this.status,
    required this.error,
    required this.data,
  });

  factory BookingDetailsState.initial() => BookingDetailsState(
        status: BookingDetailsStatus.initial,
        error: const CustomError(),
        data: BookingDetailsModel.initial(),
      );

  @override
  List<Object> get props => [status, error, data];

  @override
  bool get stringify => true;

  BookingDetailsState copyWith({
    BookingDetailsStatus? status,
    CustomError? error,
    BookingDetailsModel? data,
  }) {
    return BookingDetailsState(
      status: status ?? this.status,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}
