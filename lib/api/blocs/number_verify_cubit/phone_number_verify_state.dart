part of 'phone_number_verify_cubit.dart';

class PhoneNumberVerifyState extends Equatable {
  final int phoneNumber;

  const PhoneNumberVerifyState({required this.phoneNumber});

  factory PhoneNumberVerifyState.initial() {
    return const PhoneNumberVerifyState(phoneNumber: 0);
  }

  @override
  List<Object> get props => [phoneNumber];

  @override
  String toString() => 'PhoneNumberVerifyState(counter: $phoneNumber)';

  PhoneNumberVerifyState copyWith({
    int? phoneNumber,
  }) {
    return PhoneNumberVerifyState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
