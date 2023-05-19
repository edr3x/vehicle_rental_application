part of 'add_vehicle_cubit.dart';

enum AddVehicleStatus { initial, loading, loaded, error }

class AddVehicleState extends Equatable {
  final AddVehicleStatus status;
  final CustomError error;
  final AddVehicleResponseModel data;

  const AddVehicleState({
    required this.status,
    required this.error,
    required this.data,
  });

  factory AddVehicleState.initial() => AddVehicleState(
        status: AddVehicleStatus.initial,
        error: const CustomError(),
        data: AddVehicleResponseModel.initial(),
      );

  @override
  List<Object> get props => [status, error, data];

  @override
  bool get stringify => true;

  AddVehicleState copyWith({
    AddVehicleStatus? status,
    CustomError? error,
    AddVehicleResponseModel? data,
  }) {
    return AddVehicleState(
      status: status ?? this.status,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}
