import 'package:flutter/material.dart';
import 'package:nimihub_online/screens/my_bio/body.dart';

class MyBioScreen extends StatelessWidget {
  static String routeName = '/myBio';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Bio'),),
      body: Body(),
    );
  }
}