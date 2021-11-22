import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nimihub_online/models/books.dart';
import 'package:nimihub_online/models/courses.dart';
import 'package:nimihub_online/models/examModel.dart';
import 'package:nimihub_online/models/feature_model.dart';
import 'package:nimihub_online/models/products.dart';
import 'package:nimihub_online/models/user.dart';
import 'package:nimihub_online/models/user_data.dart';
import 'package:nimihub_online/screens/cart/cart.dart';
import 'package:nimihub_online/screens/details/books_details.dart';
import 'package:nimihub_online/screens/details/details_screen.dart';
import 'package:nimihub_online/screens/details/exam_details.dart';
import 'package:nimihub_online/screens/discover/discover_screeen.dart';
import 'package:nimihub_online/screens/quiz_screen.dart';
import 'package:nimihub_online/screens/search/search_screen.dart';
import 'package:nimihub_online/screens/ebooks/ebooks.dart';
import 'package:nimihub_online/service/database.dart';
import 'package:nimihub_online/size_config.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';


class PurchasedItems extends StatefulWidget
{
  final String email, type;
  PurchasedItems({this.email,this.type});
  @override
  _PurchasedItemsState createState() => _PurchasedItemsState();
}

class _PurchasedItemsState extends State<PurchasedItems>
{

  List<Product> _courses;
  List<ExamModel> _exams;
  List<Books> _books;

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

  _getExams() async
  {
    List<ExamModel> exams = await Provider.of<DatabaseService>(context, listen: false).getExamsByUser(widget.email);
    setState(() {
      _exams = exams;
    });

  }

  _getBooks() async
  {
    List<Books> books = await Provider.of<DatabaseService>(context, listen: false).getBooksByUser(widget.email);
    setState(() {
      _books = books;
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
              Padding(
                padding: EdgeInsets.only(
                    left: getProportionateScreenHeight(10.0),
                    bottom: getProportionateScreenHeight(10)),
                child: Text(widget.type,
                    style: TextStyle(
                        fontSize: getProportionateScreenHeight(20),
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 40.0),
              Padding(
                padding: EdgeInsets.only(
                  left: getProportionateScreenHeight(10.0),
                ),
                child: widget.type == "My Courses" ? FutureBuilder(
                  future: _getCourses(),
                  builder: (BuildContext context, AsyncSnapshot snapshot)
                  {
                    if(_courses == null)
                    {
                      return Center(
                        child: Platform.isIOS ? CupertinoActivityIndicator() : CircularProgressIndicator(),
                      );
                    }
                    return ActivitiesContentRow(courses: _courses);
                  },
                ) : widget.type == "My Exams" ? FutureBuilder(
                  future: _getExams(),
                  builder: (BuildContext context, AsyncSnapshot snapshot)
                  {
                    if(_exams == null)
                    {
                      return Center(
                        child: Platform.isIOS ? CupertinoActivityIndicator() : CircularProgressIndicator(),
                      );
                    }
                    return ActivitiesContentRow2(exams: _exams);
                  },
                ) : FutureBuilder(
                  future: _getBooks(),
                  builder: (BuildContext context, AsyncSnapshot snapshot)
                  {
                    if(_books == null)
                    {
                      return Center(
                        child: Platform.isIOS ? CupertinoActivityIndicator() : CircularProgressIndicator(),
                      );
                    }
                    return ActivitiesContentRow3(books: _books);
                  },
                )
              ),
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

                ],
              ))),
    );
  }
}

class ActivitiesContentRow extends StatelessWidget
{

  final List<Product> courses;

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
                          bought: true,
                          type: courses[index].type,
                      )));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 4.0),
              child: Container(
                height: getProportionateScreenHeight(140),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    image != null ? Container(
                      height: getProportionateScreenHeight(80),
                      width: getProportionateScreenWidth(200),
                      //color: Colors.red,
                      child: Image.network(
                        image,
                        fit: BoxFit.fill,
                      ),
                    ) :
                    Container(
                      height: getProportionateScreenHeight(80),
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
                      padding: EdgeInsets.only(top: 8.0),
                      child: Container(
                        // height: 43,
                        constraints: BoxConstraints(maxWidth: 140),
                        child: title != null ? Text(
                          courses[index].title,
                          style: TextStyle(fontSize: 14.0, color: Colors.black),
                        ) : SizedBox.shrink(),
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
//                              child: Text(
//                                '${courses[index].ratings}',
//                                style: TextStyle(fontSize: 8),
//                              ),
                            ),
                            courses[index].enrolled != null ? Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                '(${courses[index].enrolled})',
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
                            '\NGN${courses[index].price}',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ) : SizedBox.shrink(),
                          courses[index].sale != null ? Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                                '\NGN${courses[index].sale}',
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 9)),
                          ): SizedBox.shrink(),
                        ],
                      ),
                    ),
