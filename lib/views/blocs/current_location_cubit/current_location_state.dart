part of 'current_location_cubit.dart';

enum LocationStatus {
  initial,
  loading,
  success,
  error,
}

class CurrentLocationState extends Equatable {
  final Position position;
  final LocationStatus status;

  const CurrentLocationState({
    required this.position,
    required this.status,
  });

  factory CurrentLocationState.initial() => CurrentLocationState(
        status: LocationStatus.initial,
        position: Position(
          latitude: 0,
          longitude: 0,
          speedAccuracy: 0,
          speed: 0,
          heading: 0,
          altitude: 0,
          accuracy: 0,
          timestamp: DateTime.now(),
        ),
      );

  @override
  List<Object> get props => [position, status];

  @override
  bool get stringify => true;

  CurrentLocationState copyWith({
    Position? position,
    LocationStatus? status,
  }) {
    return CurrentLocationState(
      position: position ?? this.position,
      status: status ?? this.status,
    );
  }
}
