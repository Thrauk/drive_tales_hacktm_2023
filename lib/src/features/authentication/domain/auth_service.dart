import 'package:drive_tales/src/features/authentication/data/auth_repository.dart';
import 'package:drive_tales/src/features/storage/data/user_storage_repository.dart';

class AuthService {
  factory AuthService() => _singleton;

  AuthService._internal() : super();

  static final AuthService _singleton = AuthService._internal();

  Future<void> createUserAccount({
    required String username,
    required String emailAddress,
    required String password,
  }) async {
    try {
      final userData = await AuthRepository().registerWithEmailAndPassword(
        emailAddress: emailAddress,
        password: password,
      );
      final authId = userData!.id;
      UserStorageRepository().createUserData(
        email: emailAddress,
        authId: authId,
        username: username,
      );
    } catch (_) {
      print('User serivce error: $_');
    }
  }
}
