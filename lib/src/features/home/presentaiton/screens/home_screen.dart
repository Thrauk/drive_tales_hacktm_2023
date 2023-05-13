import 'package:drive_tales/src/design/dt_colors.dart';
import 'package:drive_tales/src/design/dt_text_styles.dart';
import 'package:drive_tales/src/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:drive_tales/src/features/authentication/presentation/screens/login_screen.dart';
import 'package:drive_tales/src/features/nearby_places/data/google_places_repository.dart';
import 'package:drive_tales/src/widgets/dt_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: DTColors.navyBlue,
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 35, right: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 240,
                    child: Image.asset('assets/logo_clean.png'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 26,
            ),
            Text(
              'Home',
              style: DTTextStyles.h1,
            ),
            DTButton(
              height: 40,
              width: double.infinity,
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(
                  LogOut(
                    () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                          (route) => false);
                    },
                  ),
                );
              },
              child: Text(
                'Log out',
                style: DTTextStyles.regularBody(
                  color: DTColors.white,
                ),
              ),
            ),
            DTButton(
              height: 40,
              width: double.infinity,
              onPressed: () async {
                LocationPermission permission;
                permission = await Geolocator.requestPermission();
                Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                GooglePlacesRepository().getAttractionsNear(position.latitude, position.longitude);
              },
              child: Text(
                'Places',
                style: DTTextStyles.regularBody(
                  color: DTColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
