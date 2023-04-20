import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rental_system_app/utils/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.initial());

  Future<void> isAutneticated() async {
    emit(state.copyWith(status: AuthStatus.unknown));

    try {
      final String token = await UtilSharedPreferences.getToken();

      if (token.isEmpty) {
        emit(state.copyWith(status: AuthStatus.unauthenticated));
      } else {
        emit(state.copyWith(status: AuthStatus.authenticated, token: token));
      }
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    }
  }
}
