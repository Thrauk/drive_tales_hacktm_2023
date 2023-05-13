import 'dart:async';

import 'package:drive_tales/src/features/authentication/data/auth_repository.dart';
import 'package:drive_tales/src/features/authentication/domain/auth_service.dart';
import 'package:drive_tales/src/features/authentication/domain/auth_user_data.dart';
import 'package:drive_tales/src/features/storage/data/user_storage_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc()
      : super(
          AuthRepository().currentUserData.isNotEmpty
              ? AuthState.authenticated(AuthRepository().currentUserData)
              : const AuthState.unauthenticated(),
        ) {
    on<AuthDataChanged>(_onAuthDataChangedChanged);
    on<UserLoggedIn>(_onUserLoggedIn);
    on<LogInWithEmailAndPass>(_onLogInWithEmailAndPass);
    on<RegisterWithEmailAndPass>(_onRegisterWithEmailAndPass);
    on<LogOut>(_onLogOut);

    /// Start authentication data stream listener. If user logs in or logs out, the app is going to register this event.
    /// This is generally used for the decision to render the login or home page on startup (might implement redirect?)
    /// This won't trigger after a successful register. After we create an account, we must manually navigate to the
    /// next page.
    _userSubscription = _authRepository.userData.listen((AuthUserData userData) {
      add(AuthDataChanged(userData));
    });
  }

  late final StreamSubscription<AuthUserData> _userSubscription;
  final AuthRepository _authRepository = AuthRepository();
  final AuthService _authService = AuthService();

  void _onAuthDataChangedChanged(AuthDataChanged event, Emitter<AuthState> emit) {
    if (kDebugMode) {
      print('User changed');
    }

    if (event.userData.isNotEmpty) {
      add(UserLoggedIn(event.userData));
    }

    emit(
      event.userData.isNotEmpty ? AuthState.authenticated(event.userData) : const AuthState.unauthenticated(),
    );
  }

  Future<void> _onUserLoggedIn(UserLoggedIn event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authUserData: event.userData));
  }

  Future<void> _onLogOut(LogOut event, Emitter<AuthState> emit) async {
    await _authRepository.logOut();
    event.callback.call();
  }

  Future<void> _onLogInWithEmailAndPass(LogInWithEmailAndPass event, Emitter<AuthState> emit) async {
    await _authRepository.loginWithEmailAndPassword(
      emailAddress: event.email,
      password: event.password,
    );
  }

  Future<void> _onRegisterWithEmailAndPass(RegisterWithEmailAndPass event, Emitter<AuthState> emit) async {
    final userData = await _authRepository.registerWithEmailAndPassword(
      emailAddress: event.email,
      password: event.password,
    );
    await UserStorageRepository().createUserData(
      email: event.email,
      authId: userData!.id,
      username: event.username,
    );
    emit(state.copyWith(authUserData: userData));
  }

  @override
  Future<void> close() async {
    await _userSubscription.cancel();
    return super.close();
  }
}
