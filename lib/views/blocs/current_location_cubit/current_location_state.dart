part of 'current_location_cubit.dart';

class CurrentLocationState extends Equatable {
  final Position position;

  const CurrentLocationState({required this.position});

  factory CurrentLocationState.initial() => CurrentLocationState(
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
  List<Object> get props => [position];

  @override
  bool get stringify => true;

  CurrentLocationState copyWith({
    Position? position,
  }) {
    return CurrentLocationState(
      position: position ?? this.position,
    );
  }
}
