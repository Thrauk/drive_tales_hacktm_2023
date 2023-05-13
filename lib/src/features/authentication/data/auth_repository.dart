import 'package:drive_tales/src/features/authentication/domain/auth_user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthRepository {
  factory AuthRepository() => _singleton;

  AuthRepository._internal() : super();

  static final AuthRepository _singleton = AuthRepository._internal();
  final FirebaseAuth _authInstance = FirebaseAuth.instance;

  Future<AuthUserData?> registerWithEmailAndPassword({
    required String emailAddress,
    required String password,
    // required String username,
  }) async {
    try {
      final credential = await _authInstance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return credential.user?.toUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (kDebugMode) {
          print('The password provided is too weak.');
        }
      } else if (e.code == 'email-already-in-use') {
        if (kDebugMode) {
          print('The account already exists for that email.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  Future<AuthUserData?> loginWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    try {
      final credential = await _authInstance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return credential.user?.toUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) {
          print('No user found for that email.');
        }
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print('Wrong password provided for that user.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  Future<void> logOut() async {
    await _authInstance.signOut();
  }

  Stream<AuthUserData> get userData {
    return _authInstance.authStateChanges().map((User? firebaseUser) {
      final userData = firebaseUser == null ? AuthUserData.empty : firebaseUser.toUser;
      return userData;
    });
  }

  AuthUserData get currentUserData {
    final firebaseUser = _authInstance.currentUser;
    final userData = firebaseUser == null ? AuthUserData.empty : firebaseUser.toUser;
    return userData;
  }
}

extension on User {
  AuthUserData get toUser {
    return AuthUserData(id: uid, email: email, displayName: displayName, photo: photoURL);
  }
}