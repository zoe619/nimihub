import 'package:flutter/foundation.dart';

class Topic with ChangeNotifier
{
  final String id;
  final String topic;
  final String description;
  final String dateCreated;
  final String dateModified;



  Topic({
    this.id,this.topic,this.description,this.dateCreated,this.dateModified
  });

  factory Topic.fromJson(Map<String, dynamic> json)
  {
    return Topic(
        id: json['id'] as String ?? '',
        topic: json['name'] ?? '',
        description: json['description'] ?? '',
        dateCreated: json['dateCreated']  ?? '',
        dateModified: json['dateModified'] ?? ''

    );
  }

}