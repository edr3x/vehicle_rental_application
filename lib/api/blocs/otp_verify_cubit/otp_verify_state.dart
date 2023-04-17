part of 'otp_verify_cubit.dart';

class OtpVerifyState extends Equatable {
  final ConnectionStatus status;
  final CustomError error;
  final VerifyOtpModel otpVerify;

  const OtpVerifyState({
    required this.status,
    required this.error,
    required this.otpVerify,
  });

  factory OtpVerifyState.initial() => OtpVerifyState(
        status: ConnectionStatus.initial,
        error: const CustomError(),
        otpVerify: VerifyOtpModel.initial(),
      );

  @override
  List<Object> get props => [status, error, otpVerify];

  @override
  bool get stringify => true;

  OtpVerifyState copyWith({
    ConnectionStatus? status,
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
