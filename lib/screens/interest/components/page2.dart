import 'package:flutter/material.dart';
import 'package:nimihub_online/constants.dart';
import 'package:nimihub_online/size_config.dart';
import 'package:selectable_container/selectable_container.dart';

class Page2 extends StatefulWidget {
  const Page2({Key key}) : super(key: key);

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  bool is20 = false;
  bool is30 = false;
  bool is40 = false;
  bool isAbove = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'What is your gender?',
            style: TextStyle(fontSize: getProportionateScreenHeight(22)),
          ),
          SizedBox(
            height: getProportionateScreenHeight(360),
          ),
          Container(
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                SelectableContainer(
                  selectedBorderColor: kPrimraryColor,
                  selectedBackgroundColor: Colors.transparent,
                  unselectedBorderColor: Colors.transparent,
                  unselectedBackgroundColor: Colors.transparent,
                  iconAlignment: Alignment.topLeft,
                  icon: Icons.thumb_up,
                  iconSize: 24,
                  unselectedOpacity: 1,
                  selected: is20,
                  // padding: 0,
                  child: Container(
                    // height: getProportionateScreenHeight(66),
                    // width: getProportionateScreenWidth(130),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: kPrimraryColor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26.withOpacity(0.2),
                              blurRadius: 15,
                              offset: Offset(0, 5))
                        ]),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(16),
                          horizontal: getProportionateScreenWidth(28)),
                      child: Text(
                        '12-29',
                        style: TextStyle(color: nearlyWhite, fontSize: 20),
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      is20 = !is20;
                    });
                  },
                ),
                SelectableContainer(
                  selectedBorderColor: kPrimraryColor,
                  selectedBackgroundColor: Colors.transparent,
                  unselectedBorderColor: Colors.transparent,
                  unselectedBackgroundColor: Colors.transparent,
                  iconAlignment: Alignment.topLeft,
                  icon: Icons.thumb_up,
                  iconSize: 24,
                  unselectedOpacity: 1,
                  selected: is30,
                  // padding: 0,
                  child: Container(
                    // height: getProportionateScreenHeight(66),
                    // width: getProportionateScreenWidth(130),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: kPrimraryColor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26.withOpacity(0.2),
                              blurRadius: 15,
                              offset: Offset(0, 5))
                        ]),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(16),
                          horizontal: getProportionateScreenWidth(28)),
                      child: Text(
                        '30-39',
                        style: TextStyle(color: nearlyWhite, fontSize: 20),
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      is30 = !is30;
                    });
                  },
                ),
                SelectableContainer(
                  selectedBorderColor: kPrimraryColor,
                  selectedBackgroundColor: Colors.transparent,
                  unselectedBorderColor: Colors.transparent,
                  unselectedBackgroundColor: Colors.transparent,
                  iconAlignment: Alignment.topLeft,
                  icon: Icons.thumb_up,
                  iconSize: 24,
                  unselectedOpacity: 1,
                  selected: is40,
                  // padding: 0,
                  child: Container(
                    // height: getProportionateScreenHeight(66),
                    // width: getProportionateScreenWidth(130),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: kPrimraryColor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26.withOpacity(0.2),
                              blurRadius: 15,
                              offset: Offset(0, 5))
                        ]),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(16),
                          horizontal: getProportionateScreenWidth(28)),
                      child: Text(
                        '40-49',
                        style: TextStyle(color: nearlyWhite, fontSize: 20),
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      is40 = !is40;
                    });
                  },
                ),
                SelectableContainer(
                  selectedBorderColor: kPrimraryColor,
                  selectedBackgroundColor: Colors.transparent,
                  unselectedBorderColor: Colors.transparent,
                  unselectedBackgroundColor: Colors.transparent,
                  iconAlignment: Alignment.topLeft,
                  icon: Icons.thumb_up,
                  iconSize: 24,
                  unselectedOpacity: 1,
                  selected: isAbove,
                  // padding: 0,
                  child: Container(
                    // height: getProportionateScreenHeight(66),
                    // width: getProportionateScreenWidth(130),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: kPrimraryColor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26.withOpacity(0.2),
                              blurRadius: 15,
                              offset: Offset(0, 5))
                        ]),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(16),
                          horizontal: getProportionateScreenWidth(38)),
                      child: Text(
                        '50+',
                        style: TextStyle(color: nearlyWhite, fontSize: 20),
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      isAbove = !isAbove;
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
