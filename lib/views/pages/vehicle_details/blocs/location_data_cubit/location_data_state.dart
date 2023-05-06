part of 'location_data_cubit.dart';

class LocationDataState extends Equatable {
  final Placemark location;

  const LocationDataState({
    required this.location,
  });

  factory LocationDataState.initial() => LocationDataState(
        location: Placemark(
          name: "",
          administrativeArea: "",
          country: "",
          isoCountryCode: "",
          locality: "",
          postalCode: "",
          subAdministrativeArea: "",
          subLocality: "",
          subThoroughfare: "",
          thoroughfare: "",
        ),
      );

  @override
  List<Object> get props => [location];

  @override
  bool get stringify => true;

  LocationDataState copyWith({
    Placemark? location,
  }) {
    return LocationDataState(
      location: location ?? this.location,
    );
  }
}
