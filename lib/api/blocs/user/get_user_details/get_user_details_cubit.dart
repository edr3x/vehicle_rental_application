import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rental_system_app/api/models/user/get_user_data_model.dart';
import 'package:rental_system_app/api/repo/user_repo.dart';
import 'package:rental_system_app/excepitions/custom_error.dart';

part 'get_user_details_state.dart';

class GetUserDetailsCubit extends Cubit<GetUserDetailsState> {
  final UserRepository userRepository;

  GetUserDetailsCubit({required this.userRepository}) : super(GetUserDetailsState.initial());

  Future<void> getUserDetails() async {
    emit(state.copyWith(status: GetUserDetailsStatus.loading));
    try {
      final GetUserDataModel response = await userRepository.getUserDetails();

      emit(
        state.copyWith(
          status: GetUserDetailsStatus.loaded,
          data: response,
        ),
      );
    } on CustomError catch (e) {
      emit(state.copyWith(status: GetUserDetailsStatus.error, error: e));
    }
  }
}
