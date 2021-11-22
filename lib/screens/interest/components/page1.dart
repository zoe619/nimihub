import 'package:flutter/material.dart';
import 'package:nimihub_online/constants.dart';
import 'package:nimihub_online/screens/interest/interest.dart';
import 'package:nimihub_online/size_config.dart';
import 'package:selectable_container/selectable_container.dart';

class Page1 extends StatefulWidget {
  const Page1({Key key}) : super(key: key);

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {

  bool ismed = false;
  bool isPhy = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Text(
              'Choose your Gender',
              style: TextStyle(fontSize: getProportionateScreenHeight(20)),
            ),
            SizedBox(height: getProportionateScreenHeight(360),),
            Container(
              
              child: Wrap(
                  children: [
                    Container(
                      child: SelectableContainer(
                        selectedBorderColor: kPrimraryColor,
                        selectedBackgroundColor: Colors.transparent,
                        unselectedBorderColor: Colors.transparent,
                        unselectedBackgroundColor: Colors.transparent,
                        iconAlignment: Alignment.topLeft,
                        icon: Icons.thumb_up,
                        iconSize: 24,
                        unselectedOpacity: 1,
                        selected: ismed,
                        padding: 0,
                        child: Container(
                          height: getProportionateScreenHeight(120),
                          width: getProportionateScreenWidth(80),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            image: DecorationImage(
                                image: AssetImage('assets/images/Profile Image.png')),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            ismed = !ismed;
                          });
                        },
                      ),
                    ),
                    Container(
                      child: SelectableContainer(
                        selectedBorderColor: kPrimraryColor,
                        selectedBackgroundColor: Colors.transparent,
                        unselectedBorderColor: Colors.transparent,
                        unselectedBackgroundColor: Colors.transparent,
                        iconAlignment: Alignment.topLeft,
                        icon: Icons.thumb_up,
                        iconSize: 24,
                        unselectedOpacity: 1,
                        selected: isPhy,
                        padding: 0,
                        child: Container(
                          height: getProportionateScreenHeight(120),
                          width: getProportionateScreenWidth(80),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            image: DecorationImage(
                                image: AssetImage('assets/images/Profile Image.png')),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            isPhy = !isPhy;
                          });
                        },
                      ),
                    ),
                    Container(
                      child: SelectableContainer(
                        selectedBorderColor: kPrimraryColor,
                        selectedBackgroundColor: Colors.transparent,
                        unselectedBorderColor: Colors.transparent,
                        unselectedBackgroundColor: Colors.transparent,
                        iconAlignment: Alignment.topLeft,
                        icon: Icons.thumb_up,
                        iconSize: 24,
                        unselectedOpacity: 1,
                        selected: islaw,
                        padding: 0,
                        child: Container(
                          height: getProportionateScreenHeight(120),
                          width: getProportionateScreenWidth(80),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            image: DecorationImage(
                                image: AssetImage('assets/images/Profile Image.png')),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            islaw = !islaw;
                          });
                        },
                      ),
                    ),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}
