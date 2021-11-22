import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nimihub_online/animation/delayed_animation.dart';
import 'package:nimihub_online/constants.dart';
import 'package:nimihub_online/screens/intro_screen/intro_screen.dart';
import 'package:nimihub_online/screens/my_bio/my_bio_screen.dart';
import 'package:nimihub_online/screens/settings/settings_screen.dart';
import 'package:nimihub_online/screens/activities/activities.dart';
import 'package:nimihub_online/screens/wishlist/wishlist_screen.dart';
import 'package:nimihub_online/size_config.dart';


class InstuctorProfile extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                // height: getProportionateScreenHeight(430),
                width: getProportionateScreenWidth(400),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 75,
                    ),
                    Text(
                      'Nimihub Academy',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text('Port Harcourt,'), Text('Nigeria')]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/google-icon.svg',
                            height: 24,
                          ),
                          SizedBox(width: 8),
                          //ToDo sort the length problem
                          Text(
                            'nimihubacademy@gmail.com',
                          ),
                          // getBoxUi(
                          //   'following', 'followers'
                          // ),
                        ],
                      ),
                    ),
                    boxUi(),
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: MaterialButton(
                        onPressed: () {},
                        child: Text(
                          'Become an instructor',
                          style: TextStyle(
                              color: Colors.lightBlue,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider( thickness: 2,),
              ListTile(
                onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new MyBioScreen()));
              },
                leading: Icon(
                  EvaIcons.browserOutline,
                  size: getProportionateScreenHeight(26),
                ),
                title: Transform(
                  transform: Matrix4.translationValues(getProportionateScreenWidth(-13), 0, 0),
                  child: Text(
                    'My Bio',
                    style: TextStyle(
                        fontSize: getProportionateScreenHeight(18),
                        color: kTextColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                subtitle: Transform(
                    transform: Matrix4.translationValues(getProportionateScreenWidth(-13), 0, 0),
                    child: Text('Lorem Ipsum')),
              ),
              ListTile(
                onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => new WishListScreen(),
                  ),
                );
              },
                leading: Icon(
                  EvaIcons.browserOutline,
                  size: getProportionateScreenHeight(26),
                ),
                title: Transform(
                  transform: Matrix4.translationValues(getProportionateScreenWidth(-13), 0, 0),
                  child: Text(
                    'My WishList',
                    style: TextStyle(
                        fontSize: getProportionateScreenHeight(18),
                        color: kTextColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                subtitle: Transform(
                    transform: Matrix4.translationValues(getProportionateScreenWidth(-13), 0, 0),
                    child: Text('Lorem Ipsum')),
              ),
              ListTile(
                onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => new SettingsScreen(),
                  ),
                );
              },
                leading: Icon(
                  EvaIcons.browserOutline,
                  size: getProportionateScreenHeight(26),
                ),
                title: Transform(
                  transform: Matrix4.translationValues(getProportionateScreenWidth(-13), 0, 0),
                  child: Text(
                    'Settings',
                    style: TextStyle(
                        fontSize: getProportionateScreenHeight(18),
                        color: kTextColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                subtitle: Transform(
                    transform: Matrix4.translationValues(getProportionateScreenWidth(-13), 0, 0),
                    child: Text('Lorem Ipsum')),
              ),
              Divider(thickness: 2,),
              ListTile(
                title: Transform(
                  transform: Matrix4.translationValues(0, 0, 0),
                  child: Text(
                    'Rate this app',
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(16),
                      color: kTextColor,
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Transform(
                  transform: Matrix4.translationValues(0, 0, 0),
                  child: Text(
                    'feedback/suggest featuers',
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(16),
                      color: kTextColor,
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Transform(
                  transform: Matrix4.translationValues(0, 0, 0),
                  child: Text(
                    'Contact us',
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(16),
                      color: kTextColor,
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Transform(
                  transform: Matrix4.translationValues(0, 0, 0),
                  child: Text(
                    'Share the app',
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(16),
                      color: kTextColor,
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Transform(
                  transform: Matrix4.translationValues(0, 0, 0),
                  child: Text(
                    'About',
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(16),
                      color: kTextColor,
                    ),
                  ),
                ),
              ),
              Center(
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, IntroScreen.routeName);
                  },
                  child: Text(
                    'Sign out',
                    style: TextStyle(
                        color: Colors.lightBlue, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: Center(
                    child: Text(
                  "Nimihub v1.0.0",
                  style: TextStyle(fontSize: 12),
                )),
              )
            
            ],
          ),
        ),
      ),
    );
  }
}

Widget boxUi() {
  return Container(
    child: Padding(
      padding: EdgeInsets.only(right: 18, left: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          DelayedAnimation(
              delayedDuration: 100,
              animDuration: 700,
              animOffsetX: -1.35,
              animOffsetY: 0.0,
              child: getBoxUi('2,234', 'following')),
          DelayedAnimation(
              delayedDuration: 300,
              animDuration: 300,
              animOffsetX: -1.35,
              animOffsetY: 0.0,
              child: getBoxUi('43,455', 'followers')),
        ],
      ),
    ),
  );
}

Widget getBoxUi(String s1, String s2) {
  return Padding(
    padding: EdgeInsets.only(top: 20),
    child: Container(
      height: 80,
      width: 106,
      decoration: BoxDecoration(
        color: kPrimraryColor,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 15,
            offset: Offset(0, 15),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(s1,
              style: TextStyle(
                  color: nearlyWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 0.27)),
          Text(
            s2,
            style: TextStyle(
                color: nearlyWhite,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing: 0.27),
          ),
        ],
      ),
    ),
  );
}


//             Text(
//               'Account settings',
//               style: TextStyle(fontSize: 12),
//             ),
//             ListTile(
//               trailing: Icon(
//                 Icons.arrow_forward_ios,
//                 size: 16,
//               ),
//               title: Text(
//                 'Account security',
//                 style: TextStyle(
//                     color: Colors.black, fontSize: 15, letterSpacing: -1),
//               ),
//             ),
//             ListTile(
//               trailing: Icon(
//                 Icons.arrow_forward_ios,
//                 size: 16,
//               ),
//               title: Text(
//                 'Email Notification preferences',
//                 style: TextStyle(
//                     color: Colors.black, fontSize: 15, letterSpacing: -1),
//               ),
//             ),
//             ListTile(
//               trailing: Icon(
//                 Icons.arrow_forward_ios,
//                 size: 16,
//               ),
//               title: Row(
//                 children: [
//                   Text(
//                     'Learning reminders',
//                     style: TextStyle(
//                         color: Colors.black, fontSize: 15, letterSpacing: -1),
//                   ),
//                   Icon(
//                     Icons.new_releases,
//                     size: 17,
//                   )
//                 ],
//               ),
//             ),
//             Text(
//               'Supports',
//               style: TextStyle(fontSize: 12),
//             ),
//             ListTile(
//               trailing: Icon(
//                 Icons.arrow_forward_ios,
//                 size: 16,
//               ),
//               title: Text(
//                 'About Nimihub',
//                 style: TextStyle(
//                     color: Colors.black, fontSize: 15, letterSpacing: -1),
//               ),
//             ),
//             ListTile(
//               trailing: Icon(
//                 Icons.arrow_forward_ios,
//                 size: 16,
//               ),
//               title: Text(
//                 'About Nimihub for Business',
//                 style: TextStyle(
//                     color: Colors.black, fontSize: 15, letterSpacing: -1),
//               ),
//             ),
//             ListTile(
//               trailing: Icon(
//                 Icons.arrow_forward_ios,
//                 size: 16,
//               ),
//               title: Text(
//                 'Frequently asked questions',
//                 style: TextStyle(
//                     color: Colors.black, fontSize: 15, letterSpacing: -1),
//               ),
//             ),
//             ListTile(
//               trailing: Icon(
//                 Icons.arrow_forward_ios,
//                 size: 16,
//               ),
//               title: Text(
//                 'Share the Nimihub app',
//                 style: TextStyle(
//                     color: Colors.black, fontSize: 15, letterSpacing: -1),
//               ),
//             ),
//             Text(
//               'Diagnostics',
//               style: TextStyle(fontSize: 12),
//             ),
//             ListTile(
//               trailing: Icon(
//                 Icons.arrow_forward_ios,
//                 size: 16,
//               ),
//               title: Text(
//                 'Status',
//                 style: TextStyle(
//                     color: Colors.black, fontSize: 15, letterSpacing: -1),
//               ),
//             ),
