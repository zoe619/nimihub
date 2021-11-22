import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:nimihub_online/size_config.dart';

class ToolStack extends StatelessWidget {
  const ToolStack({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.desc,
    @required this.press,
  }) : super(key: key);

  final String icon;
  final String title;
  final String desc;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(5.0),),
      child: Container(
        child:
            Padding(
              padding: EdgeInsets.only(
                top: getProportionateScreenHeight(20.0),
                right: getProportionateScreenWidth(10),
              ),
              child: Card(
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: getProportionateScreenHeight(10.0)),
                        child: Container(
                          height: getProportionateScreenHeight(80),
                          width: getProportionateScreenWidth(150),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(7),
                            image: DecorationImage(
                                image: AssetImage(icon),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.all(getProportionateScreenHeight(5.0)),
                        child: Text(title,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      Text(desc,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          )),
                    ],
                  ),
                ),
              ),
            ),
            // Positioned(
            //   left: getProportionateScreenWidth(133),
            //   child: Container(
            //     child: IconButton(
            //       icon: Icon(EvaIcons.questionMarkCircle),
            //       onPressed: press,
            //       iconSize: getProportionateScreenHeight(30),
            //     ),
            //   ),
            // )
          
      ),
    );
  }
}
