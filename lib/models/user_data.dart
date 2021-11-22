

import 'package:flutter/material.dart';
import 'package:nimihub_online/models/products.dart';

class UserData extends ChangeNotifier
{

  String currentUserId;
  List<Product> cart = [];
  int sum = 0;
  static int examId;
  static String year;
  static String type;
  static String course;
  static String chapterContent;
  static String email;
  static String questionType;
  static String bookmark;

}