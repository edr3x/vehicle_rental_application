part of 'my_bookings_cubit.dart';

enum MyBookingsStatus {
  initial,
  loading,
  loaded,
  error,
}

class MyBookingsState extends Equatable {
  final MyBookingsStatus status;
  final CustomError error;
  final MyBookingsModel myBookings;

  const MyBookingsState({
    required this.status,
    required this.error,
    required this.myBookings,
  });

  factory MyBookingsState.initial() => MyBookingsState(
        status: MyBookingsStatus.initial,
        error: const CustomError(),
        myBookings: MyBookingsModel.initial(),
      );

  @override
  List<Object> get props => [status, error, myBookings];

  @override
  bool get stringify => true;

  MyBookingsState copyWith({
    MyBookingsStatus? status,
    CustomError? error,
    MyBookingsModel? myBookings,
  }) {
    return MyBookingsState(
      status: status ?? this.status,
      error: error ?? this.error,
      myBookings: myBookings ?? this.myBookings,
    );
  }
}
