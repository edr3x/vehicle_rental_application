import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'otp_verify_state.dart';

class OtpVerifyCubit extends Cubit<OtpVerifyState> {
  OtpVerifyCubit() : super(OtpVerifyInitial());
}
