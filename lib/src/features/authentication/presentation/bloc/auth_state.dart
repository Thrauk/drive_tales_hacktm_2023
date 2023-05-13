part of 'auth_bloc.dart';

enum AppStatus { authenticated, unauthenticated }

class AuthState extends Equatable {
  const AuthState._({
    required this.status,
    this.authUserData = AuthUserData.empty,
  });

  const AuthState.authenticated(AuthUserData user) : this._(status: AppStatus.authenticated, authUserData: user);

  const AuthState.unauthenticated() : this._(status: AppStatus.unauthenticated, authUserData: AuthUserData.empty);

  final AppStatus status;
  final AuthUserData authUserData;
  bool get isAuthenticated => authUserData != AuthUserData.empty;

  AuthState copyWith({
    AppStatus? status,
    AuthUserData? authUserData,
  }) {
    return AuthState._(
      status: status ?? this.status,
      authUserData: authUserData ?? this.authUserData,
    );
  }

  @override
  List<Object> get props => <Object>[status, authUserData];
}