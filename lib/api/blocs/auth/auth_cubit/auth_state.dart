part of 'auth_cubit.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState extends Equatable {
  final AuthStatus status;
  final String token;

  const AuthState({
    required this.status,
    required this.token,
  });

  factory AuthState.initial() => const AuthState(
        status: AuthStatus.unknown,
        token: "",
      );

  @override
  List<Object> get props => [status, token];

  @override
  bool get stringify => true;

  AuthState copyWith({
    AuthStatus? status,
    String? token,
  }) {
    return AuthState(
      status: status ?? this.status,
      token: token ?? this.token,
    );
  }
}
