import 'dart:io';

import 'package:drive_tales/src/features/nearby_places/domain/nearby_place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GooglePlacesRepository {
  factory GooglePlacesRepository() => _singleton;

  GooglePlacesRepository._internal() : super();

  static final GooglePlacesRepository _singleton = GooglePlacesRepository._internal();

  final String apiKey = 'AIzaSyDHEPkGprEaFiA43ffZaXwymaxqNab-Dfo';


  Future<List<NearbyPlace>> getAttractionsNear(String lat, String long) async {
    const String baseUrl =
        'maps.googleapis.com';

    final queryParameters = <String, dynamic>{
      'location': '$lat,$long',
      'type': 'tourist_attraction',
      'rankby': 'distance',
      'key': 'AIzaSyDHEPkGprEaFiA43ffZaXwymaxqNab-Dfo',
    }..removeWhere((key, value) => value == null);
    final uri = Uri.https(baseUrl, '/maps/api/place/nearbysearch/json', queryParameters);
    print(uri);

    final response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    print(body);
    final nextPageToken = body['next_page_token'];
    final returnedList = NearbyPlace.fromList(body['results'] as List);
    returnedList.removeWhere((element) {
      final bannedTypes = ['casino', 'lodging'];
      for(final type in bannedTypes) {
        if(element.types.contains(type)) {
          return true;
        }
      }
      return false;
    });
    for(final element in returnedList) {
      print('${element.name} in vicinity of ${element.vicinity} with types: ${element.types}');
      print(element.);
    }
    return returnedList;

  }

}