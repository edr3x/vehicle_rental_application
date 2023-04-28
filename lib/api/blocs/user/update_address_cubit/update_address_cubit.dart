import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rental_system_app/api/models/user/update_address_model.dart';
import 'package:rental_system_app/api/repo/user_repo.dart';
import 'package:rental_system_app/excepitions/custom_error.dart';

part 'update_address_state.dart';

class UpdateAddressCubit extends Cubit<UpdateAddressState> {
  final UserRepository userRepository;
  UpdateAddressCubit({
    required this.userRepository,
  }) : super(UpdateAddressState.initial());

  Future<void> updateAddress({
    required String province,
    required String district,
    required String municipality,
    required String city,
    required String street,
  }) async {
    emit(state.copyWith(status: UpdateAddressStatus.initial));

    try {
      final UpdateAddressModel response = await userRepository.updateUserAddress(
        province: province,
        district: district,
        municipality: municipality,
        city: city,
        street: street,
      );

      emit(
        state.copyWith(
          status: UpdateAddressStatus.loaded,
          data: response,
        ),
      );
    } on CustomError catch (e) {
      emit(state.copyWith(status: UpdateAddressStatus.error, error: e));
    }
  }
}
