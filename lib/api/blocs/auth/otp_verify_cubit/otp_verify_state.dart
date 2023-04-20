part of 'otp_verify_cubit.dart';

enum OtpVerifyStatus {
  initial,
  loading,
  loaded,
  error,
}

class OtpVerifyState extends Equatable {
  final OtpVerifyStatus status;
  final CustomError error;
  final VerifyOtpModel otpVerify;

  const OtpVerifyState({
    required this.status,
    required this.error,
    required this.otpVerify,
  });

  factory OtpVerifyState.initial() => OtpVerifyState(
        status: OtpVerifyStatus.initial,
        error: const CustomError(),
        otpVerify: VerifyOtpModel.initial(),
      );

  @override
  List<Object> get props => [status, error, otpVerify];

  @override
  bool get stringify => true;

  OtpVerifyState copyWith({
    OtpVerifyStatus? status,
    CustomError? error,
    VerifyOtpModel? otpVerify,
  }) {
    return OtpVerifyState(
      status: status ?? this.status,
      error: error ?? this.error,
      otpVerify: otpVerify ?? this.otpVerify,
    );
  }
}
