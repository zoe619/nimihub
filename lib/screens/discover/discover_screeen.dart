import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nimihub_online/components/icon_btn_with_counter.dart';
import 'package:nimihub_online/components/top_instructor.dart';
import 'package:nimihub_online/constants.dart';
import 'package:nimihub_online/models/feature_model.dart';
import 'package:nimihub_online/models/instructor_model.dart';
import 'package:nimihub_online/models/products.dart';
import 'package:nimihub_online/models/user_data.dart';
import 'package:nimihub_online/screens/cart/cart.dart';
import 'package:nimihub_online/screens/cart/cart_screen.dart';
import 'package:nimihub_online/screens/cart/models/Cart.dart';
// import 'package:nimihub_online/screens/cart/cart_screen.dart';
import 'package:nimihub_online/screens/details/details_screen.dart';
import 'package:nimihub_online/screens/discover/components/discount_banner.dart';
import 'package:nimihub_online/screens/ebooks/ebooks.dart';
import 'package:nimihub_online/screens/exams/exams.dart';
import 'package:nimihub_online/screens/search/search_screen.dart';
import 'package:nimihub_online/screens/see_all/see_all.dart';
import 'package:nimihub_online/service/database.dart';
import 'package:nimihub_online/sizeConfig1.dart';
import 'package:nimihub_online/size_config.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

class DiscoverScreen extends StatefulWidget {
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin
{



  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
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
            //IconBtnWithCounter(svgSrc: 'assets/icons/Cart Icon.svg',press: () {  },),
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
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: Container(
              color: Colors.white,
              child: TabBar(
                physics: NeverScrollableScrollPhysics(),
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.black,
                indicatorColor: Colors.white,
                unselectedLabelStyle: TextStyle(fontSize: 12),
                controller: _tabController,
                tabs: [
                  Tab(
                    text: 'Courses',
                    icon: Icon(Icons.monitor),
                  ),
                  Tab(
                    text: 'Microbooks',
                    icon: Icon(Icons.book),
                  ),
                  Tab(
                    text: 'Exams',
                    icon: Icon(Icons.contacts),
                  ),
                ],
              ),
            ),
          ),
        ),
        // appBar:
        body: TabBarView(
          controller: _tabController,
          children: [DiscoverBody(), EBooks(), Exams()],
        ));
  }
}

class DiscoverBody extends StatefulWidget {
  @override
  _DiscoverBodyState createState() => _DiscoverBodyState();



}

class _DiscoverBodyState extends State<DiscoverBody>
{
  List<Product> _courses;

  List<Instructor> _instructors;

  _getCourses() async
  {
    List<Product> courses = await Provider.of<DatabaseService>(context, listen: false).getCourses();
    setState(() {
      _courses = courses;
    });

  }

  _getInstructor() async
  {
    List<Instructor> instructor = await Provider.of<DatabaseService>(context, listen: false).getInstructors();
    setState(() {
      _instructors = instructor;
    });

  }

