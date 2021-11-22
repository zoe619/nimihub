import 'package:flutter/foundation.dart';

class Chapter with ChangeNotifier
{
  final String id;
  final String chapter;
  final String description;
  final List<String>topics;
  final List<String>topicIds;
  final String dateCreated;
  final String dateModified;



  Chapter({
    this.id,this.chapter,this.description,this.topics,this.topicIds,this.dateCreated,this.dateModified
  });

  factory Chapter.fromJson(Map<String, dynamic> json)
  {
    return Chapter(
        id: json['id'] as String ?? '',
        chapter: json['name'] ?? '',
        description: json['description'] ?? '',
        topics: List<String>.from(json['topics'] ?? []),
        topicIds: List<String>.from(json['topicIds'] ?? []),
        dateCreated: json['dateCreated']  ?? '',
        dateModified: json['dateModified'] ?? ''

    );
  }

}