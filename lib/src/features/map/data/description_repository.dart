import 'package:audioplayers/audioplayers.dart';
import 'package:drive_tales/src/config.dart';

class DescriptionRepository {
  factory DescriptionRepository() => _singleton;

  DescriptionRepository._internal() : super();

  static final DescriptionRepository _singleton = DescriptionRepository._internal();
  final String _serverPath = descriptionServerPath;
  final String _apiKey = descriptionServerApiKey;

  Future<void> play({
    required AudioPlayer audioPlayer,
    required String name,
    required String type,
  }) async {
    final String path = '$_serverPath/description';
    final String query = '?name=$name&type=$type&key=$_apiKey';
    await audioPlayer.play(UrlSource('$path$query'));
  }
}
