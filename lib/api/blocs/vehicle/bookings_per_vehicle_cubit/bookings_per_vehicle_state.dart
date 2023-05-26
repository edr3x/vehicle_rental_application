part of 'bookings_per_vehicle_cubit.dart';

enum BookingsPerVehicleStatus { initial, loading, loaded, error }

class BookingsPerVehicleState extends Equatable {
  final BookingsPerVehicleStatus status;
  final BookingsPerVehicleModel data;
  final CustomError error;

  const BookingsPerVehicleState({
    required this.status,
    required this.data,
    required this.error,
  });

  factory BookingsPerVehicleState.initial() => BookingsPerVehicleState(
        status: BookingsPerVehicleStatus.initial,
        data: BookingsPerVehicleModel.initial(),
        error: const CustomError(),
      );

  @override
  List<Object> get props => [status, data, error];

  @override
  bool get stringify => true;

  BookingsPerVehicleState copyWith({
    BookingsPerVehicleStatus? status,
    BookingsPerVehicleModel? data,
    CustomError? error,
  }) {
    return BookingsPerVehicleState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }
}
