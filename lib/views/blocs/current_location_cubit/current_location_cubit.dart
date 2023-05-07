import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'current_location_state.dart';

class CurrentLocationCubit extends Cubit<CurrentLocationState> {
  CurrentLocationCubit() : super(CurrentLocationState.initial());

  Future<void> currentLocation() async {
    emit(state.copyWith(status: LocationStatus.loading));
    try {
      final Position position = await Geolocator.getCurrentPosition();

      emit(state.copyWith(status: LocationStatus.success, position: position));
    } catch (e) {
      print("Error: $e");
    }
  }
}
