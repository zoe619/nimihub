import 'package:flutter/foundation.dart';

class SubTopic with ChangeNotifier
{
  final String id;
  final String topic;
  final String description;
  final String dateCreated;
  final String dateModified;



  SubTopic({
    this.id,this.topic,this.description,this.dateCreated,this.dateModified
  });

  factory SubTopic.fromJson(Map<String, dynamic> json)
  {
    return SubTopic(
        id: json['id'] as String ?? '',
        topic: json['name'] ?? '',
        description: json['description'] ?? '',
        dateCreated: json['dateCreated']  ?? '',
        dateModified: json['dateModified'] ?? ''

    );
  }

}