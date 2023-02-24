import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'phone_number_verify_state.dart';

class PhoneNumberVerifyCubit extends Cubit<PhoneNumberVerifyState> {
  PhoneNumberVerifyCubit() : super(PhoneNumberVerifyInitial());
}
