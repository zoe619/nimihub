import 'package:flutter/material.dart';
// import 'package:nimihub_online/screens/cart/cart_screen.dart';
import 'package:nimihub_online/screens/complete_profile/complete_profile_screen.dart';
import 'package:nimihub_online/screens/details/details_screen.dart';
import 'package:nimihub_online/screens/forgot_password/forgot_password_screen.dart';
import 'package:nimihub_online/screens/home/home_screen.dart';
// import 'package:nimihub_online/screens/home/home_screen.dart';
import 'package:nimihub_online/screens/intro_screen/intro_screen.dart';
import 'package:nimihub_online/screens/login/login_screen.dart';
import 'package:nimihub_online/screens/login_success/login_success_screen.dart';
import 'package:nimihub_online/screens/my_bio/my_bio_screen.dart';
import 'package:nimihub_online/screens/otp/otp_screen.dart';
import 'package:nimihub_online/screens/search/search_screen.dart';
import 'package:nimihub_online/screens/sign_up/sign_up_screen.dart';
import 'package:nimihub_online/screens/splash_screen/splash_screen.dart';
import 'package:nimihub_online/screens/exams/exams.dart';
import 'package:nimihub_online/screens/ebooks/ebooks.dart';



final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  IntroScreen.routeName: (context) => IntroScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  // Cart.routeName: (context) => Cart(),
  DetailedScreen.routeName: (context) => DetailedScreen(),
  SearchScreen.routeName: (context) => SearchScreen(),
  Exams.routeName: (context) => Exams(),
  EBooks.routeName: (context) => EBooks(),
  MyBioScreen.routeName: (context) => MyBioScreen()
};
