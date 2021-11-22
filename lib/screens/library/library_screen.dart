import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nimihub_online/models/courses.dart';
import 'package:nimihub_online/models/feature_model.dart';
import 'package:nimihub_online/models/itemsCount.dart';
import 'package:nimihub_online/models/products.dart';
import 'package:nimihub_online/models/user.dart';
import 'package:nimihub_online/models/user_data.dart';
import 'package:nimihub_online/screens/cart/cart.dart';
import 'package:nimihub_online/screens/cart/cart_screen.dart';
import 'package:nimihub_online/screens/course_info/course_info.dart';
import 'package:nimihub_online/screens/details/details_screen.dart';
import 'package:nimihub_online/screens/discover/discover_screeen.dart';
import 'package:nimihub_online/screens/purchasedItems.dart';
import 'package:nimihub_online/screens/search/search_screen.dart';
import 'package:get/get.dart';
import 'package:nimihub_online/screens/tools/bookmarks.dart';
import 'package:nimihub_online/service/database.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../size_config.dart';

class LibraryScreen extends StatefulWidget
{
  final String email;
  LibraryScreen({this.email});

  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
{
  String email, userId;
  List<Product> _courses;
  List<Courses> _viewedCourses;
  List<ItemCount> _itemCount;
  int course = 0;

  @override
  initState()
  {
    userId = Provider.of<UserData>(context, listen: false).currentUserId;
    super.initState();
    _setupProfileUser();
    _getCourses();
    _getItemCount();

  }

  _setupProfileUser() async
  {
    Users profileUser  = await Provider.of<DatabaseService>(context, listen: false).getUserWithId(userId);
    setState(() {
      email = profileUser.email;

    });


  }



  _getCourses() async
  {
    List<Product> courses = await Provider.of<DatabaseService>(context, listen: false).getCoursesByUser(widget.email);
    setState(() {
      _courses = courses;
      course = _courses.length;
    });

  }

  _getViewedCourses() async
  {
    List<Courses> courses = await Provider.of<DatabaseService>(context, listen: false).getViewedCoursesByUser(widget.email);
    setState(() {
      _viewedCourses = courses;

    });

  }

  _getItemCount() async
  {
    List<ItemCount> item = await Provider.of<DatabaseService>(context, listen: false).getItemCountsByUser(widget.email);
    setState(() {
      _itemCount = item;

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          child: IconButton(
            icon: Icon(EvaIcons.bellOutline),
            iconSize: 23,
            onPressed: () {
              print('search');
            },
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            iconSize: 30,
            onPressed: () {
              print('search');
              Navigator.pushNamed(context, SearchScreen.routeName);
            },
          ),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: getProportionateScreenHeight(10.0),
                    bottom: getProportionateScreenHeight(10)),
                child: Text('Recently Viewed Courses',
                    style: TextStyle(
                        fontSize: getProportionateScreenHeight(18),
                        fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: getProportionateScreenHeight(10.0),
                ),
                child: FutureBuilder(
                  future: _getViewedCourses(),
                  builder: (BuildContext context, AsyncSnapshot snapshot)
                  {
                    if(_viewedCourses == null)
                    {
                      return Center(
                        child: Platform.isIOS ? CupertinoActivityIndicator() : CircularProgressIndicator(),
                      );
                    }
                    return RecentlyContentRow(courses: _viewedCourses);
                  },
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              ListTile(
                leading: Icon(
                  EvaIcons.browserOutline,
                  size: getProportionateScreenHeight(26),
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-22, 0, 0),
                  child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>PurchasedItems(email: widget.email, type: "My Courses")));
                      },
                    child: Text(
                      'My Courses',
                      style: TextStyle(
                          fontSize: getProportionateScreenHeight(20),
                          color: kTextColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                 subtitle:
                 Transform(
                    transform: Matrix4.translationValues(-22, 0, 0),
                    child:GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>PurchasedItems(email: email,type: "My Courses")));
                        },
                        child: _itemCount != null ?  Text(_itemCount[0].courseCount) : SizedBox.shrink())
                )
              ),
              ListTile(
                leading: Icon(
                  EvaIcons.bookOpen,
                  size: getProportionateScreenHeight(26),
                ),
                title: Transform(
                  transform: Matrix4.translationValues(getProportionateScreenWidth(-13), 0, 0),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>PurchasedItems(email: widget.email, type: "My Books")));
                    },
                    child: Text(
                      'My Microbooks',
                      style: TextStyle(
                          fontSize: getProportionateScreenHeight(18),
                          color: kTextColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                subtitle: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>PurchasedItems(email: widget.email, type: "My Books")));
                  },
                  child: Transform(
                      transform: Matrix4.translationValues(getProportionateScreenWidth(-13), 0, 0),
                      child: _itemCount != null ? Text(_itemCount[0].notesCount) : SizedBox.shrink()),
                ),
              ),
              ListTile(
                leading: Icon(
                  EvaIcons.barChart2Outline,
                  size: getProportionateScreenHeight(26),
                ),
                title: Transform(
                  transform: Matrix4.translationValues(getProportionateScreenWidth(-13), 0, 0),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>PurchasedItems(email: widget.email, type: "My Exams")));
                    },
                      child: Text(
                        'My Exams',
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(18),
                            color: kTextColor,
                            fontWeight: FontWeight.bold),
                      ),

                  ),
                ),
                   subtitle: GestureDetector(
                     onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (_)=>PurchasedItems(email: widget.email, type: "My Exams")));
                     },
                     child: Transform(
                         transform: Matrix4.translationValues(-22, 0, 0),
                         child: _itemCount != null ? Text(_itemCount[0].examCount) : SizedBox.shrink()),
                   ),
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
              Divider(
                height: 1.0,
              ),
              ListTile(
                title: Transform(
                  transform: Matrix4.translationValues(0, 0, 0),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>BookMarkScreen(email: email)));
                    },
                    child: Text(
                      'Bookmarks',
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(18),
                        color: kTextColor,
                        //fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Transform(
                  transform: Matrix4.translationValues(0, 0, 0),
                  child: Text(
                    'Analytics',
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(18),
                      color: kTextColor,
                      //fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Transform(
                  transform: Matrix4.translationValues(0, 0, 0),
                  child: Text(
                    'Achievements',
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(18),
                      color: kTextColor,
                      //fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Transform(
                  transform: Matrix4.translationValues(0, 0, 0),
                  child: Text(
                    'Scheduled Championship',
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(18),
                      color: kTextColor,
                      //fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ],
          ))),
    );
  }
}


