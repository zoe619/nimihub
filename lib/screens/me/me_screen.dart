import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nimihub_online/models/user_data.dart';
import 'package:nimihub_online/screens/cart/cart.dart';
import 'package:nimihub_online/screens/cart/cart_screen.dart';
import 'package:nimihub_online/screens/me/components/body.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MeScreen extends StatefulWidget {
  @override
  _MeScreenState createState() => _MeScreenState();
}

class _MeScreenState extends State<MeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Account'),
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
      body: Body(),
    );
  }
}
