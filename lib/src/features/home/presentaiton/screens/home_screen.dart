import 'dart:async';

import 'package:drive_tales/src/design/dt_colors.dart';
import 'package:drive_tales/src/design/dt_text_styles.dart';
import 'package:drive_tales/src/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:drive_tales/src/features/authentication/presentation/screens/login_screen.dart';
import 'package:drive_tales/src/features/nearby_places/data/google_places_repository.dart';
import 'package:drive_tales/src/features/nearby_places/domain/nearby_place.dart';
import 'package:drive_tales/src/features/storage/data/user_storage_repository.dart';
import 'package:drive_tales/src/utils/operations.dart';
import 'package:drive_tales/src/widgets/dt_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
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
  late StreamController<Position> _attractionStreamController;
  late StreamSubscription<Position> _attractionStreamSubscription;

  late String userId;

  List<NearbyPlace> sessionVisited = [];

  NearbyPlace? selectedNearbyPlace;

  String? _mapStyle;
  bool placeInProgress = false;

  @override
  void initState() {
    super.initState();
    userId = BlocProvider.of<AuthBloc>(context).state.authUserData.id;

    _attractionStreamController = StreamController<Position>();
    _attractionStreamSubscription = _attractionStreamController.stream.listen((event) async {
      if (placeInProgress == false) {
        placeInProgress = true;

        final places = await GooglePlacesRepository().getAttractionsNear(
          event.latitude,
          event.longitude,
          userId,
        );

        if (places.isNotEmpty) {
          print(
              'Closest attraction is: ${places[0].name} at ${calculateDistance(event.latitude, event.longitude, places[0].geometry.location.lat, places[0].geometry.location.lng)} meters');
          print('In vicinity of ${places[0].vicinity}');

          setState(() {
            selectedNearbyPlace = places[0];
            sessionVisited.add(selectedNearbyPlace!);
          });

          await UserStorageRepository().addVisitedPlace(authId: userId, place: selectedNearbyPlace!);
        }

        await Future.delayed(const Duration(seconds: 10));
        setState(() {
          selectedNearbyPlace = null;
        });
        placeInProgress = false;
      }
    });
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
      )).listen((Position position) async {
        setState(() {
          currentLocation = LatLng(position.latitude, position.longitude);
          if (mapController != null) {
            mapController!.animateCamera(CameraUpdate.newLatLngZoom(currentLocation, 13));
          }
        });
        _attractionStreamController.add(position);
      });
    }
  }

  @override
  void dispose() {
    positionStream?.cancel();
    _attractionStreamSubscription.cancel();
    _attractionStreamController.close();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    controller.setMapStyle(_mapStyle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLocation == const LatLng(0, 0)
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                SizedBox(
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
                      ...sessionVisited
                          .map(
                            (place) => Marker(
                              markerId: MarkerId(
                                place.name,
                              ),
                              position: LatLng(place.geometry.location.lat, place.geometry.location.lng),
                            ),
                          )
                          .toList(),
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: DTButton(
                    height: 40,
                    // width: double.infinity,
                    onPressed: () async {
                      BlocProvider.of<AuthBloc>(context).add(LogOut(() {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                            (route) => false);
                      }));
                    },
                    child: Text(
                      'Log out',
                      style: DTTextStyles.regularBody(
                        color: DTColors.white,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 50,
                    ),
                    child: Container(
                      height: 80,
                      width: double.infinity,
                      color: Colors.blue,
                      child: Center(
                        child: Text(
                          selectedNearbyPlace != null
                              ? 'Now playing: ${selectedNearbyPlace!.name}'
                              : 'Searching for attractions...',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

      // DTButton(
      //   height: 40,
      //   width: double.infinity,
      //   onPressed: () async {
      //     LocationPermission permission;
      //     permission = await Geolocator.requestPermission();
      //     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      //     GooglePlacesRepository().getAttractionsNear(position.latitude, position.longitude);
      //   },
      //   child: Text(
      //     'Places',
      //     style: DTTextStyles.regularBody(
      //       color: DTColors.white,
      //     ),
      //   ),
      // ),
      //     ],
      //   ),
      // ),
    );
  }
}
