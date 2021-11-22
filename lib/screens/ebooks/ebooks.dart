// import 'package:carousel_slider/carousel_slider.dart';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nimihub_online/models/books.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:nimihub_online/components/discover_category.dart';
// import 'package:nimihub_online/constants.dart';
import 'package:nimihub_online/models/feature_model.dart';
import 'package:nimihub_online/screens/details/books_details.dart';
// import 'package:nimihub_online/screens/cart/cart_screen.dart';
import 'package:nimihub_online/screens/details/details_screen.dart';
import 'package:nimihub_online/service/database.dart';
// import 'package:nimihub_online/screens/search/search_screen.dart';
import 'package:nimihub_online/size_config.dart';
import 'package:provider/provider.dart';

class EBooks extends StatefulWidget
{
  static String routeName = '/ebooks';
  @override
  _EBooksState createState() => _EBooksState();
}

class _EBooksState extends State<EBooks>
{
  int _current = 0;
  List imgList = [
    'https://images.unsplash.com/photo-1502117859338-fd9daa518a9a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1554321586-92083ba0a115?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1536679545597-c2e5e1946495?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1543922596-b3bbaba80649?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1502943693086-33b5b1cfdf2f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80'
  ];

  List<Books> _books;

  _getBooks() async
  {
    List<Books> books = await Provider.of<DatabaseService>(context, listen: false).getBooks();
    setState(() {
      _books = books;
    });

  }

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
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10.0),
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
                                          color: Colors.white.withOpacity(0.4),
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
                child: Text('Popular Books',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              FutureBuilder(
                future: _getBooks(),
                builder: (BuildContext context, AsyncSnapshot snapshot)
                {
                  if(_books == null)
                  {
                    return Center(
                      child: Platform.isIOS ? CupertinoActivityIndicator() : CircularProgressIndicator(),
                    );
                  }
                  return  BooksCatalog(books: _books);
                },
              )

            ],
          ),
        ),
      ),

    );
  }
}

class BooksCatalog extends StatelessWidget
{

  final List<Books> books;

  const BooksCatalog({
    Key key, this.books
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          final String title = books[index].title;
          final String instructor = books[index].author;
          final double rating = featureModelList[index].rating;
          final String oldAmount = books[index].price;
          final String newAmount = books[index].sale;
          final String enrolled = books[index].enrolled;
          final String type = books[index].type;
          final double money = featureModelList[index].money;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => BooksScreen(
                            id: id,
                            image: image,
                            title: title,
                            instructor: instructor,
                            rating: rating,
                            price: oldAmount.toString(),
                            sale: newAmount.toString(),
                            enrolled: enrolled,
                            type: type,
                            dateCreated: books[index].dateCreated,
                            dateModified: books[index].dateModified,
                            bought: false
                          )));
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
                         books[index].image,
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
              ) :
              Positioned(
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
                        image: AssetImage(featureModelList[index].image),
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
                          books[index].title,
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ),
                      Text(
                        books[index].author,
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
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
//                            Padding(
//                              padding: const EdgeInsets.only(left: 4.0),
//                              child: Text(
//                                '${featureModelList[index].rating}',
//                                style: TextStyle(fontSize: 10),
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              '${books[index].sale}',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              '${books[index].price}',
                              style: TextStyle(
                                  fontSize: 12,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          ),
                        ],
                      )
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

class ContentRow extends StatelessWidget {
  const ContentRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenHeight(450),
      width: 350,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: featureModelList.length,
        itemBuilder: (BuildContext context, int index) {
          final String image = featureModelList[index].image;
          final String title = featureModelList[index].title;
          final String instructor = featureModelList[index].instructor;
          final double rating = featureModelList[index].rating;
          final double oldAmount = featureModelList[index].oldAmount;
          final double newAmount = featureModelList[index].newAmount;
          final String enrolled = featureModelList[index].enrolled;
          final double money = featureModelList[index].money;
          return GestureDetector(
            child: Padding(
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
                          image: AssetImage(featureModelList[index].image),
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
                              style: TextStyle(fontSize: 8),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              '(${featureModelList[index].enrolled})',
                              style: TextStyle(fontSize: 8),
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
                            child: Text(
                                '\$${featureModelList[index].oldAmount}',
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 12)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
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
