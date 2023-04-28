import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rental_system_app/api/models/user/update_basic_details_model.dart';
import 'package:rental_system_app/api/repo/user_repo.dart';

import '../../../../excepitions/custom_error.dart';

part 'post_user_data_state.dart';

class PostUserDataCubit extends Cubit<PostUserDataState> {
  final UserRepository userRepository;

  PostUserDataCubit({
    required this.userRepository,
  }) : super(PostUserDataState.initial());

  Future<void> updateUserDetails({
    required String fullName,
    required String gender, //note: "male" | "female" | "other"
    required String email,
  }) async {
    emit(state.copyWith(status: PostUserDataStatus.loading));
    try {
      final UpdateBasicUserDetailsModel userDetailsUpdate =
          await userRepository.updateBasicUserDetail(
        email: email,
        gender: gender,
        fullName: fullName,
      );

      emit(
        state.copyWith(
          status: PostUserDataStatus.loaded,
          data: userDetailsUpdate,
        ),
      );
    } on CustomError catch (e) {
      emit(state.copyWith(status: PostUserDataStatus.error, error: e));
    }
  }
}
