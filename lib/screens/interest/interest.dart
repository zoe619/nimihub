import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nimihub_online/components/default_button1.dart';
import 'package:nimihub_online/screens/home/home_screen.dart';
import 'package:nimihub_online/screens/interest/_interest_model.dart';
import 'package:get/get.dart';
import 'package:nimihub_online/screens/interest/components/page1.dart';
import 'package:nimihub_online/screens/interest/components/page2.dart';
import 'package:nimihub_online/screens/interest/components/page3.dart';
import 'package:nimihub_online/screens/interest/page4.dart';
import 'package:nimihub_online/size_config.dart';
import 'package:nimihub_online/constants.dart';

class InterestScreen extends StatefulWidget {
  @override
  _InterestScreenState createState() => _InterestScreenState();
}

List<MyClass> selecteditems = List();

bool ismed = false;
bool islaw = false;
bool isphy = false;

class _InterestScreenState extends State<InterestScreen> {
  final int _numPages = 4;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  // List<Widget> _buildPageIndicator() {
  //   List<Widget> list = [];
  //   for (int i = 0; i < _numPages; i++) {
  //     list.add(i == _currentPage ? _indicator(true) : _indicator(false));
  //   }
  //   return list;
  // }

  // Widget _indicator(bool isActive) {
  //   return AnimatedContainer(
  //     duration: Duration(milliseconds: 150),
  //     margin: EdgeInsets.symmetric(horizontal: 8.0),
  //     height: 8.0,
  //     width: isActive ? 24.0 : 16.0,
  //     decoration: BoxDecoration(
  //       color: isActive ? Colors.white : Color(0xFF7B51D3),
  //       borderRadius: BorderRadius.all(Radius.circular(12)),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            color: nearlyWhite,
            // gradient: LinearGradient(
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            //   stops: [0.1, 0.4, 0.7, 0.9],
            //   colors: [
            //     Color(0xFFFAF7FC),
            //     Color(0xFFEBEBEB),
            //     Color(0xFFC9C8CA),
            //     Color(0xFFD8D6DA),
            //   ],
            // ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenWidth(40.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Container(
                //   alignment: Alignment.centerRight,
                //   child: FlatButton(
                //     onPressed: () => print('Skip'),
                //     child: Text(
                //       'Skip',
                //       style: TextStyle(
                //         color: Colors.white,
                //         fontSize: 20.0,
                //       ),
                //     ),
                //   ),
                // ),
                Container(
                  height: getProportionateScreenHeight(600.0),
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Page1(),
                      Page2(),
                      Page3(),
                      Page4(),
                    ],
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: _buildPageIndicator(),
                // ),
                _currentPage != _numPages - 1
                    ? Padding(
                        padding: EdgeInsets.only(
                            left: getProportionateScreenWidth(15.0),
                            right: getProportionateScreenWidth(15),
                            top: getProportionateScreenHeight(40)),
                        child: DefaultButton1(
                            press: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            text: 'continue'),
                      )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: 120.0,
              width: double.infinity,
              color: Colors.white,
              child: GestureDetector(
                onTap: () =>
                    Get.off(HomeScreen(), transition: Transition.cupertino),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      'Get started',
                      style: TextStyle(
                        color: Color(0xFF5B16D0),
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }
}

