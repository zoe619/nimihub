import 'package:flutter/material.dart';
import 'package:nimihub_online/components/default_button1.dart';
import 'package:nimihub_online/components/default_button2.dart';
import 'package:nimihub_online/constants.dart';
import 'package:nimihub_online/screens/intro_screen/components/intro_contents.dart';
import 'package:nimihub_online/screens/login/login.dart';
import 'package:nimihub_online/screens/login/login_screen.dart';
import 'package:nimihub_online/screens/sign_up/register.dart';
import 'package:nimihub_online/screens/sign_up/sign_up_screen.dart';
import 'package:nimihub_online/size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

int currentPage = 0;
List<Map<String, String>> introData = [
  {
    "image": "assets/images/splash_3.png",
    "text2": 'Get more out of learning',
    'text1': 'Learning never Stops'
  },
  {
    "image": "assets/images/splash_2.png",
    "text1": 'Forward ever Backward never',
    'text2': 'Give it a shot, Give it your Best \nWatch the results Bloom'
  },
  {
    "image": "assets/images/splash_1.png",
    "text1": 'Invest in the future',
    'text2': 'Read consistently, study everly \nand watch your progress '
  },
];

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Spacer(
              flex: 1,
            ),
            Expanded(
                flex: 4,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemBuilder: (context, index) => IntroContent(
                    image: introData[index]['image'],
                    text1: introData[index]['text1'],
                    text2: introData[index]['text2'],
                  ),
                  itemCount: introData.length,
                )),
            Spacer(),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(40)),
                child: Column(
                  children: [
                    Row(
                      children: List.generate(
                          introData.length, (index) => buildDot(index: index)),
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    Spacer(),
//                    DefaultButton1(
//                      press: () {
//                        Navigator.push(context, MaterialPageRoute(
//                          builder: (_)=>Register(),
//                        ));
//                      },
//                      text: 'Create Account',
//                    ),
                    Spacer(),
                    DefaultButton2(
                      press: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (_)=>Login(),
                        ));
                      },
                      text: 'Login',
                    ),

                  ],
                ),

              ),
            ),
            //  Spacer(),
            SizedBox(
              height: getProportionateScreenHeight(20),
            )
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 7,
      width: currentPage == index ? 20 : 7,
      decoration: BoxDecoration(
          color: currentPage == index ? kPrimraryColor : Color(0xFFD8D8D8),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
