part of 'post_user_data_cubit.dart';

enum PostUserDataStatus {
  initial,
  loading,
  loaded,
  error,
}

class PostUserDataState extends Equatable {
  final PostUserDataStatus status;
  final CustomError error;
  final UpdateBasicUserDetailsModel data;

  factory PostUserDataState.initial() => PostUserDataState(
        status: PostUserDataStatus.initial,
        error: const CustomError(),
        data: UpdateBasicUserDetailsModel.initial(),
      );

  const PostUserDataState({
    required this.status,
    required this.error,
    required this.data,
  });

  @override
  List<Object> get props => [status, error, data];

  @override
  bool get stringify => true;

  PostUserDataState copyWith({
    PostUserDataStatus? status,
    CustomError? error,
    UpdateBasicUserDetailsModel? data,
  }) {
    return PostUserDataState(
      status: status ?? this.status,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}
