import 'package:flutter/material.dart';
import 'package:nimihub_online/screens/sign_up/components/body.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = '/sign_up';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Body(),
    );
  }
}
