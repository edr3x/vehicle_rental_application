part of 'recommended_vehicles_cubit.dart';

enum RecommendedVehiclesStatus { initial, loading, loaded, error }

class RecommendedVehiclesState extends Equatable {
  final RecommendedVehiclesStatus status;
  final CustomError error;
  final RecommendedVehiclesModel data;

  const RecommendedVehiclesState({
    required this.status,
    required this.error,
    required this.data,
  });

  factory RecommendedVehiclesState.initial() => RecommendedVehiclesState(
        status: RecommendedVehiclesStatus.initial,
        error: const CustomError(),
        data: RecommendedVehiclesModel.initial(),
      );

  @override
  List<Object> get props => [status, error, data];

  @override
  bool get stringify => true;

  RecommendedVehiclesState copyWith({
    RecommendedVehiclesStatus? status,
    CustomError? error,
    RecommendedVehiclesModel? data,
  }) {
    return RecommendedVehiclesState(
      status: status ?? this.status,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}
