import 'package:flutter/foundation.dart';

class Product with ChangeNotifier
{
  final String id;
  final String title;
  final String image;
  final String instructor;
   String price;
   String sale;
  final String desc;
  final String fullDesc;
  final String category;
  final String status;
  final String enrolled;
  final String dateCreated;
  final String dateModified;
  final String ratings;
  final String numContents;
  final String numRatings;
  final String toLearn;
  final String requirements;
  final String duration;
  int quantity;
  final String type;

  Product({
    this.id, this.title, this.image,this.instructor,this.price,
    this.sale,this.desc, this.fullDesc,this.category, this.status, this.enrolled,
    this.dateCreated,this.dateModified,this.ratings,this.numContents,this.numRatings,
    this.toLearn,this.requirements,this.duration, this.quantity,this.type
});

  factory Product.fromJson(Map<String, dynamic> json)
  {
    return Product(
      id: json['id'] as String ?? '',
      title: json['title'] as String ?? '',
      image: json['photo'] as String ?? '',
      price: json['regular'] as String ?? '',
      sale: json['sale'] as String ?? '',
      desc: json['short_desc'] as String ?? '',
      fullDesc: json['description'] as String ?? '',
      category: json['category'] as String ?? '',
      status: json['course_status'] as String ?? '',
      enrolled: json['enrolled'] as String ?? '',
      dateCreated: json['dateCreated'] as String ?? '',
      dateModified: json['dateModified'] as String ?? '',
//        contents: json['contents'] as String,
//        ratings: json['ratings'] as String,
      numContents: json['num_contents'] as String ?? '',
      numRatings: json['num_ratings'] as String ?? '',
      toLearn: json['toLearn'] as String ?? '',
      requirements: json['requirements'] as String ?? '',
      duration: json['duration'] as String ?? '',
      quantity: json['quantity'] as int ?? '',
      type: json['type'] as String ?? '',
      instructor: json['author'] as String ?? ''
    );
  }

}