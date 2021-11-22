import 'package:flutter/foundation.dart';

class Wishes with ChangeNotifier
{
  final String id;
  final String userId;
  final String userEmail;
  final String itemId;
  final String item;
  final String created;
  final String modified;




  Wishes({
    this.id, this.userId,this.userEmail,this.itemId,this.item,this.created,this.modified
  });

  factory Wishes.fromJson(Map<String, dynamic> json)
  {
    return Wishes(
        id: json['id'] as String,
        userId: json['userId'] as String,
        userEmail: json['userEmail'] as String,
        itemId: json['itemId'] as String,
        item: json['item'] as String,
        created: json['created'] as String,
        modified: json['modified'] as String

    );
  }

}