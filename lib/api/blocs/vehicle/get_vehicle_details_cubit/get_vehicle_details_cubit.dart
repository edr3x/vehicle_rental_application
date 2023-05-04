import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rental_system_app/api/models/vehicle/vehicle_details_model.dart';
import 'package:rental_system_app/excepitions/custom_error.dart';

part 'get_vehicle_details_state.dart';

class GetVehicleDetailsCubit extends Cubit<GetVehicleDetailsState> {
  GetVehicleDetailsCubit() : super(GetVehicleDetailsState.initial());
}
