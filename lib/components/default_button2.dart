import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class DefaultButton2 extends StatelessWidget {
  const DefaultButton2({
    Key key,
    this.text,
    this.press,
  }) : super(key: key);

  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: OutlineButton(
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
              color: kPrimraryColor, fontSize: getProportionateScreenHeight(18)),
        ),
        borderSide: BorderSide(color: kPrimraryColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
