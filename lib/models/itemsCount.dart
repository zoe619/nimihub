import 'package:flutter/foundation.dart';

class ItemCount with ChangeNotifier
{
  final String courseCount;
  final String examCount;
  final String notesCount;


   ItemCount({
    this.courseCount,this.examCount,this.notesCount
  });

  factory ItemCount.fromJson(Map<String, dynamic> json)
  {
    return ItemCount(
      courseCount: json['courseCount'] as String,
      examCount: json['examsCount'] as String,
      notesCount: json['notesCount'] as String

    );
  }

}