//                    Padding(
//                      padding: const EdgeInsets.only(top: 4.0),
//                      child: Container(
//                        decoration: BoxDecoration(
//                          color: Colors.orange,
//                          borderRadius: BorderRadius.circular(4),
//                        ),
//                        child: Padding(
//                          padding: const EdgeInsets.all(4.0),
//                          child: Text('Bestseller',
//                              style: TextStyle(
//                                  fontSize: 8.5, color: Colors.black)),
//                        ),
//                      ),
//                    ),
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

class ActivitiesContentRow2 extends StatelessWidget
{

  final List<ExamModel> exams;

  const ActivitiesContentRow2({
    Key key, this.exams
  }) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return SizedBox(
      height: getProportionateScreenHeight(214),
      width: 400,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: exams.length,
        itemBuilder: (BuildContext context, int index)
        {
          final String id = exams[index].id;
          final String examId =  exams[index].examId;
          final String image = "https://www.nimihub.com/admin/app/inc/services/"+exams[index].image;
//          final String image = "assets/images/splash_3.png";
          final String title = exams[index].title;
          final String instructor = exams[index].instructor;
          final String rating = exams[index].ratings;
          final String oldAmount = exams[index].price;
          final String newAmount = exams[index].sale;
          final String enrolled = exams[index].enrolled;
          final double money = featureModelList[index].money;
          final List<String> years = exams[index].years;
          final List<String> courses = exams[index].courses;
          final List<String> questionTypes = exams[index].questionTypes;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ExamDetailedScreen(
                      id:id,
                      examId: examId,
                      image: image,
                      title: title,
                      instructor: instructor,
                      price: oldAmount.toString(),
                      sale: newAmount.toString(),
                      enrolled: enrolled,
                      type: 'exam',
                      years: years,
                      courses: courses,
                      questionTypes: questionTypes,
                      bought: true,
                      dateCreated: exams[index].dateCreated,
                      dateModified: exams[index].dateModified
                    ),
                  )
              );
            },
            child: Stack(children: [
              exams[index].image != null ? SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Container(
                    height: 340,
                    width: 320,
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                       child: Image.network(
                         image,
                         fit: BoxFit.fill,
                       ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      margin: EdgeInsets.all(10),
                    ),
                  ),
                ),
              ) : SizedBox.shrink(),
              Positioned(
                top: 52,
                left: 160,
                bottom: 25,
                child: Container(
                  height: 63,
                  width: 135,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: getProportionateScreenHeight(65),
                        child: title != null ? Text(
                          exams[index].title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ) : SizedBox.shrink(),
                      ),
                      instructor != null ? Text(
                        exams[index].instructor,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ) : SizedBox.shrink(),
//                      Container(
//                        child: Row(
//                          // crossAxisAlignment: CrossAxisAlignment.start,
//                          // mainAxisAlignment: MainAxisAlignment.start,
//                          children: [
//                            Icon(
//                              Icons.star,
//                              color: Colors.deepOrangeAccent,
//                              size: 12,
//                            ),
//                            Icon(
//                              Icons.star,
//                              color: Colors.deepOrangeAccent,
//                              size: 12,
//                            ),
//                            Icon(
//                              Icons.star,
//                              color: Colors.deepOrangeAccent,
//                              size: 12,
//                            ),
//                            Icon(
//                              Icons.star,
//                              color: Colors.deepOrangeAccent,
//                              size: 12,
//                            ),
//                            Icon(
//                              Icons.star,
//                              color: Colors.deepOrangeAccent,
//                              size: 12,
//                            ),
//                           rating != null ? Padding(
//                              padding: const EdgeInsets.only(left: 4.0),
//                              child: Text(
//                                '${exams[index].ratings}',
//                                style: TextStyle(fontSize: 12),
//                              ),
//                            ) : SizedBox.shrink()
//
//                          ],
//                        ),
//
//                      ),
                      Row(children: [
                       newAmount != null ? Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            '${exams[index].sale}',
                            style: TextStyle(fontSize: 12),
                          ),
                        ) : SizedBox.shrink(),
                       oldAmount != null ? Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            '${exams[index].price}',
                            style: TextStyle(fontSize: 12, decoration: TextDecoration.lineThrough),

                          ),
                        ) : SizedBox.shrink()
                      ],),

                    ],

                  ),
                  // child: Placeholder(),
                ),
              ),
