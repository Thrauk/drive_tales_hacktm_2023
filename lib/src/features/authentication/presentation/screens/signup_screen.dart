import 'package:drive_tales/src/design/dt_colors.dart';
import 'package:drive_tales/src/design/dt_text_styles.dart';
import 'package:drive_tales/src/widgets/dt_button.dart';
import 'package:drive_tales/src/widgets/dt_text_field.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                'Register',
                style: DTTextStyles.h1,
              ),
              const SizedBox(
                height: 50,
              ),
              DTTextField(
                hint: 'Email',
                controller: TextEditingController(),
                prefixIcon: Icons.alternate_email,
              ),
              SizedBox(
                height: 30,
              ),
              DTTextField(
                hint: 'Username',
                controller: TextEditingController(),
                prefixIcon: Icons.account_circle_rounded,
              ),
              SizedBox(
                height: 30,
              ),
              DTTextField(
                hint: 'Password',
                obscureText: true,
                controller: TextEditingController(),
                prefixIcon: Icons.key,
              ),
              SizedBox(
                height: 40,
              ),
              DTButton(
                height: 40,
                width: double.infinity,
                onPressed: () {},
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
                  onPressed: () {},
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
    );
  }
}
