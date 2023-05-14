import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:drive_tales/src/config.dart';
import 'package:http/http.dart' as http;

enum DescriptionType {
  factual,
  historical,
  financial,
  geographic,
  none,
}

extension DescriptionTypeExtension on DescriptionType {
  String get value {
    switch (this) {
      case DescriptionType.factual:
        return 'factual';
      case DescriptionType.historical:
        return 'historical';
      case DescriptionType.financial:
        return 'financial';
      case DescriptionType.geographic:
        return 'geographic';
      case DescriptionType.none:
        return '';
    }
  }
}

class DescriptionRepository {
  factory DescriptionRepository() => _singleton;

  DescriptionRepository._internal() : super();

  static final DescriptionRepository _singleton = DescriptionRepository._internal();
  final String _serverPath = descriptionServerPath;
  // final String _apiKey = descriptionServerApiKey;

  Future<String> _postDescriptionRequest({
    required String name,
    required DescriptionType type,
  }) async {
    final Map<String, String> queryParameters = {
      // 'location': 'a $type description of $name',
      'name': name,
      'type': type.value,
    };

    final Uri uri = Uri.http(_serverPath, '/api/v1/describe', queryParameters);
    final response = await http.post(uri);
    if (response.body.isEmpty) {
      // Invalid response
      return '';
    }
    final responseJson = jsonDecode(response.body).cast<String, dynamic>();
    if (responseJson['uuid'] == null) {
      // Invalid response
      return '';
    }
    final String uuid = responseJson['uuid'] as String;
    return uuid;
  }

  Future<void> play({
    required AudioPlayer audioPlayer,
    required String name,
    required DescriptionType type,
  }) async {
    final String uuid = await _postDescriptionRequest(name: name, type: type);

    final Uri uri = Uri.http(_serverPath, '/api/v1/audio/$uuid');
    await audioPlayer.play(UrlSource(uri.toString()));
  }

  Future<void> stop({
    required AudioPlayer audioPlayer,
  }) async {
    final Uri uri = Uri.http(_serverPath, '/api/v1/audio/5fe1384d-4310-487f-a7ce-5b016f22eb23');
    await audioPlayer.play(UrlSource(uri.toString()));
  }
}
