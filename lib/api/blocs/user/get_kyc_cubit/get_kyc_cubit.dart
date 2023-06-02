import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rental_system_app/api/models/user/get_kyc_model.dart';
import 'package:rental_system_app/api/repo/user_repo.dart';

import '../../../../excepitions/custom_error.dart';

part 'get_kyc_state.dart';

class GetKycCubit extends Cubit<GetKycState> {
  final UserRepository userRepository;
  GetKycCubit({
    required this.userRepository,
  }) : super(GetKycState.initial());

  Future<void> getKycInfo() async {
    emit(state.copyWith(status: GetKycStatus.loading));

    try {
      final GetKycModel getKycModel = await userRepository.getKycInfo();

      emit(
        state.copyWith(
          status: GetKycStatus.loaded,
          data: getKycModel,
        ),
      );
    } on CustomError catch (e) {
      emit(state.copyWith(status: GetKycStatus.error, error: e));
    }
  }
}
