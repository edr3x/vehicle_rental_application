part of 'update_address_cubit.dart';

enum UpdateAddressStatus {
  initial,
  loading,
  loaded,
  error,
}

class UpdateAddressState extends Equatable {
  final UpdateAddressStatus status;
  final CustomError error;
  final UpdateAddressModel data;

  const UpdateAddressState({
    required this.status,
    required this.error,
    required this.data,
  });

  factory UpdateAddressState.initial() => UpdateAddressState(
        status: UpdateAddressStatus.initial,
        error: const CustomError(),
        data: UpdateAddressModel.initial(),
      );

  @override
  List<Object> get props => [status, error, data];

  @override
  bool get stringify => true;

  UpdateAddressState copyWith({
    UpdateAddressStatus? status,
    CustomError? error,
    UpdateAddressModel? data,
  }) {
    return UpdateAddressState(
      status: status ?? this.status,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}