  @override
  initState(){
    super.initState();

  }
  int _current = 0;
  List imgList = [
    'https://images.unsplash.com/photo-1502117859338-fd9daa518a9a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1554321586-92083ba0a115?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1536679545597-c2e5e1946495?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1543922596-b3bbaba80649?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1502943693086-33b5b1cfdf2f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80'
    // 'assets/home/01 - Naruto and Jiraiya the Toad Sage.jpg',
    // 'assets/home/20 - Gaara and Sasori.jpg',
    // 'assets/home/22 - Akatsuki X S Ninja.jpg',
    // 'assets/home/app.png',
    // 'assets/home/images (1).jpeg',
    // 'assets/home/img.jpeg'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(height:77, child: DiscoverCategories()),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () {
                      print("Index is " + _current.toString());
                    },
                    child: Stack(
                      children: <Widget>[
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 200,
                            initialPage: 0,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            reverse: false,
                            enableInfiniteScroll: true,
                            autoPlayInterval: Duration(seconds: 5),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 2000),
                            pauseAutoPlayOnTouch: true,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (index, CarouselChangeReason) {
                              setState(() {
                                _current = index;
                              });
                            },
                          ),
                          items: imgList.map((imgUrl) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Stack(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: imgUrl,
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) => Container(
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator())),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: IconButton(
                                          icon: Icon(
                                            Icons.play_arrow,
                                            size: 100,
                                            color:
                                                Colors.white.withOpacity(0.4),
                                          ),
                                          onPressed: () {}),
                                    )
                                  ],
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                DiscountBanner(),
                Padding(
                  padding:
                      EdgeInsets.only(right: getProportionateScreenWidth(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: getProportionateScreenWidth(10), top: getProportionateScreenWidth(15)),
                        child: CategoryTitle(title: 'Featured'),
                      ),
                      GestureDetector(
                        onTap: () => Get.to(SeeAll(courses: _courses)),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: getProportionateScreenHeight(15)),
                              child: Text('See all'),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: getProportionateScreenWidth(10.0), 
                                  top: getProportionateScreenHeight(15),),
                              child: Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: getProportionateScreenHeight(18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: getProportionateScreenWidth(10.0),
                   top: getProportionateScreenHeight(15),),
                  child: FutureBuilder(
                      future: _getCourses(),
                      builder: (BuildContext context, AsyncSnapshot snapshot)
                      {
                        if(_courses == null)
                        {
                          return Center(
                            child: Platform.isIOS ? CupertinoActivityIndicator() : CircularProgressIndicator(),
                          );
                        }
                        return ContentRow(courses: _courses);
                      },
                     )

                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: CategoryTitle(title: 'Top Instructors'),
                ),

                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
                    child: FutureBuilder(
                      future: _getInstructor(),
                      builder: (BuildContext context, AsyncSnapshot snapshot)
                      {
                        if(_instructors == null)
                        {
                          return SizedBox.shrink();
                        }
                        return TopInstructors(instructors: _instructors);
                      },
                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      CategoryTitle(title: 'Top courses in'),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          ' Business',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TopCourseRow(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      CategoryTitle(title: 'Top courses in'),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 10),
                        child: Text(
                          ' Development',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
//                  child: ContentRow(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      CategoryTitle(title: 'Top courses in'),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          ' IT & Software',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
//                  child: ContentRow(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      CategoryTitle(title: 'Top courses in'),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          ' Personal Develepment',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
//                  child: ContentRow(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      CategoryTitle(title: 'Top courses in'),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          ' Instrument',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
//                  child: ContentRow(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: CategoryTitle(title: 'Student are viewing'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
//                  child: ContentRow(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      CategoryTitle(title: 'What people who learn'),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          ' PLC',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
//                      CategoryTitle(title: 'take next'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
//                  child: ContentRow(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryTitle extends StatelessWidget {
  const CategoryTitle({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(8), top: 10),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ContentRow extends StatelessWidget
{

  final List<Product> courses;

  const ContentRow({
    Key key, this.courses
  }) : super(key: key);




  @override
  Widget build(BuildContext context)
  {
    return SizedBox(
      height: getProportionateScreenHeight(340),
      width: double.infinity,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: courses.length,
        itemBuilder: (BuildContext context, int index)
        {
          final String id = courses[index].id;
//          final String image = "assets/images/splash_3.png";
          final String image = courses[index].image;
          final String title = courses[index].title;
          final String instructor = courses[index].instructor;
          final String price = courses[index].price;
          final String sale = courses[index].sale;
          final String desc = courses[index].desc;
          final String fullDesc = courses[index].fullDesc;
//          final String category = courses[index].category;
          final String status = courses[index].status;
          final String enrolled = courses[index].enrolled;
//          final String rating = courses[index].ratings;
          final String numContents = courses[index].numContents;
          final String numRatings = courses[index].numRatings;
//          final String similar = courses[index].similar;
          final String toLearn = courses[index].toLearn;
          final String requirements = courses[index].requirements;
          final String duration = courses[index].duration;
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
                            dateModified: dateModified,
                            type: courses[index].type,
                            bought: false,
                            requirements: requirements

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
                        height: getProportionateScreenHeight(155),
                        width: getProportionateScreenWidth(200),
                        //color: Colors.red,
                        child: Image.network(
                          image,
                          fit: BoxFit.fill,
                        ),
                      ) :
                      Container(
                        height: getProportionateScreenHeight(155),
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
                          height: getProportionateScreenHeight(48),
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
                      Container(
                        width: getProportionateScreenWidth(180),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.deepOrangeAccent,
                              size: 15,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.deepOrangeAccent,
                              size: 15,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.deepOrangeAccent,
                              size: 15,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.deepOrangeAccent,
                              size: 15,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.deepOrangeAccent,
                              size: 15,
                            ),
//                            Padding(
//                              padding: EdgeInsets.only(left: getProportionateScreenWidth(8.0)),
//                              child: Text(
//                                '${courses[index].ratings}',
//                                style: TextStyle(fontSize: 12),
//                              ),
//                            ),
                            Padding(
                              padding:  EdgeInsets.only(left: getProportionateScreenWidth(4.0)),
                              child: Text(
                                '(${courses[index].enrolled})',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                      Padding(
                        padding: EdgeInsets.only(top: getProportionateScreenHeight(8.0)),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text('Bestseller',
                                style: TextStyle(
                                    fontSize: 7.5, color: Colors.black)),
                          ),
                        ),
                      ),
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

class TopCourseRow extends StatelessWidget {
  const TopCourseRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenHeight(300),
      width: 400,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: featureModelList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: getProportionateScreenHeight(130),
                    width: 180,
                    //color: Colors.red,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage("assets/images/splash_2.png"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Container(
                      height: 43,
                      constraints: BoxConstraints(maxWidth: 200),
                      child: Text(
                        featureModelList[index].title,
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      featureModelList[index].instructor,
                    ),
                  ),
                  Container(
                    width: 180,
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.deepOrangeAccent,
                          size: 15,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.deepOrangeAccent,
                          size: 15,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.deepOrangeAccent,
                          size: 15,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.deepOrangeAccent,
                          size: 15,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.deepOrangeAccent,
                          size: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            '${featureModelList[index].rating}',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            '(${featureModelList[index].enrolled})',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Row(
                      children: [
                        Text(
                          '\$${featureModelList[index].newAmount}',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text('\$${featureModelList[index].oldAmount}',
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 8.0),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       color: Colors.orange,
                  //       borderRadius: BorderRadius.circular(4),
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(4.0),
                  //       child: Text('Bestseller',
                  //           style:
                  //           TextStyle(fontSize: 11.5, color: Colors.black)),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
