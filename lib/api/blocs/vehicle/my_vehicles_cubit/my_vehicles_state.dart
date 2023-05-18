part of 'my_vehicles_cubit.dart';

enum MyVehiclesStatus { initial, loading, loaded, error }

class MyVehiclesState extends Equatable {
  final MyVehiclesStatus status;
  final CustomError error;
  final MyVehiclesModel data;

  const MyVehiclesState({
    required this.status,
    required this.error,
    required this.data,
  });

  factory MyVehiclesState.initial() => MyVehiclesState(
        status: MyVehiclesStatus.initial,
        error: const CustomError(),
        data: MyVehiclesModel.initial(),
      );

  @override
  List<Object> get props => [status, error, data];

  @override
  bool get stringify => true;

  MyVehiclesState copyWith({
    MyVehiclesStatus? status,
    CustomError? error,
    MyVehiclesModel? data,
  }) {
    return MyVehiclesState(
      status: status ?? this.status,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}
