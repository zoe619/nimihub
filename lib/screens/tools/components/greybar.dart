import 'package:flutter/material.dart';
import 'package:nimihub_online/size_config.dart';

class GreyBar extends StatelessWidget {
  const GreyBar({
    Key key, @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      width: double.infinity,
      height: getProportionateScreenHeight(35),
      child: Padding(
        padding:  EdgeInsets.only(left: getProportionateScreenWidth(15),),
        child: Text(text, style: TextStyle(fontSize: 15), ),
      ),
    );
  }
}
