import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nimihub_online/screens/intro_screen/components/body.dart';
import 'package:nimihub_online/size_config.dart';

class IntroScreen extends StatelessWidget {
  static String routeName = "/intro";
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
