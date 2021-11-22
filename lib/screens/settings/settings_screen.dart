
import 'package:flutter/material.dart';
import 'package:nimihub_online/screens/settings/components/body.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       title: Text('Settings')
     ), 
     body: Body(),
    );
  }
}