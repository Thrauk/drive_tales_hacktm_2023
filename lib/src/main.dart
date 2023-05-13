import 'package:drive_tales/src/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:drive_tales/src/features/authentication/presentation/screens/login_screen.dart';
import 'package:drive_tales/src/features/authentication/presentation/screens/register_screen.dart';
import 'package:drive_tales/src/features/home/presentaiton/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(BlocProvider<AuthBloc>(
    create: (context) => AuthBloc(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(builder: (context) {
        final bloc = BlocProvider.of<AuthBloc>(context);
        if (!bloc.state.isAuthenticated) {
          return HomeScreen();
        } else {
          return LoginScreen();
        }
      }),
    );
  }
}
