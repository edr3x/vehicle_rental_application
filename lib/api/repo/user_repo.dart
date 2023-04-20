import 'package:rental_system_app/api/models/user/update_basic_details_model.dart';
import 'package:rental_system_app/excepitions/custom_error.dart';

import '../../excepitions/data_exception.dart';
import '../services/user_services.dart';

class UserRepository {
  final UpdateBasicUserDetailsService updateBasicUserDetailsService;

  UserRepository({required this.updateBasicUserDetailsService});

  Future<UpdateBasicUserDetailsModel> updateBasicUserDetail({
    required String fullName,
    required String gender, //note: "male" | "female" | "other"
    required String email,
  }) async {
    try {
      final UpdateBasicUserDetailsModel updateUserDetails = await updateBasicUserDetailsService
          .data(email: email, fullName: fullName, gender: gender);

      return updateUserDetails;
    } on DataException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }
}