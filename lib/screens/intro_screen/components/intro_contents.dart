import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class IntroContent extends StatelessWidget {
  const IntroContent({
    Key key,
    this.image,
    this.text1,
    this.text2,
  }) : super(key: key);

  final String image;
  final String text1;
  final String text2;
  @override
  Widget build(BuildContext context) {
    return
      Column(
      children: [
        Spacer(flex: 1),
        Image.asset(
          image,
          width: getProportionateScreenWidth(265.0),
          height: getProportionateScreenHeight(300.0),
        ),
        Spacer(),
        Text(text1,
            style: TextStyle(
                color: kPrimraryColor,
                fontWeight: FontWeight.w600,
                fontSize: getProportionateScreenHeight(20))),
        Text(text2, textAlign: TextAlign.center),
        Spacer(flex: 2),
      ],
    );
  }
}
