import 'package:flutter/material.dart';
import 'package:nimihub_online/constants.dart';
import 'package:nimihub_online/size_config.dart';

class Page3 extends StatefulWidget {
  const Page3({Key key}) : super(key: key);

  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  bool check1 = false;
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
            
            Container(
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: getProportionateScreenHeight(66),
                      width: getProportionateScreenWidth(330),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: kPrimraryColor,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26.withOpacity(0.2),
                                blurRadius: 15,
                                offset: Offset(0, 5))
                          ]),
                      child: Center(
                        child: CheckboxListTile(
                          activeColor: nearlyWhite,
                          checkColor: Colors.black,
                          title: Text(
                            'Animate Slowly',
                            style: TextStyle(color: nearlyWhite, fontSize: 20),
                          ),
                          value: check1,
                          onChanged: (bool value) {
                            setState(() {
                              check1 = !check1;
                            });
                          },
                          secondary: const Icon(
                            Icons.hourglass_empty,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: getProportionateScreenHeight(66),
                      width: getProportionateScreenWidth(330),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: kPrimraryColor,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26.withOpacity(0.2),
                                blurRadius: 15,
                                offset: Offset(0, 5))
                          ]),
                      child: Center(
                        child: CheckboxListTile(
                          activeColor: nearlyWhite,
                          checkColor: Colors.black,
                          title: Text(
                            'Animate Slowly',
                            style: TextStyle(color: nearlyWhite, fontSize: 20),
                          ),
                          value: check1,
                          onChanged: (bool value) {
                            setState(() {
                              check1 = !check1;
                            });
                          },
                          secondary: const Icon(
                            Icons.hourglass_empty,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: getProportionateScreenHeight(66),
                      width: getProportionateScreenWidth(330),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: kPrimraryColor,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26.withOpacity(0.2),
                                blurRadius: 15,
                                offset: Offset(0, 5))
                          ]),
                      child: Center(
                        child: CheckboxListTile(
                          activeColor: nearlyWhite,
                          checkColor: Colors.black,
                          title: Text(
                            'Animate Slowly',
                            style: TextStyle(color: nearlyWhite, fontSize: 20),
                          ),
                          value: check1,
                          onChanged: (bool value) {
                            setState(() {
                              check1 = !check1;
                            });
                          },
                          secondary: const Icon(
                            Icons.hourglass_empty,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: getProportionateScreenHeight(66),
                      width: getProportionateScreenWidth(330),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: kPrimraryColor,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26.withOpacity(0.2),
                                blurRadius: 15,
                                offset: Offset(0, 5))
                          ]),
                      child: Center(
                        child: CheckboxListTile(
                          activeColor: nearlyWhite,
                          checkColor: Colors.black,
                          title: Text(
                            'Animate Slowly',
                            style: TextStyle(color: nearlyWhite, fontSize: 20),
                          ),
                          value: check1,
                          onChanged: (bool value) {
                            setState(() {
                              check1 = !check1;
                            });
                          },
                          secondary: const Icon(
                            Icons.hourglass_empty,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: getProportionateScreenHeight(66),
                      width: getProportionateScreenWidth(330),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: kPrimraryColor,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26.withOpacity(0.2),
                                blurRadius: 15,
                                offset: Offset(0, 5))
                          ]),
                      child: Center(
                        child: CheckboxListTile(
                          activeColor: nearlyWhite,
                          checkColor: Colors.black,
                          title: Text(
                            'Animate Slowly',
                            style: TextStyle(color: nearlyWhite, fontSize: 20),
                          ),
                          value: check1,
                          onChanged: (bool value) {
                            setState(() {
                              check1 = !check1;
                            });
                          },
                          secondary: const Icon(
                            Icons.hourglass_empty,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: getProportionateScreenHeight(66),
                      width: getProportionateScreenWidth(330),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: kPrimraryColor,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26.withOpacity(0.2),
                                blurRadius: 15,
                                offset: Offset(0, 5))
                          ]),
                      child: Center(
                        child: CheckboxListTile(
                          activeColor: nearlyWhite,
                          checkColor: Colors.black,
                          title: Text(
                            'Animate Slowly',
                            style: TextStyle(color: nearlyWhite, fontSize: 20),
                          ),
                          value: check1,
                          onChanged: (bool value) {
                            setState(() {
                              check1 = !check1;
                            });
                          },
                          secondary: const Icon(
                            Icons.hourglass_empty,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: getProportionateScreenHeight(66),
                      width: getProportionateScreenWidth(330),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: kPrimraryColor,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26.withOpacity(0.2),
                                blurRadius: 15,
                                offset: Offset(0, 5))
                          ]),
                      child: Center(
                        child: CheckboxListTile(
                          activeColor: nearlyWhite,
                          checkColor: Colors.black,
                          title: Text(
                            'Animate Slowly',
                            style: TextStyle(color: nearlyWhite, fontSize: 20),
                          ),
                          value: check1,
                          onChanged: (bool value) {
                            setState(() {
                              check1 = !check1;
                            });
                          },
                          secondary: const Icon(
                            Icons.hourglass_empty,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: getProportionateScreenHeight(66),
                      width: getProportionateScreenWidth(330),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: kPrimraryColor,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26.withOpacity(0.2),
                                blurRadius: 15,
                                offset: Offset(0, 5))
                          ]),
                      child: Center(
                        child: CheckboxListTile(
                          activeColor: nearlyWhite,
                          checkColor: Colors.black,
                          title: Text(
                            'Animate Slowly',
                            style: TextStyle(color: nearlyWhite, fontSize: 20),
                          ),
                          value: check1,
                          onChanged: (bool value) {
                            setState(() {
                              check1 = !check1;
                            });
                          },
                          secondary: const Icon(
                            Icons.hourglass_empty,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: getProportionateScreenHeight(66),
                      width: getProportionateScreenWidth(330),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: kPrimraryColor,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26.withOpacity(0.2),
                                blurRadius: 15,
                                offset: Offset(0, 5))
                          ]),
                      child: Center(
                        child: CheckboxListTile(
                          activeColor: nearlyWhite,
                          checkColor: Colors.black,
                          title: Text(
                            'Animate Slowly',
                            style: TextStyle(color: nearlyWhite, fontSize: 20),
                          ),
                          value: check1,
                          onChanged: (bool value) {
                            setState(() {
                              check1 = !check1;
                            });
                          },
                          secondary: const Icon(
                            Icons.hourglass_empty,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: getProportionateScreenHeight(66),
                      width: getProportionateScreenWidth(330),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: kPrimraryColor,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26.withOpacity(0.2),
                                blurRadius: 15,
                                offset: Offset(0, 5))
                          ]),
                      child: Center(
                        child: CheckboxListTile(
                          activeColor: nearlyWhite,
                          checkColor: Colors.black,
                          title: Text(
                            'Animate Slowly',
                            style: TextStyle(color: nearlyWhite, fontSize: 20),
                          ),
                          value: check1,
                          onChanged: (bool value) {
                            setState(() {
                              check1 = !check1;
                            });
                          },
                          secondary: const Icon(
                            Icons.hourglass_empty,
                            color: Colors.white,
                          ),
                        ),
                      ),
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
