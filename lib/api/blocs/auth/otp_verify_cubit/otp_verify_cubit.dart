import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rental_system_app/api/models/auth/verify_otp_model.dart';
import 'package:rental_system_app/api/repo/auth_repo.dart';
import 'package:rental_system_app/excepitions/custom_error.dart';

part 'otp_verify_state.dart';

class OtpVerifyCubit extends Cubit<OtpVerifyState> {
  final AuthRepository authRepository;

  OtpVerifyCubit({
    required this.authRepository,
  }) : super(OtpVerifyState.initial());

  Future<void> verifyOtp(int phone, int code) async {
    emit(state.copyWith(status: OtpVerifyStatus.loading));

    try {
      final VerifyOtpModel verifyOtp =
          await authRepository.verifyOtp(phoneNumber: phone, code: code);

      emit(
        state.copyWith(
          status: OtpVerifyStatus.loaded,
          otpVerify: verifyOtp,
        ),
      );
    } on CustomError catch (e) {
      emit(state.copyWith(status: OtpVerifyStatus.error, error: e));
    }
  }
}
