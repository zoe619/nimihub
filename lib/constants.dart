import 'package:flutter/material.dart';
import 'package:nimihub_online/size_config.dart';

const kPrimraryColor = Color(0xFF0D47A1);
const kPrimaryColorLight = Color(0xFFFFECDF);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Colors.black;
const kPrimaryColorGradient = LinearGradient(
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const Color nearlyWhite = Color(0xFFF4F4F4);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: getProportionateScreenWidth(28),
  height: 1.5,
);

//Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final String kEmailNulError = 'Please Enter your email';
final String kEmailValidEmailError = 'Please Enter Valid email';
final String kPassNullError = 'Please Enter your password';
final String kShortPassError = 'Password is too short';
final String kMatchPassError = "Password don't match";
final String kNameNullError = 'Please enter your name';
final String kPhoneNumberNullError = 'Please enter your phone number';
final String kAddressNullError = 'Please enter your address';

// ignore: non_constant_identifier_names
final OtpDecorationForm = InputDecoration(
  contentPadding: EdgeInsets.symmetric(
    vertical: getProportionateScreenWidth(15),
  ),
  enabledBorder: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  border: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: kTextColor),
  );
}


const kSecondaryColor2 = Color(0xFF8B94BC);
const kGreenColor = Color(0xFF6AC259);
const kRedColor = Color(0xFFE92E30);
const kGrayColor = Color(0xFFC1C1C1);
const kBlackColor = Color(0xFF101010);
const kPrimaryGradient = LinearGradient(
  colors: [Color(0xFF46A0AE), Color(0xFF00FFCB)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

const double kDefaultPadding = 20.0;
