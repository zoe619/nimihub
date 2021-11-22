import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nimihub_online/components/default_button1.dart';
import 'package:nimihub_online/constants.dart';
import 'package:nimihub_online/screens/interest/interest.dart';
import 'package:nimihub_online/screens/login_success/login_success_screen.dart';
import 'package:nimihub_online/size_config.dart';
import 'package:get/get.dart';

import '../../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              Text(
                'OTP Verification',
                style: headingStyle,
              ),
              Text('We sent your code to +234 808 896 ***'),
              buildTimer(),
              SizedBox(height: SizeConfig.screenHeight * 0.15),
              OtpForm(),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Resend OTP code',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('This code will expire in '),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0),
          duration: Duration(seconds: 30),
          builder: (context, value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: kPrimraryColor),
          ),
          onEnd: () {},
        ),
      ],
    );
  }
}

class OtpForm extends StatefulWidget {
  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  FocusNode pin2FucusNode;
  FocusNode pin3FucusNode;
  FocusNode pin4FucusNode;

  @override
  void initState() {
    super.initState();
    pin2FucusNode = FocusNode();
    pin3FucusNode = FocusNode();
    pin4FucusNode = FocusNode();
  }

  @override
  void dispose() {
    pin2FucusNode.dispose();
    pin3FucusNode.dispose();
    pin4FucusNode.dispose();
    super.dispose();
  }

  void nextField({String value, FocusNode focusNode}) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  autofocus: true,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                  decoration: OtpDecorationForm,
                  onChanged: (value) {
                    nextField(focusNode: pin2FucusNode, value: value);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin2FucusNode,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                  decoration: OtpDecorationForm,
                  onChanged: (value) {
                    nextField(focusNode: pin3FucusNode, value: value);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin3FucusNode,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                  decoration: OtpDecorationForm,
                  onChanged: (value) {
                    nextField(focusNode: pin4FucusNode, value: value);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin4FucusNode,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                  decoration: OtpDecorationForm,
                  onChanged: (value) {
                    pin4FucusNode.unfocus();
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          DefaultButton1(
            press: () {
              // Navigator.pushNamed(context, LoginSuccessScreen.routeName);
              Get.to(InterestScreen());
            },
            text: 'Continue',
          ),
        ],
      ),
    );
  }
}
