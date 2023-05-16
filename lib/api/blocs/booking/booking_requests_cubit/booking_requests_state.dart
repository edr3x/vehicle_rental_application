part of 'booking_requests_cubit.dart';

enum BookingRequestsStatus {
  initial,
  loading,
  loaded,
  error,
}

class BookingRequestsState extends Equatable {
  final BookingRequestsStatus status;
  final CustomError error;
  final BookingRequestsModel data;

  const BookingRequestsState({
    required this.status,
    required this.error,
    required this.data,
  });

  factory BookingRequestsState.initial() => BookingRequestsState(
        status: BookingRequestsStatus.initial,
        error: const CustomError(),
        data: BookingRequestsModel.initial(),
      );

  @override
  List<Object> get props => [status, error, data];

  @override
  bool get stringify => true;

  BookingRequestsState copyWith({
    BookingRequestsStatus? status,
    CustomError? error,
    BookingRequestsModel? data,
  }) {
    return BookingRequestsState(
      status: status ?? this.status,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}
