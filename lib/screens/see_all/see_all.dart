import 'package:flutter/material.dart';
import 'package:nimihub_online/models/feature_model.dart';
import 'package:nimihub_online/models/products.dart';
import 'package:nimihub_online/screens/details/details_screen.dart';

import '../../size_config.dart';

class SeeAll extends StatefulWidget
{
  List<Product> courses;
  @override
  _SeeAllState createState() => _SeeAllState();

  SeeAll({this.courses});
}

class _SeeAllState extends State<SeeAll>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: GridView.builder(
          itemCount: widget.courses.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            final seeAllList = widget.courses[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => DetailedScreen(
                            id:widget.courses[index].id,
                            image: widget.courses[index].image,
                            title: widget.courses[index].title,
                            desc: widget.courses[index].desc,
                            fullDesc: widget.courses[index].fullDesc,
                            instructor: widget.courses[index].instructor,
                            price: widget.courses[index].price,
                            sale: widget.courses[index].sale,
                            dateCreated:widget.courses[index].dateCreated,
                            dateModified: widget.courses[index].dateModified,
                            type: widget.courses[index].type,
                            bought: false,
                            requirements: widget.courses[index].requirements

                        )));
              },
              child: Card(
                child: Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          seeAllList.image != null ? Container(
                            height: getProportionateScreenHeight(80),
                            width: getProportionateScreenWidth(150),
                            //color: Colors.red,
                            child: Image.network(
                              seeAllList.image,
                              fit: BoxFit.fill,
                            ),
                          ) :
                      Container(
                        height: getProportionateScreenHeight(80),
                        width: getProportionateScreenWidth(150),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(7),
                          image: DecorationImage(
                              image: AssetImage("assets/images/splash_3.png"),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Text(seeAllList.title),
                      Column(
                        children: [
                          Text(seeAllList.instructor),
                          Container(
                            // width: 180,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.deepOrangeAccent,
                                  size: 8,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.deepOrangeAccent,
                                  size: 8,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.deepOrangeAccent,
                                  size: 8,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.deepOrangeAccent,
                                  size: 8,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.deepOrangeAccent,
                                  size: 8,
                                ),
//                              Padding(
//                                padding: const EdgeInsets.only(left: 8.0),
//                                child: Text(
//                                  '${seeAllList.rating}',
//                                  style: TextStyle(fontSize: 12),
//                                ),
//                              ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    '(${seeAllList.enrolled})',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '\NGN${seeAllList.sale}',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text('\NGN${seeAllList.price}',
                                    style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 10)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ])),
              ),
            );
          },
        ),
      ),
    );
  }
}
