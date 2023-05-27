part of 'search_vehicle_cubit.dart';

enum SearchVehicleStatus { initial, loading, loaded, error }

class SearchVehicleState extends Equatable {
  final SearchVehicleStatus status;
  final CustomError error;
  final SearchVehicleModel data;

  const SearchVehicleState({
    required this.status,
    required this.error,
    required this.data,
  });

  factory SearchVehicleState.initial() => SearchVehicleState(
        status: SearchVehicleStatus.initial,
        error: const CustomError(),
        data: SearchVehicleModel.initial(),
      );

  @override
  List<Object> get props => [status, error, data];

  @override
  bool get stringify => true;

  SearchVehicleState copyWith({
    SearchVehicleStatus? status,
    CustomError? error,
    SearchVehicleModel? data,
  }) {
    return SearchVehicleState(
      status: status ?? this.status,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}
