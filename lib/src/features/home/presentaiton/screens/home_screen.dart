import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:drive_tales/src/features/map/data/description_repository.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController? mapController;
  LatLng currentLocation = const LatLng(0, 0);
  StreamSubscription<Position>? positionStream;
  String? _mapStyle;
  DescriptionRepository descriptionRepository = DescriptionRepository();
  AudioPlayer? audioPlayer;

  @override
  void initState() {
    super.initState();
    getLocation();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

  void getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Handle the case when location permission is denied
    } else if (permission == LocationPermission.deniedForever) {
      // Handle the case when location permission is denied forever
    } else {
      positionStream = Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      )).listen((Position position) {
        setState(() {
          currentLocation = LatLng(position.latitude, position.longitude);
          if (mapController != null) {
            mapController!.animateCamera(CameraUpdate.newLatLngZoom(currentLocation, 15));
          }
        });
      });
    }
  }

  @override
  void dispose() {
    positionStream?.cancel();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    controller.setMapStyle(_mapStyle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        if (audioPlayer != null) {
          audioPlayer!.stop();
        }
        audioPlayer = AudioPlayer();
        descriptionRepository.play(
            audioPlayer: audioPlayer!, name: "Podul de Fier din Lugoj", type: DescriptionType.historical);
      }),
      body: currentLocation == const LatLng(0, 0)
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                scrollGesturesEnabled: false,
                rotateGesturesEnabled: false,
                tiltGesturesEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: currentLocation,
                  zoom: 15.0,
                ),
                onMapCreated: _onMapCreated,
                markers: <Marker>{
                  Marker(
                    markerId: const MarkerId('currentLocation'),
                    position: currentLocation,
                  ),
                },
              ),
            ),
    );
  }
}
