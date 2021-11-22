import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nimihub_online/models/question_model.dart';
import 'package:nimihub_online/models/user.dart';
import 'package:nimihub_online/models/user_data.dart';
import 'package:nimihub_online/models/wish.dart';
import 'package:nimihub_online/screens/cart/cart_screen.dart';
import 'package:nimihub_online/service/database.dart';
// import 'package:nimihub_online/constants.dart';
// import 'package:nimihub_online/screens/cart/cart_screen.dart';
import 'package:nimihub_online/size_config.dart';
import 'package:nimihub_online/components/browse_categories.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class EssayAnswerScreen extends StatefulWidget {
  @override
  _EssayAnswerScreenState createState() => _EssayAnswerScreenState();

  String answer;
  EssayAnswerScreen({this.answer});
}

class _EssayAnswerScreenState extends State<EssayAnswerScreen>
{

  String email, userId;


  @override
  void initState()
  {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Essay Answer',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: getProportionateScreenHeight(420),
                width: getProportionateScreenWidth(400),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      child: Icon(
                        EvaIcons.shakeOutline,
                        color: Colors.white,
                      ),
                      radius: 50,
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top: getProportionateScreenHeight(20.0)),
                      child: Flexible(
                        child: Text(
                          widget.answer,
                          maxLines: 10,
                          softWrap: true,
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                    )

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

