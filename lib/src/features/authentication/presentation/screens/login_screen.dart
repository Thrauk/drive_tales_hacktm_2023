import 'package:drive_tales/src/design/dt_colors.dart';
import 'package:drive_tales/src/design/dt_text_styles.dart';
import 'package:drive_tales/src/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:drive_tales/src/features/home/presentaiton/screens/home_screen.dart';
import 'package:drive_tales/src/widgets/dt_button.dart';
import 'package:drive_tales/src/widgets/dt_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _passwordController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: DTColors.navyBlue,
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 35, right: 35),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.isAuthenticated) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            }
          },
          child: SingleChildScrollView(
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
                  'Login',
                  style: DTTextStyles.h1,
                ),
                const SizedBox(
                  height: 50,
                ),
                DTTextField(
                  hint: 'Email',
                  controller: _emailController,
                  prefixIcon: Icons.alternate_email,
                ),
                SizedBox(
                  height: 30,
                ),
                DTTextField(
                  hint: 'Password',
                  obscureText: true,
                  controller: _passwordController,
                  prefixIcon: Icons.key,
                ),
                SizedBox(
                  height: 40,
                ),
                DTButton(
                  height: 40,
                  width: double.infinity,
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(
                      LogInWithEmailAndPass(
                        email: _emailController.text,
                        password: _passwordController.text,
                      ),
                    );
                  },
                  child: Text(
                    'Login',
                    style: DTTextStyles.regularBody(
                      color: DTColors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          color: DTColors.lightGrey,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'OR',
                          style: DTTextStyles.regularBody(
                            fontSize: 12,
                            color: DTColors.white,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          color: DTColors.lightGrey,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: DTButton(
                    height: 40,
                    backgroundColor: DTColors.white,
                    width: double.infinity,
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(
                        AuthenticateWithGoogle(),
                      );
                    },
                    child: Text(
                      'Connect with google',
                      style: DTTextStyles.regularBody(
                        color: DTColors.navyBlue,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: DTTextStyles.regularBody(
                        fontSize: 12,
                        color: DTColors.lightGrey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign up here.',
                        style: DTTextStyles.regularBody(
                          fontSize: 12,
                          color: DTColors.orange,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
