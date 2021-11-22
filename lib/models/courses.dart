import 'package:flutter/foundation.dart';

class Courses with ChangeNotifier
{
  final String id;
  final String title;
  final String image;
  final String price;
  final String sale;
  final String quantity;
  final String instructor;
  final String desc;
  final String fullDesc;
  final String enrolled;
  final String dateCreated;
  final String dateModified;



  Courses({
    this.id,this.title, this.image, this.price, this.quantity, this.sale,this.instructor,this.desc,this.fullDesc,
    this.enrolled,this.dateCreated,this.dateModified
  });

  factory Courses.fromJson(Map<String, dynamic> json)
  {
    return Courses(
        id: json['id'] as String,
        title: json['title'] as String,
        image: json['photo'] as String,
        price: json['price'] as String,
        quantity: json['quantity'] as String,
        sale: json['sale'] as String,
        instructor: json['author'] as String,
        desc: json['short_desc'] as String,
        fullDesc: json['description'] as String,
        enrolled: json['enrolled'] as String,
        dateCreated: json['dateCreated'] as String,
        dateModified: json['dateModified'] as String

    );
  }

}