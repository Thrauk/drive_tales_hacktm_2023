import 'package:drive_tales/src/design/dt_colors.dart';
import 'package:drive_tales/src/design/dt_text_styles.dart';
import 'package:drive_tales/src/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:drive_tales/src/features/authentication/presentation/screens/login_screen.dart';
import 'package:drive_tales/src/features/home/presentaiton/screens/home_screen.dart';
import 'package:drive_tales/src/widgets/dt_button.dart';
import 'package:drive_tales/src/widgets/dt_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _passwordController;
  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _usernameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: DTColors.navyBlue,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.isAuthenticated) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 35, right: 35),
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
                  'Register',
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
                  hint: 'Username',
                  controller: _usernameController,
                  prefixIcon: Icons.account_circle_rounded,
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
                    print(_emailController.text);
                    print(_passwordController.text);
                    BlocProvider.of<AuthBloc>(context).add(
                      RegisterWithEmailAndPass(
                        email: _emailController.text,
                        password: _passwordController.text,
                        username: _usernameController.text,
                      ),
                    );
                  },
                  child: Text(
                    'Register',
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
                      'Already have an account? ',
                      style: DTTextStyles.regularBody(
                        fontSize: 12,
                        color: DTColors.lightGrey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Login here.',
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
    _usernameController.dispose();
    super.dispose();
  }
}
