import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nimihub_online/models/user.dart';
import 'package:nimihub_online/models/user_data.dart';
import 'package:nimihub_online/models/wish.dart';
import 'package:nimihub_online/screens/cart/cart.dart';
import 'package:nimihub_online/screens/cart/cart_screen.dart';
import 'package:nimihub_online/service/database.dart';
// import 'package:nimihub_online/constants.dart';
// import 'package:nimihub_online/screens/cart/cart_screen.dart';
import 'package:nimihub_online/size_config.dart';
import 'package:nimihub_online/components/browse_categories.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class WishListScreen extends StatefulWidget {
  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen>
{
  List<Wishes> _wishes;
  String email, userId;

  @override
  void initState()
  {
    super.initState();
    // TODO: implement initState
    userId = Provider.of<UserData>(context, listen: false).currentUserId;
    _setupProfileUser();

  }

  _setupProfileUser() async
  {
    Users profileUser = await Provider.of<DatabaseService>(
        context, listen: false).getUserWithId(userId);
    setState(() {
      email = profileUser.email;
    });

  }

  _getWishes() async
  {
    List<Wishes> wishes = await Provider.of<DatabaseService>(context, listen: false).getWishes(email);
    setState(() {
      _wishes = wishes;


    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Wishlist',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 22),
              child: GestureDetector(
                onTap: () {

                  Get.to(CartScreenMain(cart:Provider.of<UserData>(context, listen: false).cart,
                      sum: Provider.of<UserData>(context, listen: false).sum));
                },
                child: SvgPicture.asset(
                  'assets/icons/Cart Icon.svg',
                  height: 20,
                ),
              ),
            ),
        ],
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
                      child: Text(
                        'Want to save something for later?',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text('Your wishlist will go here'),
                    )
                  ],
                ),
              ),
              FutureBuilder(
                future: _getWishes(),
                builder: (BuildContext context, AsyncSnapshot snapshot)
                {
                  if(_wishes == null)
                  {
                    return Center(
                      child: Platform.isIOS ? CupertinoActivityIndicator() : CircularProgressIndicator(),
                    );
                  }
                  return BrowseCategories(wishes: _wishes);


                },
              )

            ],
          ),
        ),
      ),
    );
  }
}

