import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';

part 'location_data_state.dart';

class LocationDataCubit extends Cubit<LocationDataState> {
  LocationDataCubit() : super(LocationDataState.initial());

  Future<void> locationInfo({
    required String latitude,
    required String longitude,
  }) async {
    List<Placemark> place = await placemarkFromCoordinates(
      double.parse(latitude),
      double.parse(longitude),
    );
    emit(state.copyWith(location: place[0]));
  }
}
