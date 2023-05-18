part of 'handle_booking_request_cubit.dart';

enum HandleBookingRequestStatus {
  initial,
  loading,
  loaded,
  error,
}

class HandleBookingRequestState extends Equatable {
  final HandleBookingRequestStatus status;
  final CustomError error;
  final HandleBookingRequestModel data;

  const HandleBookingRequestState({
    required this.status,
    required this.error,
    required this.data,
  });

  factory HandleBookingRequestState.initial() => HandleBookingRequestState(
        status: HandleBookingRequestStatus.initial,
        error: const CustomError(),
        data: HandleBookingRequestModel.initial(),
      );

  @override
  List<Object> get props => [status, error, data];

  @override
  bool get stringify => true;

  HandleBookingRequestState copyWith({
    HandleBookingRequestStatus? status,
    CustomError? error,
    HandleBookingRequestModel? data,
  }) {
    return HandleBookingRequestState(
      status: status ?? this.status,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}
