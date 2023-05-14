import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drive_tales/src/features/nearby_places/domain/nearby_place.dart';
import 'package:drive_tales/src/features/nearby_places/domain/visited_place.dart';

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
    await userCollection.doc(authId).set({
      'email': email,
      'authId': authId,
      'username': username,
      'visited_places': <Map<String, dynamic>>[],
    });
  }

  Future<void> addVisitedPlace({
    required String authId,
    required NearbyPlace place,
  }) async {
    await userCollection.doc(authId).update({
      'visited_places': FieldValue.arrayUnion(
        [
          {
            'place_id': place.placeId,
            'place_name': place.name,
          }
        ],
      ),
    });
  }

  Future<String> getDisplayName({
    required String authId,
  }) async {
    final snapshot = await userCollection.doc(authId).get();
    final body = snapshot.data() as Map<String, dynamic>;
    return body['username'];
  }

  Future<List<VisitedPlace>> getVisitedPlaces({
    required String authId,
  }) async {
    final snapshot = await userCollection.doc(authId).get();
    final body = snapshot.data() as Map<String, dynamic>;
    return VisitedPlace.fromList(body['visited_places']);
  }
}
