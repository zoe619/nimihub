import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nimihub_online/models/courses.dart';
import 'package:nimihub_online/models/feature_model.dart';
import 'package:nimihub_online/models/products.dart';
import 'package:nimihub_online/models/user.dart';
import 'package:nimihub_online/models/user_data.dart';
import 'package:nimihub_online/screens/cart/cart.dart';
import 'package:nimihub_online/screens/details/details_screen.dart';
import 'package:nimihub_online/screens/discover/discover_screeen.dart';
import 'package:nimihub_online/screens/search/search_screen.dart';
import 'package:nimihub_online/screens/ebooks/ebooks.dart';
import 'package:nimihub_online/service/database.dart';
import 'package:nimihub_online/size_config.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import '../../constants.dart';

class Activities extends StatefulWidget
{
  final String email;
  Activities({this.email});
  @override
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities>
{

  List<Product> _courses;
  @override
  initState()
  {
    super.initState();

  }


  

  _getCourses() async
  {
    List<Product> courses = await Provider.of<DatabaseService>(context, listen: false).getCoursesByUser(widget.email);
    setState(() {
      _courses = courses;
    });

  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(

 
      appBar: AppBar(
       title: Text('Activities'),
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
            padding: EdgeInsets.only(right: 14),
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
//              Padding(
//                padding: EdgeInsets.only(
//                    left: getProportionateScreenHeight(10.0),
//                    bottom: getProportionateScreenHeight(10)),
//                child: Text('My Courses',
//                    style: TextStyle(
//                        fontSize: getProportionateScreenHeight(20),
//                        fontWeight: FontWeight.bold)),
//              ),
//              Padding(
//                padding: EdgeInsets.only(
//                  left: getProportionateScreenHeight(10.0),
//                ),
//                child:FutureBuilder(
//                  future: _getCourses(),
//                  builder: (BuildContext context, AsyncSnapshot snapshot)
//                  {
//                    if(_courses == null)
//                    {
//                      return Center(
//                        child: Platform.isIOS ? CupertinoActivityIndicator() : CircularProgressIndicator(),
//                      );
//                    }
//                    return ActivitiesContentRow(courses: _courses);
//                  },
//                ) ,
//              ),
//              Padding(
//                padding: EdgeInsets.only(
//                  top: getProportionateScreenHeight(15.0),
//                    left: getProportionateScreenHeight(10.0),
//                    bottom: getProportionateScreenHeight(10)),
//                child: Text('My Books',
//                    style: TextStyle(
//                        fontSize: getProportionateScreenHeight(20),
//                        fontWeight: FontWeight.bold)),
//              ),
//              Padding(
//                padding: EdgeInsets.only(
//                  left: getProportionateScreenHeight(10.0),
//                ),
//                child: BooksCatalog(),
//              ),
//              Padding(
//                padding: EdgeInsets.only(
//                  top: getProportionateScreenHeight(15.0),
//                    left: getProportionateScreenHeight(10.0),
//                    bottom: getProportionateScreenHeight(10)),
//                child: Text('Exams',
//                    style: TextStyle(
//                        fontSize: getProportionateScreenHeight(20),
//                        fontWeight: FontWeight.bold)),
//              ),
//              Padding(
//                padding: EdgeInsets.only(
//                  left: getProportionateScreenHeight(10.0),
//                ),
//                child: BooksCatalog(),
//              ),
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),

              SizedBox(height: getProportionateScreenHeight(15)),
              Divider(
                height: 1.0,
              ),
              ListTile(
                title: Transform(
                  transform: Matrix4.translationValues(0, 0, 0),
                  child: Text(
                    'Recommendations',
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
                    'Reviews',
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
                    'Championships',
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
                    'Schedules',
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
                    'Card Decks',
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
                    'Live Sessions',
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
     
class ActivitiesContentRow extends StatelessWidget
{

  final List<Courses> courses;

  const ActivitiesContentRow({
    Key key, this.courses
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenHeight(214),
      width: 400,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: courses.length,
        itemBuilder: (BuildContext context, int index) {
          final String id = courses[index].id;
          final String image = "assets/images/splash_3.png";
          final String title = courses[index].title;
          final String instructor = courses[index].instructor;
          final String price = courses[index].price;
          final String sale = courses[index].sale;
          final String desc = courses[index].desc;
          final String fullDesc = courses[index].fullDesc;
          final String dateCreated = courses[index].dateCreated;
          final String dateModified = courses[index].dateModified;

          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => DetailedScreen(
                          id:id,
                          image: image,
                          title: title,
                          desc: desc,
                          fullDesc: fullDesc,
                          instructor: instructor,
                          price: price,
                          sale: sale,
                          dateCreated: dateCreated,
                          dateModified: dateModified
                          )));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 4.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: getProportionateScreenHeight(60),
                      width: 120,
                      //color: Colors.red,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: AssetImage(featureModelList[index].image),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Container(
                        // height: 43,
                        constraints: BoxConstraints(maxWidth: 140),
                        child: Text(
                          courses[index].title,
                          style: TextStyle(fontSize: 14.0, color: Colors.black),
                        ),
                      ),
                    ),
                    courses[index].instructor != null ? Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        courses[index].instructor,
                      ),
                    ): SizedBox.shrink(),
                    Expanded(
                      child: Container(
                        // width: 100,
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.deepOrangeAccent,
                              size: 7,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.deepOrangeAccent,
                              size: 7,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.deepOrangeAccent,
                              size: 7,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.deepOrangeAccent,
                              size: 7,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.deepOrangeAccent,
                              size: 7,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text(
                                '${featureModelList[index].rating}',
                                style: TextStyle(fontSize: 8),
                              ),
                            ),
                            featureModelList[index].enrolled != null ? Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                '(${featureModelList[index].enrolled})',
                                style: TextStyle(fontSize: 12),
                              ),
                            ) : SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Row(
                        children: [
                          courses[index].price != null ?  Text(
                            '\$${courses[index].price}',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ) : SizedBox.shrink(),
                          courses[index].sale != null ? Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                                '\$${courses[index].sale}',
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 9)),
                          ): SizedBox.shrink(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text('Bestseller',
                              style: TextStyle(
                                  fontSize: 8.5, color: Colors.black)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}