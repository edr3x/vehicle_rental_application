import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rental_system_app/api/models/user/post_kyc_model.dart';
import 'package:rental_system_app/api/repo/user_repo.dart';
import 'package:rental_system_app/excepitions/custom_error.dart';

part 'post_kyc_state.dart';

class PostKycCubit extends Cubit<PostKycState> {
  final UserRepository userRepository;

  PostKycCubit({
    required this.userRepository,
  }) : super(PostKycState.initial());

  Future<void> postKyc({
    required String frontImage,
    required String backImage,
    required String citizenshipNo,
    required String issuedDistrict,
    required String issuedDate,
  }) async {
    emit(state.copyWith(status: PostKycStatus.loading));
    try {
      final PostKycModel postKycModel = await userRepository.postKycService.data(
        frontImage: frontImage,
        backImage: backImage,
        citizenshipNo: citizenshipNo,
        issuedDistrict: issuedDistrict,
        issuedDate: issuedDate,
      );

      emit(
        state.copyWith(
          status: PostKycStatus.loaded,
          postKycModel: postKycModel,
        ),
      );
    } on CustomError catch (e) {
      emit(state.copyWith(status: PostKycStatus.error, error: e));
    }
  }
}
