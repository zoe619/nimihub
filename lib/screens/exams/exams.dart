import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nimihub_online/constants.dart';
import 'package:nimihub_online/models/examModel.dart';
import 'package:nimihub_online/models/feature_model.dart';
import 'package:nimihub_online/models/products.dart';
import 'package:nimihub_online/screens/details/details_screen.dart';
import 'package:nimihub_online/screens/details/exam_details.dart';
import 'package:nimihub_online/screens/search/search_screen.dart';
import 'package:nimihub_online/service/database.dart';
import 'package:nimihub_online/size_config.dart';
import 'package:provider/provider.dart';

class Exams extends StatefulWidget {
  static String routeName = '/exams';
  @override
  _ExamsState createState() => _ExamsState();
}

class _ExamsState extends State<Exams>
{

  List<ExamModel> _exams;

  _getExams() async
  {
    List<ExamModel> exams = await Provider.of<DatabaseService>(context, listen: false).getExams();
    setState(() {
      _exams = exams;

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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                                        placeholder: (context, url)=>Container(child: Center(child: CircularProgressIndicator())),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
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
              Padding(
                padding: EdgeInsets.only(bottom: 10, left: 20),
                child: Text('Exams',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              FutureBuilder(
                future: _getExams(),
                builder: (BuildContext context, AsyncSnapshot snapshot)
                {
                  if(_exams == null)
                  {
                    return Center(
                      child: Platform.isIOS ? CupertinoActivityIndicator() : CircularProgressIndicator(),
                    );
                  }
                  return CardStack(exams: _exams);
                },
              )

            ],
          ),
        ),
      ),

    );
  }
}

class CardStack extends StatelessWidget
{
  final List<ExamModel> exams;

  const CardStack({
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
        itemCount: exams.length - 1,
        shrinkWrap: true,
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
                            bought: false,
                            dateCreated: exams[index].dateCreated,
                            dateModified: exams[index].dateModified
                            )

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
              )
             : Positioned(
                left: 10,
                bottom: 25,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 15,
                  ),
                  child: Container(
                    height: getProportionateScreenHeight(180),
                    width: 120,
                    //color: Colors.red,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4),
                      image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image:
                            AssetImage(featureModelList[index].image),
                      ),
                    ),
                  ),
                ),
              ),
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
                        child: Text(
                          exams[index].title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                         Text(
                        exams[index].instructor,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
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
//                            Padding(
//                              padding: const EdgeInsets.only(left: 4.0),
//                              child: Text(
//                                '${exams[index].ratings}',
//                                style: TextStyle(fontSize: 12),
//                              ),
//                            ),
                            
                          ],
                        ),

                      ),
                      Row(children: [
                      Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                '${exams[index].sale}',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                '${exams[index].price}',
                                style: TextStyle(fontSize: 12, decoration: TextDecoration.lineThrough),
                                
                              ),
                            ),
                            ],)
                    ],
                    
                  ),
                  // child: Placeholder(),
                ),
              )
            ]),
          );
        },
      ),
    );
  }
}

// class Exams extends StatefulWidget {
//   Exams({Key key}) : super(key: key);

//   @override
//   _ExamsState createState() => _ExamsState();
// }

// class _ExamsState extends State<Exams> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text('Exam'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             iconSize: 30,
//             onPressed: () {
//               print('search');
//               Navigator.pushNamed(context, SearchScreen.routeName);
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           child: Column(
//             children: [
//               Stack(
//                 children: [
//                   SizedBox(
//                     //height: getProportionateScreenHeight(300),
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                           left: getProportionateScreenWidth(20),
//                           right: getProportionateScreenWidth(20),
//                           top: getProportionateScreenWidth(60)),
//                       child: Container(
//                         //height: getProportionateScreenHeight(250),
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                             gradient: kPrimaryColorGradient,
//                             borderRadius: BorderRadius.circular(7)),
//                         child: Column(
//                           children: [
//                             SizedBox(height: getProportionateScreenHeight(90)),
//                             Text('What is the SI Unit of mass?',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize:
//                                         getProportionateScreenHeight(20))),
//                             Text(
//                               'form Mass, Force and Work',
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: getProportionateScreenHeight(13)),
//                             ),
//                             SizedBox(height: getProportionateScreenHeight(20)),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     //left: getProportionateScreenWidth(10),
//                     top: getProportionateScreenHeight(15),
//                     right: getProportionateScreenWidth(135),
//                     child: Container(
//                       height: getProportionateScreenHeight(125),
//                       width: getProportionateScreenWidth(120),
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(150),
//                           border: Border.all(color: kPrimraryColor, width: 5)),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           TweenAnimationBuilder(
//                             tween: Tween(begin: 60.0, end: 0),
//                             duration: Duration(seconds: 60),
//                             builder: (context, value, child) => Text(
//                               "00:${value.toInt()}",
//                               style: TextStyle(
//                                   color: kPrimraryColor,
//                                   fontSize: getProportionateScreenHeight(24)),
//                             ),
//                             onEnd: () {},
//                           ),
//                           Text('mins left',
//                               style: TextStyle(color: kTextColor)),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
