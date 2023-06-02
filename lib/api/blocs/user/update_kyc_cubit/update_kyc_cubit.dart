import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rental_system_app/api/models/user/post_kyc_model.dart';
import 'package:rental_system_app/api/repo/user_repo.dart';

import '../../../../excepitions/custom_error.dart';

part 'update_kyc_state.dart';

class UpdateKycCubit extends Cubit<UpdateKycState> {
  final UserRepository userRepository;
  UpdateKycCubit({
    required this.userRepository,
  }) : super(UpdateKycState.initial());

  Future<void> updateKyc({
    required String frontImage,
    required String backImage,
    required String citizenshipNo,
    required String issuedDistrict,
    required String issuedDate,
  }) async {
    emit(state.copyWith(status: UpdateKycStatus.loading));
    try {
      final PostKycModel response = await userRepository.updateKycInfo(
        frontImage: frontImage,
        backImage: backImage,
        citizenshipNo: citizenshipNo,
        issuedDistrict: issuedDistrict,
        issuedDate: issuedDate,
      );

      emit(
        state.copyWith(
          status: UpdateKycStatus.loaded,
          data: response,
        ),
      );
    } on CustomError catch (e) {
      emit(state.copyWith(status: UpdateKycStatus.error, error: e));
    }
  }
}
