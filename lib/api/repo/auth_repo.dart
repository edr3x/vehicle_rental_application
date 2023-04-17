import 'package:rental_system_app/api/models/auth/verify_otp_model.dart';
import 'package:rental_system_app/api/models/auth/verify_phone_model.dart';
import 'package:rental_system_app/api/services/auth_flow.dart';

import '../../excepitions/custom_error.dart';
import '../../excepitions/data_exception.dart';

class AuthRepository {
  final SendCodeService sendCodeService;
  final VefifyCodeService verifyCodeService;

  AuthRepository({
    required this.sendCodeService,
    required this.verifyCodeService,
  });

  Future<VerifyPhoneModel> verifyPhone({required int phoneNumber}) async {
    try {
      final VerifyPhoneModel verifyPhone =
          await sendCodeService.data(phoneNumber: phoneNumber);

      return verifyPhone;
    } on DataException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }

  Future<VerifyOtpModel> verifyOtp({
    required int phoneNumber,
    required int code,
  }) async {
    try {
      final VerifyOtpModel verifyOtp =
          await verifyCodeService.data(phoneNumber: phoneNumber, otp: code);

      return verifyOtp;
    } on DataException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }
}
