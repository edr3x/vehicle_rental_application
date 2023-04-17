part of 'phone_number_verify_cubit.dart';

class PhoneNumberVerifyState extends Equatable {
  final ConnectionStatus status;
  final CustomError error;
  final VerifyPhoneModel phoneVerify;

  const PhoneNumberVerifyState({
    required this.status,
    required this.error,
    required this.phoneVerify,
  });

  factory PhoneNumberVerifyState.initial() => PhoneNumberVerifyState(
        status: ConnectionStatus.initial,
        error: const CustomError(),
        phoneVerify: VerifyPhoneModel.initial(),
      );

  @override
  List<Object> get props => [status, error, phoneVerify];

  @override
  bool get stringify => true;

  PhoneNumberVerifyState copyWith({
    ConnectionStatus? status,
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
