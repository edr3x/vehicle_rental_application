part of 'get_vehicle_near_me_cubit.dart';

enum GetVehicleNearMeConnectionStatus {
  initial,
  loading,
  loaded,
  error,
}

class GetVehicleNearMeState extends Equatable {
  final GetVehicleNearMeConnectionStatus status;
  final CustomError error;
  final VehicleNearMeModel data;

  const GetVehicleNearMeState({
    required this.status,
    required this.error,
    required this.data,
  });

  factory GetVehicleNearMeState.initial() => GetVehicleNearMeState(
        status: GetVehicleNearMeConnectionStatus.initial,
        error: const CustomError(),
        data: VehicleNearMeModel.initial(),
      );

  @override
  List<Object> get props => [status, error, data];

  @override
  bool get stringify => true;

  GetVehicleNearMeState copyWith({
    GetVehicleNearMeConnectionStatus? status,
    CustomError? error,
    VehicleNearMeModel? data,
  }) {
    return GetVehicleNearMeState(
      status: status ?? this.status,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}
