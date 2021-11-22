import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nimihub_online/components/default_button1.dart';
import 'package:nimihub_online/models/user.dart';
import 'package:nimihub_online/models/user_data.dart';
import 'package:nimihub_online/service/database.dart';
import 'package:nimihub_online/utilities/constants.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body>
{

  String userId;

  Users user = new Users();
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController stateController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  TextEditingController dobController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String name,username,email,phone,state,gender,dob;
  bool _isLoading = false;
  @override
  initState()
  {
    super.initState();
    userId = Provider.of<UserData>(context, listen: false).currentUserId;

    _setupProfileUser();
  }

  _setupProfileUser() async
  {
    Users profileUser  = await Provider.of<DatabaseService>(context, listen: false).getUserWithId(userId);
    setState(() {
      user = profileUser;
      nameController.text = user.name;
      phoneController.text = user.phone;
      stateController.text = user.state;
      genderController.text = user.gender;
      dobController.text = user.dob;
      username = user.username;
    });
  }

  _showErrorDialog(String errMessage)
  {
    showDialog(
        context: context,
        builder: (_){
          return AlertDialog(
            title: Text('Response'),
            content: Text(errMessage),
            actions: <Widget>[
              Platform.isIOS
                  ? new CupertinoButton(
                child: Text('Ok'),
                onPressed: ()=> Navigator.pop(context),
              ) : FlatButton(
                child: Text('Ok'),
                onPressed: ()=> Navigator.pop(context),
              )
            ],
          );
        }
    );

  }

  _submit() async
  {

    setState(()=> _isLoading = false);
    if(!_formKey.currentState.validate())
    {
      SizedBox.shrink();
      return;
    }
    else if(_isLoading == false)
    {
      _scaffoldKey.currentState.showSnackBar(
          new SnackBar(duration: new Duration(seconds: 1),
            content:
            new Row(
              children: <Widget>[
                Platform.isIOS ? new CupertinoActivityIndicator() : new CircularProgressIndicator(),
                new Text("please wait...")
              ],
            ),
            action: new SnackBarAction(
                label: 'OK',
                onPressed: () => _scaffoldKey.currentState.removeCurrentSnackBar()),
          ));

    }
    try
    {
      if(_formKey.currentState.validate() && !_isLoading)
      {
        _formKey.currentState.save();


        final dbService = Provider.of<DatabaseService>(context, listen: false);



//        update user info in mysql server database
        List res = await dbService.updateUser(name,phone,username,state,gender,dob);
        Map<String, dynamic> map;
        for(int i = 0; i < res.length; i++)
        {
          map = res[i];

        }

        if(map['status'] == "fail")
        {
          _showErrorDialog(map['msg']);
        }
        else
        {

          // update user in firebase
          Users user = Users(
              id: userId,
              name: name,
              phone: phone,
              state: state,
              gender: gender,
              dob: dob

          );

          DatabaseService.updateUserFirebase(user);
          _showErrorDialog("Profile Updated");


          setState(() {
            _isLoading = true;
          });

        }

      }

    }
    on PlatformException catch (err) {
      _showErrorDialog(err.message);
    }

  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      key: _scaffoldKey,
      body: FutureBuilder(
        future: usersRef.doc(userId).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot)
        {
          if(!snapshot.hasData)
          {
            return Center(
              child: Platform.isIOS ? CupertinoActivityIndicator() : CircularProgressIndicator(),
            );
          }
          Users user = Users.fromDoc(snapshot.data);
          return SingleChildScrollView(
            child: Container(
              child : _buildProfile(user),

            ),
          );
        },
      ),
    );
  }

  _buildProfile(Users user)
  {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            'Edit Profile',
            style: headingStyle,
          ),
          TitleAndEdit(title: 'Name'),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey.withOpacity(0.2),
              ),
              child: TextFormField(
                controller: nameController,
                validator:(input)=>
                input.trim().isEmpty  ? 'Input field is empty' : null,
                onSaved:(input)=>name = input,
                decoration: InputDecoration(
                  hintText:'name is required',
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  border: OutlineInputBorder(
                    //gapPadding: ,
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.zero),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.zero),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.zero),
                ),
              ),
            ),
          ),
          TitleAndEdit(title: 'Mobile'),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey.withOpacity(0.2),
              ),
              child: TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                validator:(input)=>
                input.trim().isEmpty  ? 'Input field is empty' : input.trim().length < 11 ? 'Number Is Less Than 11 Digits' : null,
                onSaved:(input)=>phone = input,
                decoration: InputDecoration(
                  hintText: user.phone,
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  border: OutlineInputBorder(
                    //gapPadding: ,
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.zero),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.zero),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.zero),
                ),
              ),
            ),
          ),

          TitleAndEdit(title: 'State Of Origin'),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey.withOpacity(0.2),
              ),
              child: TextFormField(
                controller: stateController,
                validator:(input)=>
                input.trim().isEmpty  ? 'Input field is empty' : null,
                onSaved:(input)=>state = input,
                decoration: InputDecoration(
                  hintText: user.state,
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  border: OutlineInputBorder(
                    //gapPadding: ,
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.zero),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.zero),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.zero),
                ),
              ),
            ),
          ),
          TitleAndEdit(title: 'Gender'),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey.withOpacity(0.2),
              ),
              child: TextFormField(
                controller: genderController,
                validator:(input)=>
                input.trim().isEmpty  ? 'Input field is empty' : null,
                onSaved:(input)=>gender = input,
                decoration: InputDecoration(
                  hintText: user.gender,
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  border: OutlineInputBorder(
                    //gapPadding: ,
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.zero),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.zero),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.zero),
                ),
              ),
            ),
          ),
          TitleAndEdit(title: 'DOB'),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey.withOpacity(0.2),
              ),
              child: TextFormField(
                controller: dobController,
                validator:(input)=>
                input.trim().isEmpty  ? 'Input field is empty' : null,
                onSaved:(input)=>dob = input,
                decoration: InputDecoration(
                  hintText: user.dob,
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  border: OutlineInputBorder(
                    //gapPadding: ,
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.zero),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.zero),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.zero),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          DefaultButton1(text:'Update', press:_submit),
        ],
      ),
    );
  }
}



class TitleAndEdit extends StatelessWidget {
  final String title;
  const TitleAndEdit({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18),
          ),
//          Text(
//            'Edit',
//            style: TextStyle(color: Colors.lightBlue, fontSize: 18),
//          ),
        ],
      ),
    );
  }
}
