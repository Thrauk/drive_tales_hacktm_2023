import 'package:cloud_firestore/cloud_firestore.dart';

class UserStorageRepository {
  factory UserStorageRepository() => _singleton;

  UserStorageRepository._internal() : super();

  static final UserStorageRepository _singleton = UserStorageRepository._internal();

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future<void> createUserData({
    required String email,
    required String authId,
    required String username,
  }) async {
    await userCollection.add({
      'email': email,
      'authId': authId,
      'username': username,
    });
  }
}
