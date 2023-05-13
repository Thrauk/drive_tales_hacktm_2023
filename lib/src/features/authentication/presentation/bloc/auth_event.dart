part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthDataChanged extends AuthEvent {
  AuthDataChanged(this.userData);

  final AuthUserData userData;
}

class UserLoggedIn extends AuthEvent {
  UserLoggedIn(this.userData);

  final AuthUserData userData;
}

class LogInWithEmailAndPass extends AuthEvent {
  LogInWithEmailAndPass({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

class RegisterWithEmailAndPass extends AuthEvent {
  RegisterWithEmailAndPass({
    required this.email,
    required this.password,
    required this.username,
  });

  final String email;
  final String password;
  final String username;
}

class AuthenticateWithGoogle extends AuthEvent {

}

class LogOut extends AuthEvent {
  LogOut(this.callback);
  final VoidCallback callback;
}