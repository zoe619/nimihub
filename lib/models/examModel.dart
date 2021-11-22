import 'package:flutter/foundation.dart';

class ExamModel with ChangeNotifier
{
  final String id;
  final String examId;
  final String title;
  final String price;
  final String sale;
  final String course;
  final String instructor;
  final String dateCreated;
  final String dateModified;
  final String imagePathType;
  final String image;
  final String author;
  final String enrolled;
  final String ratings;
  final String numRating;
  final String similar;
  final String type;
  List<String> years;
  List<String> courses;
  List<String> questionTypes;


  ExamModel({
    this.id, this.examId, this.title, this.price,this.sale,this.course,this.instructor,this.dateCreated,
    this.dateModified, this.imagePathType,
    this.image,this.author,this.enrolled,this.ratings,this.numRating,this.similar,this.type,this.years,
    this.courses,this.questionTypes
  });

  factory ExamModel.fromJson(Map<String, dynamic> json)
  {
    return ExamModel(
        id: json['id'] as String ?? '',
        examId: json['exam_id'] as String,
        title: json['title'] as String,
        price: json['regular'] as String,
        sale: json['sale'] as String,
        course: json['course'] as String,
        instructor: json['instructor'] as String,
        dateCreated: json['dateCreated'] as String ?? '',
        dateModified: json['dateModified'] as String ?? '',
        imagePathType: json['imagePathType'] as String,
        image: json['image'] as String,
        author: json['author'] as String,
        enrolled: json['enrolled'] as String,
        ratings: json['ratings'] as String,
        numRating: json['num_ratings'] as String,
        similar: json['similar'] as String,
        type: json['type'] as String,
        years: List<String>.from(json['question_years'] ?? []),
        courses: List<String>.from(json['courses'] ?? []),
        questionTypes: List<String>.from(json['question_types'] ?? []),

    );
  }

}