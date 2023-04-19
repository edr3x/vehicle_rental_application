part of 'phone_number_verify_cubit.dart';

enum PhoneNumberVerifyStatus {
  initial,
  loading,
  loaded,
  error,
}

class PhoneNumberVerifyState extends Equatable {
  final PhoneNumberVerifyStatus status;
  final CustomError error;
  final VerifyPhoneModel phoneVerify;

  const PhoneNumberVerifyState({
    required this.status,
    required this.error,
    required this.phoneVerify,
  });

  factory PhoneNumberVerifyState.initial() => PhoneNumberVerifyState(
        status: PhoneNumberVerifyStatus.initial,
        error: const CustomError(),
        phoneVerify: VerifyPhoneModel.initial(),
      );

  @override
  List<Object> get props => [status, error, phoneVerify];

  @override
  bool get stringify => true;

  PhoneNumberVerifyState copyWith({
    PhoneNumberVerifyStatus? status,
    CustomError? error,
    VerifyPhoneModel? phoneVerify,
  }) {
    return PhoneNumberVerifyState(
      status: status ?? this.status,
      error: error ?? this.error,
      phoneVerify: phoneVerify ?? this.phoneVerify,
    );
  }
}