class RecentlyContentRow extends StatelessWidget
{
  final List<Courses> courses;

  const RecentlyContentRow({
    Key key, this.courses
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenHeight(230),
      width: double.infinity,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: courses.length,
        itemBuilder: (BuildContext context, int index)
        {
//          final String image = featureModelList[index].image;
          final String image = courses[index].image;
          final String title = courses[index].title;
          final String instructor = courses[index].instructor;
//          final double rating = courses[index].ratings;
          final String oldAmount = courses[index].price;
          final String newAmount = courses[index].sale;
          final String enrolled = courses[index].enrolled;
          final double money = featureModelList[index].money;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => DetailedScreen(
                            image: image,
                            title: title,
                            instructor: instructor,
                            price: oldAmount.toString(),
                            sale: newAmount.toString(),
                            enrolled: enrolled,
                            bought: false,
                          )));
            },
            child: Card(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10.0),),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      image != null ? Container(
                        height: getProportionateScreenHeight(100),
                        width: getProportionateScreenWidth(200),
                        //color: Colors.red,
                        child: Image.network(
                          image,
                          fit: BoxFit.fill,
                        ),
                      ) :
                      Container(
                        height: getProportionateScreenHeight(100),
                        width: getProportionateScreenWidth(200),
                        //color: Colors.red,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: AssetImage(featureModelList[index].image),
                          ),

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: getProportionateScreenHeight(8.0)),
                        child: Container(
                          height: getProportionateScreenHeight(43),
                          constraints: BoxConstraints(maxWidth: getProportionateScreenWidth(200)),
                          child: Text(
                            courses[index].title,
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top: getProportionateScreenHeight(8.0)),
                        child: Text(
                          courses[index].instructor,
                        ),
                      ),
                      // Container(
                      //   width: getProportionateScreenWidth(180),
                      //   child: Row(
                      //     children: [
                      //       Icon(
                      //         Icons.star,
                      //         color: Colors.deepOrangeAccent,
                      //         size: 15,
                      //       ),
                      //       Icon(
                      //         Icons.star,
                      //         color: Colors.deepOrangeAccent,
                      //         size: 15,
                      //       ),
                      //       Icon(
                      //         Icons.star,
                      //         color: Colors.deepOrangeAccent,
                      //         size: 15,
                      //       ),
                      //       Icon(
                      //         Icons.star,
                      //         color: Colors.deepOrangeAccent,
                      //         size: 15,
                      //       ),
                      //       Icon(
                      //         Icons.star,
                      //         color: Colors.deepOrangeAccent,
                      //         size: 15,
                      //       ),
                      //       Padding(
                      //         padding: EdgeInsets.only(left: getProportionateScreenWidth(8.0)),
                      //         child: Text(
                      //           '${featureModelList[index].rating}',
                      //           style: TextStyle(fontSize: 12),
                      //         ),
                      //       ),
                      //       Padding(
                      //         padding:  EdgeInsets.only(left: getProportionateScreenWidth(4.0)),
                      //         child: Text(
                      //           '(${featureModelList[index].enrolled})',
                      //           style: TextStyle(fontSize: 12),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Padding(
                        padding:  EdgeInsets.only(top: getProportionateScreenHeight(4.0)),
                        child: Row(
                          children: [
                            Text(
                              '\NGN${courses[index].sale}',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: getProportionateScreenWidth(8.0)),
                              child: Text(
                                  '\NGN${courses[index].price}',
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 12)),
                            ),
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(top: getProportionateScreenHeight(8.0)),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: Colors.orange,
                      //       borderRadius: BorderRadius.circular(4),
                      //     ),
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(4.0),
                      //       child: Text('Bestseller',
                      //           style: TextStyle(
                      //               fontSize: 11.5, color: Colors.black)),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}