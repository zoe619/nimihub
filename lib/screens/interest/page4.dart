import 'package:flutter/material.dart';
import 'package:nimihub_online/constants.dart';
import 'package:nimihub_online/size_config.dart';
import 'package:selectable_container/selectable_container.dart';

class Page4 extends StatefulWidget {
  Page4({Key key}) : super(key: key);

  @override
  _Page4State createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  bool is1 = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Choose areas you'd \nlike to elevate",
            style: TextStyle(
                fontSize: getProportionateScreenHeight(18),
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: getProportionateScreenHeight(100),
          ),
          Wrap(
            children: [
              SelectableContainer(
                selectedBorderColor: kPrimraryColor,
                selectedBackgroundColor: Colors.transparent,
                unselectedBorderColor: Colors.transparent,
                unselectedBackgroundColor: Colors.transparent,
                iconAlignment: Alignment.topLeft,
                icon: Icons.thumb_up,
                iconSize: 18,
                unselectedOpacity: 1,
                selected: is1,
                // padding: 0,
                child: Container(
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
                      horizontal: getProportionateScreenWidth(14),
                      vertical: getProportionateScreenHeight(8),
                    ),
                    child: Text(
                      'Multivation',
                      style: TextStyle(color: nearlyWhite, fontSize: 20),
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    is1 = !is1;
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
                iconSize: 18,
                unselectedOpacity: 1,
                selected: is1,
                // padding: 0,
                child: Container(
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
                      horizontal: getProportionateScreenWidth(14),
                      vertical: getProportionateScreenHeight(8),
                    ),
                    child: Text(
                      'Leadership',
                      style: TextStyle(color: nearlyWhite, fontSize: 20),
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    is1 = !is1;
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
                iconSize: 18,
                unselectedOpacity: 1,
                selected: is1,
                // padding: 0,
                child: Container(
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
                      horizontal: getProportionateScreenWidth(14),
                      vertical: getProportionateScreenHeight(8),
                    ),
                    child: Text(
                      'Management',
                      style: TextStyle(color: nearlyWhite, fontSize: 20),
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    is1 = !is1;
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
                iconSize: 18,
                unselectedOpacity: 1,
                selected: is1,
                // padding: 0,
                child: Container(
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
                      horizontal: getProportionateScreenWidth(14),
                      vertical: getProportionateScreenHeight(8),
                    ),
                    child: Text(
                      'Planing',
                      style: TextStyle(color: nearlyWhite, fontSize: 20),
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    is1 = !is1;
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
                iconSize: 18,
                unselectedOpacity: 1,
                selected: is1,
                // padding: 0,
                child: Container(
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
                      horizontal: getProportionateScreenWidth(14),
                      vertical: getProportionateScreenHeight(8),
                    ),
                    child: Text(
                      'Team-management',
                      style: TextStyle(color: nearlyWhite, fontSize: 20),
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    is1 = !is1;
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
                iconSize: 18,
                unselectedOpacity: 1,
                selected: is1,
                // padding: 0,
                child: Container(
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
                      horizontal: getProportionateScreenWidth(14),
                      vertical: getProportionateScreenHeight(8),
                    ),
                    child: Text(
                      'Parenting',
                      style: TextStyle(color: nearlyWhite, fontSize: 20),
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    is1 = !is1;
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
                iconSize: 18,
                unselectedOpacity: 1,
                selected: is1,
                // padding: 0,
                child: Container(
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
                      horizontal: getProportionateScreenWidth(14),
                      vertical: getProportionateScreenHeight(8),
                    ),
                    child: Text(
                      'Self-confidence',
                      style: TextStyle(color: nearlyWhite, fontSize: 20),
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    is1 = !is1;
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
                iconSize: 18,
                unselectedOpacity: 1,
                selected: is1,
                // padding: 0,
                child: Container(
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
                      horizontal: getProportionateScreenWidth(14),
                      vertical: getProportionateScreenHeight(6),
                    ),
                    child: Text(
                      'Initimacy',
                      style: TextStyle(color: nearlyWhite, fontSize: 16),
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    is1 = !is1;
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
            iconSize: 18,
            unselectedOpacity: 1,
            selected: is1,
            // padding: 0,
            child: Container(
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
                  horizontal: getProportionateScreenWidth(14),
                  vertical: getProportionateScreenHeight(6),
                ),
                child: Text(
                  'Mindset',
                  style: TextStyle(color: nearlyWhite, fontSize: 16),
                ),
              ),
            ),
            onPressed: () {
              setState(() {
                is1 = !is1;
              });
            },
          ),
            ],
          ),
         
        ],
      ),
    );
  }
}
