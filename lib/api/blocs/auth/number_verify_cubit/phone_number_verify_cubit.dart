import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_system_app/api/models/auth/verify_phone_model.dart';
import 'package:rental_system_app/api/repo/auth_repo.dart';
import 'package:rental_system_app/excepitions/custom_error.dart';

part 'phone_number_verify_state.dart';

class PhoneNumberVerifyCubit extends Cubit<PhoneNumberVerifyState> {
  final AuthRepository authRepository;

  PhoneNumberVerifyCubit({
    required this.authRepository,
  }) : super(PhoneNumberVerifyState.initial());

  Future<void> verifyPhone(int phone) async {
    emit(state.copyWith(status: PhoneNumberVerifyStatus.loading));

    try {
      final VerifyPhoneModel verifyPhone = await authRepository.verifyPhone(phoneNumber: phone);

      emit(
        state.copyWith(
          status: PhoneNumberVerifyStatus.loaded,
          phoneVerify: verifyPhone,
        ),
      );
    } on CustomError catch (e) {
      emit(state.copyWith(status: PhoneNumberVerifyStatus.error, error: e));
    }
  }
}
