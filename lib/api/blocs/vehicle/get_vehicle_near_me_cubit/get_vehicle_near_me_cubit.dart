import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rental_system_app/api/models/vehicle/vehicle_near_me_model.dart';
import 'package:rental_system_app/api/repo/vehicle_repo.dart';
import 'package:rental_system_app/excepitions/custom_error.dart';
import 'package:rental_system_app/views/blocs/current_page_cubit/current_page_cubit.dart';

part 'get_vehicle_near_me_state.dart';

class GetVehicleNearMeCubit extends Cubit<GetVehicleNearMeState> {
  String category = "all";

  late StreamSubscription pageSubscription;
  final CurrentPageCubit currentPageCubit;

  final VehicleRepository vehicleRepository;

  GetVehicleNearMeCubit({
    required this.vehicleRepository,
    required this.currentPageCubit,
  }) : super(GetVehicleNearMeState.initial()) {
    pageSubscription = currentPageCubit.stream.listen((CurrentPageState pageState) {
      if (pageState.currentPageIndex == 0) {
        category = "all";
      } else if (pageState.currentPageIndex == 1) {
        category = "bike";
      } else if (pageState.currentPageIndex == 2) {
        category = "car";
      } else if (pageState.currentPageIndex == 3) {
        category = "bicycle";
      }
    });
  }

  Future<void> getNearbyVehicle({
    required Position position,
  }) async {
    emit(state.copyWith(status: GetVehicleNearMeConnectionStatus.loading));
    try {
      final VehicleNearMeModel response = await vehicleRepository.getNearbyVehicle(
        lat: "${position.latitude}",
        lon: "${position.longitude}",
        category: category,
      );

      emit(
        state.copyWith(
          status: GetVehicleNearMeConnectionStatus.loaded,
          data: response,
        ),
      );
    } on CustomError catch (e) {
      emit(state.copyWith(status: GetVehicleNearMeConnectionStatus.error, error: e));
    }
  }

  @override
  Future<void> close() {
    pageSubscription.cancel();
    return super.close();
  }
}