//              GestureDetector(
//                onTap: (){
//                  Navigator.push(context, MaterialPageRoute(builder: (_)=>QuizScreen()));
//                },
//                child: Padding(
//                  padding: EdgeInsets.only(top: getProportionateScreenHeight(8.0)),
//                  child: Container(
//                    decoration: BoxDecoration(
//                      color: Colors.orange,
//                      borderRadius: BorderRadius.circular(4),
//                    ),
//                    child: Padding(
//                      padding: const EdgeInsets.all(4.0),
//                      child: Text('Take Exam',
//                          style: TextStyle(
//                              fontSize: 10.5, color: Colors.black)),
//                    ),
//                  ),
//                ),
//              ),
            ]
            ),
          );
        },
      ),
    );
  }
}

class ActivitiesContentRow3 extends StatelessWidget
{

  final List<Books> books;

  const ActivitiesContentRow3({
    Key key, this.books
  }) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return SizedBox(
      height: getProportionateScreenHeight(214),
      width: 400,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        itemBuilder: (BuildContext context, int index)
        {
          final String id = books[index].id;
          final String image = books[index].image;
//          final String image = "assets/images/splash_3.png";
          final String title = books[index].title;
          final String instructor = books[index].author;

          final String oldAmount = books[index].price;
          final String newAmount = books[index].sale;
          final String enrolled = books[index].enrolled;
          final double money = featureModelList[index].money;

          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BooksScreen(
                      id:id,
                      image: image,
                      title: title,
                      instructor: instructor,
                      price: oldAmount.toString(),
                      sale: newAmount.toString(),
                      enrolled: enrolled,
                      type: 'books',
                      bought: true,
                      dateCreated: books[index].dateCreated,
                      dateModified: books[index].dateModified,
                    ),
                  )
              );
            },
            child: Stack(children: [
              books[index].image != null ? SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Container(
                    height: 340,
                    width: 320,
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image.network(
                        image,
                        fit: BoxFit.fill,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      margin: EdgeInsets.all(10),
                    ),
                  ),
                ),
              ) : SizedBox.shrink(),
              Positioned(
                top: 52,
                left: 160,
                bottom: 25,
                child: Container(
                  height: 63,
                  width: 135,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: getProportionateScreenHeight(65),
                        child: title != null ? Text(
                          books[index].title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ) : SizedBox.shrink(),
                      ),
                      instructor != null ? Text(
                        books[index].author,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ) : SizedBox.shrink(),
                      Container(
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.deepOrangeAccent,
                              size: 12,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.deepOrangeAccent,
                              size: 12,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.deepOrangeAccent,
                              size: 12,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.deepOrangeAccent,
                              size: 12,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.deepOrangeAccent,
                              size: 12,
                            ),
                          ],
                        ),

                      ),
                      Row(children: [
                        newAmount != null ? Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            '${books[index].sale}',
                            style: TextStyle(fontSize: 12),
                          ),
                        ) : SizedBox.shrink(),
                        oldAmount != null ? Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            '${books[index].price}',
                            style: TextStyle(fontSize: 12, decoration: TextDecoration.lineThrough),

                          ),
                        ) : SizedBox.shrink()
                      ],),

                    ],

                  ),
                  // child: Placeholder(),
                ),
              ),
//              GestureDetector(
//                onTap: (){
//                  Navigator.push(context, MaterialPageRoute(builder: (_)=>QuizScreen()));
//                },
//                child: Padding(
//                  padding: EdgeInsets.only(top: getProportionateScreenHeight(8.0)),
//                  child: Container(
//                    decoration: BoxDecoration(
//                      color: Colors.orange,
//                      borderRadius: BorderRadius.circular(4),
//                    ),
//                    child: Padding(
//                      padding: const EdgeInsets.all(4.0),
//                      child: Text('Take Exam',
//                          style: TextStyle(
//                              fontSize: 10.5, color: Colors.black)),
//                    ),
//                  ),
//                ),
//              ),
            ]
            ),
          );
        },
      ),
    );
  }
}