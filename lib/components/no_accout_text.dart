import 'package:flutter/material.dart';
import 'package:nimihub_online/screens/sign_up/register.dart';
import 'package:nimihub_online/screens/sign_up/sign_up_screen.dart';

import '../constants.dart';
import '../size_config.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (_)=>Register(),
            ));
          },
          child: Text(
            "Sign Up",
            style: TextStyle(
                color: kPrimraryColor,
                fontSize: getProportionateScreenWidth(16)),
          ),
        )
      ],
    );
  }
}
