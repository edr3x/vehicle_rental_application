import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'phone_number_verify_state.dart';

class PhoneNumberVerifyCubit extends Cubit<PhoneNumberVerifyState> {
  PhoneNumberVerifyCubit() : super(PhoneNumberVerifyInitial());
}
