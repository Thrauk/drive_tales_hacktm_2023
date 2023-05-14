import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:drive_tales/src/features/nearby_places/domain/nearby_place.dart';
import 'package:drive_tales/src/features/storage/data/user_storage_repository.dart';
import 'package:http/http.dart' as http;

class GooglePlacesRepository {
  factory GooglePlacesRepository() => _singleton;

  GooglePlacesRepository._internal() : super();

  static final GooglePlacesRepository _singleton = GooglePlacesRepository._internal();

  final String apiKey = 'AIzaSyBbzfvN3nL60lXMDhzCgn_X9qrGvwdWoMM';

  Future<List<NearbyPlace>> getAttractionsNear(double lat, double long, String userId) async {
    const String baseUrl = 'maps.googleapis.com';

    final queryParameters = <String, dynamic>{
      'location': '$lat,$long',
      'type': 'tourist_attraction',
      'rankby': 'distance',
      'key': 'AIzaSyBbzfvN3nL60lXMDhzCgn_X9qrGvwdWoMM',
    }..removeWhere((key, value) => value == null);
    final uri = Uri.https(baseUrl, '/maps/api/place/nearbysearch/json', queryParameters);
    print(uri);
    final response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final nextPageToken = body['next_page_token'];
    final returnedList = NearbyPlace.fromList(body['results'] as List);

    // final returnedListTemp = NearbyPlace.fromList(body['results'] as List);

    final visitedPlaces = await UserStorageRepository().getVisitedPlaces(authId: userId);
    for (final place in visitedPlaces) {
      print('Visited: ${place.placeName}');
    }

    returnedList.removeWhere((element) {
      final bannedTypes = ['casino', 'lodging'];
      for (final type in bannedTypes) {
        if (element.types.contains(type)) {
          return true;
        }
      }
      if (visitedPlaces.firstWhereOrNull(
            (place) => place.placeId == element.placeId,
          ) !=
          null) {
        return true;
      }
      if (element.permanentlyClosed) {
        return true;
      }

      return false;
    });
    // print('Found ${returnedList.length} places');
    // if (returnedList.isEmpty && returnedListTemp.isNotEmpty) {
    //   print(
    //       'Closest attraction is: ${returnedListTemp[0].name} at ${calculateDistance(lat, long, returnedListTemp[0].geometry.location.lat, returnedListTemp[0].geometry.location.lng)} meters');
    //   print('In vicinity of ${returnedListTemp[0].vicinity}');
    // }
    // for (final element in returnedList) {
    //   print('${element.permanentlyClosed}');
    //   print('${element.name} in vicinity of ${element.vicinity} with types: ${element.types}');
    // }
    return returnedList;
  }
}
