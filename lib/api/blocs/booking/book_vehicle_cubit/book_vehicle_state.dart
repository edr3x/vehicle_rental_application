part of 'book_vehicle_cubit.dart';

enum BookVehicleStatus {
  initial,
  loading,
  loaded,
  error,
}

class BookVehicleState extends Equatable {
  final BookVehicleStatus status;
  final CustomError error;
  final BookVehicleModel data;

  const BookVehicleState({
    required this.status,
    required this.error,
    required this.data,
  });

  factory BookVehicleState.initial() => BookVehicleState(
        status: BookVehicleStatus.initial,
        error: const CustomError(),
        data: BookVehicleModel.initial(),
      );

  @override
  List<Object> get props => [status, error, data];

  @override
  bool get stringify => true;

  BookVehicleState copyWith({
    BookVehicleStatus? status,
    CustomError? error,
    BookVehicleModel? data,
  }) {
    return BookVehicleState(
      status: status ?? this.status,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}
