import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nimihub_online/models/user_data.dart';
import 'package:nimihub_online/screens/cart/cart.dart';
import 'package:nimihub_online/screens/cart/cart_screen.dart';
import 'package:nimihub_online/screens/tools/components/greybar.dart';
import 'package:nimihub_online/screens/tools/components/toolstack.dart';
import 'package:nimihub_online/size_config.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ToolsScreen extends StatefulWidget {
  @override
  _ToolsScreenState createState() => _ToolsScreenState();
}

class _ToolsScreenState extends State<ToolsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Tools'),
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
      body: Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            child: Column(
              children: [
                GreyBar(
                  text: 'Lorem Ipsum',
                ),
                Wrap(
                  runSpacing: 6,
                  children: [
                    ToolStack(
                      desc: 'Lorem Ipus rome \n neth wlan host',
                      icon: 'assets/images/tshirt.png',
                      press: () {},
                      title: 'Lorem Ipsum',
                    ),
                   
                    ToolStack(
                      desc: 'Lorem Ipus rome \n neth wlan host',
                      icon: 'assets/images/product 1 image.png',
                      press: () {},
                      title: 'Lorem Ipsum',
                    ),
                    ToolStack(
                      desc: 'Lorem Ipus rome \n neth wlan host',
                      icon: 'assets/images/glap.png',
                      press: () {},
                      title: 'Lorem Ipsum',
                    ),
                   
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                 GreyBar(
                  text: 'Lorem Ipsum',
                ),
                Wrap(
                  runSpacing: 6,
                  children: [
                    ToolStack(
                      desc: 'Lorem Ipus rome \n neth wlan host',
                      icon: 'assets/images/tshirt.png',
                      press: () {},
                      title: 'Lorem Ipsum',
                    ),
                    ToolStack(
                      desc: 'Lorem Ipus rome \n neth wlan host',
                      icon: 'assets/images/tshirt.png',
                      press: () {},
                      title: 'Lorem Ipsum',
                    ),
                    ToolStack(
                      desc: 'Lorem Ipus rome \n neth wlan host',
                      icon: 'assets/images/tshirt.png',
                      press: () {},
                      title: 'Lorem Ipsum',
                    ),
                    ToolStack(
                      desc: 'Lorem Ipus rome \n neth wlan host',
                      icon: 'assets/images/tshirt.png',
                      press: () {},
                      title: 'Lorem Ipsum',
                    ),
                    ToolStack(
                      desc: 'Lorem Ipus rome \n neth wlan host',
                      icon: 'assets/images/tshirt.png',
                      press: () {},
                      title: 'Lorem Ipsum',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
