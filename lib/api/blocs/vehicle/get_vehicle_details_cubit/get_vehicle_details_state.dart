part of 'get_vehicle_details_cubit.dart';

enum GetVehicleDetailsStatus {
  initial,
  loading,
  loaded,
  error,
}

class GetVehicleDetailsState extends Equatable {
  final GetVehicleDetailsStatus status;
  final CustomError error;
  final VehicleDetailsModel data;

  const GetVehicleDetailsState({
    required this.status,
    required this.error,
    required this.data,
  });

  factory GetVehicleDetailsState.initial() => GetVehicleDetailsState(
        status: GetVehicleDetailsStatus.initial,
        error: const CustomError(),
        data: VehicleDetailsModel.initial(),
      );

  @override
  List<Object> get props => [status, error, data];

  @override
  bool get stringify => true;

  GetVehicleDetailsState copyWith({
    GetVehicleDetailsStatus? status,
    CustomError? error,
    VehicleDetailsModel? data,
  }) {
    return GetVehicleDetailsState(
      status: status ?? this.status,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}
