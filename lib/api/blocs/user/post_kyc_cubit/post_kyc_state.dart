part of 'post_kyc_cubit.dart';

enum PostKycStatus { initial, loading, loaded, error }

class PostKycState extends Equatable {
  final PostKycStatus status;
  final CustomError error;
  final PostKycModel postKycModel;

  const PostKycState({
    required this.status,
    required this.error,
    required this.postKycModel,
  });

  factory PostKycState.initial() => PostKycState(
        status: PostKycStatus.initial,
        error: const CustomError(),
        postKycModel: PostKycModel.initial(),
      );

  @override
  List<Object> get props => [status, error, postKycModel];

  @override
  bool get stringify => true;

  PostKycState copyWith({
    PostKycStatus? status,
    CustomError? error,
    PostKycModel? postKycModel,
  }) {
    return PostKycState(
      status: status ?? this.status,
      error: error ?? this.error,
      postKycModel: postKycModel ?? this.postKycModel,
    );
  }
}
