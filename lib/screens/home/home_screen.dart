// import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:nimihub_online/models/user.dart';
import 'package:nimihub_online/models/user_data.dart';
import 'package:nimihub_online/screens/activities/activities.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:nimihub_online/screens/discover/discover_screeen.dart';
import 'package:nimihub_online/screens/library/library_screen.dart';
import 'package:nimihub_online/screens/me/me_screen.dart';
// import 'package:nimihub_online/screens/search/search_screen.dart';
import 'package:nimihub_online/screens/tools/tools_screen.dart';
import 'package:nimihub_online/screens/wishlist/wishlist_screen.dart';
import 'package:nimihub_online/service/database.dart';
import 'package:provider/provider.dart';
// import 'package:nimihub_online/screens/ebooks/ebooks.dart';
// import 'package:nimihub_online/screens/exams/exams.dart';

import '../../constants.dart';

class HomeScreen extends StatefulWidget
{
  static String routeName = '/home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
{
  String email, userId;

  @override
  initState()
  {
    userId = Provider.of<UserData>(context, listen: false).currentUserId;
    super.initState();
    _setupProfileUser();

  }

  _setupProfileUser() async
  {
    Users profileUser  = await Provider.of<DatabaseService>(context, listen: false).getUserWithId(userId);
    setState(() {
      email = profileUser.email;

    });

  }
  PageController pageController = new PageController();
  int currentIndex = 0;
  bool currentIcon = false;



  void onTap(int page) {
    setState(() {
      currentIndex = page;
    });
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: [
          DiscoverScreen(),
          ToolsScreen(),
          LibraryScreen(email: email),
          Activities(email: email),
          MeScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        iconSize: 26,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        currentIndex: currentIndex,
         backgroundColor: nearlyWhite,
        unselectedItemColor: Colors.black54,
        selectedItemColor: kPrimraryColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_off_outlined),
            label: 'Discover',
            activeIcon: Icon(Icons.explore),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.border_all),
            label: 'Tools',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books_outlined),
            activeIcon: Icon(Icons.library_books),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.favorite),
            icon: Icon(Icons.favorite_border),
            label: 'Activities',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Me',
          )
        ],
      ),
    );
  }
}
