import 'package:flutter/foundation.dart';

class Lesson with ChangeNotifier
{
  final String courseId;
  final String moduleId;
  final String moduleName;
  final List<String> moduleVideos;


  Lesson({
    this.courseId,this.moduleId,this.moduleName,this.moduleVideos
  });

  factory Lesson.fromJson(Map<String, dynamic> json)
  {
    return Lesson(
        courseId: json['courseId'] ?? '',
        moduleId: json['moduleId'] ?? '',
        moduleName: json['moduleName'] ?? '',
        moduleVideos: List<String>.from(json['moduleVideos'] ?? [])

    );
  }

}