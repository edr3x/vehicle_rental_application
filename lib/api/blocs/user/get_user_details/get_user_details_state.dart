part of 'get_user_details_cubit.dart';

enum GetUserDetailsStatus {
  initial,
  loading,
  loaded,
  error,
}

class GetUserDetailsState extends Equatable {
  final GetUserDetailsStatus status;
  final CustomError error;
  final GetUserDataModel data;

  const GetUserDetailsState({
    required this.status,
    required this.error,
    required this.data,
  });

  factory GetUserDetailsState.initial() => GetUserDetailsState(
      status: GetUserDetailsStatus.initial,
      error: const CustomError(),
      data: GetUserDataModel.initial());

  @override
  List<Object> get props => [status, error, data];

  @override
  bool get stringify => true;

  GetUserDetailsState copyWith({
    GetUserDetailsStatus? status,
    CustomError? error,
    GetUserDataModel? data,
  }) {
    return GetUserDetailsState(
      status: status ?? this.status,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}
