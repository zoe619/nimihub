import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:nimihub_online/models/user.dart';
import 'package:nimihub_online/utilities/constants.dart';

import 'package:uuid/uuid.dart';

class AuthService{


  final FirebaseAuth _auth = FirebaseAuth.instance;


//  getter to check if user is logged in or not and returns d appropriate stream
  Stream<User> get user => _auth.authStateChanges();



  Future<String> signUp(String name, String email, String password, String phone, String username) async
  {
    String res;

    try{
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      if(authResult.user != null)
      {


        usersRef.doc(authResult.user.uid)
            .set({
          'name':name,
          'email': email,
          'phone': phone,
          'username':username,
          'state': '',
          'gender': '',
          'dob': '',
          'date_added':formattedDated,
        });



        try
        {
          authResult.user.sendEmailVerification();
          res = authResult.user.uid;
        }

        catch(e)
        {
          print("An error occured while trying to send email verification");
          res = null;
        }
      }
    }
    on PlatformException catch(err){
      throw(err);
    }
    return res;
  }


  Future<String> login(String email, String password) async
  {

    try{
      UserCredential res =  await _auth.signInWithEmailAndPassword(email: email, password: password);

      if(res.user.emailVerified)
      {
        return res.user.uid;
      }
      else if(!res.user.emailVerified)
      {
        return null;
      }
      else{
        return "";
      }

    }
    on PlatformException catch(err)
    {

      String error = "invalid";
      return error;


    }
  }

  Future<void> sendPasswordReset(String email) async
  {
    return await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> logout() async
  {

    await _removeToken();
    return Future.wait([
      _auth.signOut(),

    ]);
  }

  Future<void> _removeToken() async
  {

    final currentUser =  _auth.currentUser;
    usersRef.doc(currentUser.uid)
        .update({
      'fcm': ''
    });
  }

  Future<void> _updateToken()async
  {
    final currentUser =  _auth.currentUser;

    final tokenDoc = await usersRef.doc(currentUser.uid).get();

    if(tokenDoc.exists)
    {
      Users tokenObj  = Users.fromDoc(tokenDoc);


    }

  }






}