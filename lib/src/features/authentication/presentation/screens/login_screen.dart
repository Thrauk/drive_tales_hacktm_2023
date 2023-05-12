import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 60, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 70,
                      child: Image.asset('assets/logo.png'),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Drive',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Tales',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xffEFC74A),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Row(
                children: [
                  Icon(Icons.alternate_email),
                  SizedBox(width: 6,),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Username',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                ),
              ),
              ElevatedButton(onPressed: () {}, child: Text('Log in')),
              Text('Don\'t have an account? Register here'),
            ],
          ),
        ),
      ),
    );
  }
}
