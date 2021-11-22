import 'package:cloud_firestore/cloud_firestore.dart';

class Users
{

  String id;
  String name;
  String username;
  String email;
  String phone;
  String state;
  String dob;
  String gender;
  String date;






  Users({this.id, this.name, this.username, this.email, this.phone, this.state, this.dob, this.gender, this.date});

  factory Users.fromDoc(DocumentSnapshot doc)
  {
    return Users(
        id: doc.id,
        name: doc.get('name'),
        username: doc.get('username'),
        email: doc.get('email'),
        phone: doc.get('phone'),
        state: doc.get('state'),
        dob: doc.get('dob'),
        gender: doc.get('gender'),
        date: doc.get('date_added'),


    );
  }

  factory Users.fromJson(Map<String, dynamic> json)
  {
    return Users(
        id:json['id'] as String,
        name: json['name'] as String,
        username: json['username'],
        email: json['email'] as String,
        phone: json['phone'] as String,
        state: json['state'] as String,
        dob: json['dob'] as String,
        gender: json['gender'] as String
    );
  }
}