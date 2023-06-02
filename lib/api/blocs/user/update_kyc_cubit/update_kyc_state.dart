part of 'update_kyc_cubit.dart';

enum UpdateKycStatus { initial, loading, loaded, error }

class UpdateKycState extends Equatable {
  final UpdateKycStatus status;
  final CustomError error;
  final PostKycModel data;

  const UpdateKycState({
    required this.status,
    required this.error,
    required this.data,
  });

  factory UpdateKycState.initial() => UpdateKycState(
        status: UpdateKycStatus.initial,
        error: const CustomError(),
        data: PostKycModel.initial(),
      );

  @override
  List<Object> get props => [status, error, data];

  @override
  bool get stringify => true;

  UpdateKycState copyWith({
    UpdateKycStatus? status,
    CustomError? error,
    PostKycModel? data,
  }) {
    return UpdateKycState(
      status: status ?? this.status,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}
