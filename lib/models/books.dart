import 'package:flutter/foundation.dart';

class Books with ChangeNotifier
{
  final String id;
  final String title;
  final String image;
  final String price;
  final String sale;
  final String author;
  final String desc;
  final String category;
  final String enrolled;
  final String dateCreated;
  final String dateModified;
  final String type;



  Books({
    this.id,this.title, this.image, this.price, this.sale,this.author,this.desc,this.category,
    this.enrolled,this.dateCreated,this.dateModified,this.type
  });

  factory Books.fromJson(Map<String, dynamic> json)
  {
    return Books(
        id: json['id'] as String ?? '',
        title: json['title'] ?? '',
        image: json['photo'] ?? '',
        price: json['price']  ?? '',
        sale: json['sale'] ?? '',
        author: json['author']  ?? '',
        desc: json['description'] ?? '',
        category: json['category'] ?? '',
        enrolled: json['enrolled'] ?? '',
        dateCreated: json['dateCreated'] ?? '',
        dateModified: json['dateModified'] ?? '',
        type: json['type'] ?? ''

    );
  }

}