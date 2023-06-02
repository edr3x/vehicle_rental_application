part of 'get_kyc_cubit.dart';

enum GetKycStatus { initial, loading, loaded, error }

class GetKycState extends Equatable {
  final GetKycStatus status;
  final CustomError error;
  final GetKycModel data;

  const GetKycState({
    required this.status,
    required this.error,
    required this.data,
  });

  factory GetKycState.initial() => GetKycState(
        status: GetKycStatus.initial,
        error: const CustomError(),
        data: GetKycModel.initial(),
      );

  @override
  List<Object> get props => [status, error, data];

  @override
  bool get stringify => true;

  GetKycState copyWith({
    GetKycStatus? status,
    CustomError? error,
    GetKycModel? data,
  }) {
    return GetKycState(
      status: status ?? this.status,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}
