import 'package:flutter/material.dart';
import 'package:nimihub_online/components/default_button1.dart';
import 'package:nimihub_online/screens/home/home_screen.dart';

import '../../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.04),
        Image.asset(
          "assets/images/success.png",
          height: SizeConfig.screenHeight * 0.4, // 40% of the screen
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.08),
        Text(
          "Login Success",
          style: TextStyle(
              fontSize: getProportionateScreenWidth(30),
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth * 0.6,
          child: DefaultButton1(
            text: 'Back to home',
            press: () {
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            },
          ),
        ),
        Spacer()
      ],
    );
  }
}
