part of 'cancel_booking_cubit.dart';

enum CancelBookingStatus {
  initial,
  loading,
  loaded,
  error,
}

class CancelBookingState extends Equatable {
  final CancelBookingStatus status;
  final CustomError error;
  final CancelBookingModel data;

  const CancelBookingState({
    required this.status,
    required this.error,
    required this.data,
  });

  factory CancelBookingState.initial() => CancelBookingState(
        status: CancelBookingStatus.initial,
        error: const CustomError(),
        data: CancelBookingModel.initial(),
      );

  @override
  List<Object> get props => [status, error, data];

  @override
  bool get stringify => true;

  CancelBookingState copyWith({
    CancelBookingStatus? status,
    CustomError? error,
    CancelBookingModel? data,
  }) {
    return CancelBookingState(
      status: status ?? this.status,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}
