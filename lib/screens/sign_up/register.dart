import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nimihub_online/components/custom_suffix_icon.dart';
import 'package:nimihub_online/components/default_button1.dart';
import 'package:nimihub_online/components/form_error.dart';
import 'package:nimihub_online/components/social_card.dart';
import 'package:nimihub_online/constants.dart';
import 'package:nimihub_online/screens/sign_up/components/sign_up_form.dart';
import 'package:nimihub_online/service/auth_service.dart';
import 'package:nimihub_online/service/database.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../size_config.dart';


class Register extends StatefulWidget
{
  @override
  _RegisterState createState() => _RegisterState();

  static String routeName = '/register';
}

class _RegisterState extends State<Register>
{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  String email,name;
  String password, phone;
  String confirmPassword;
  bool _isLoading = false;
  bool isChecked2 = false;
  bool _obscureText = true;
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  void _showPass(bool newValue) => setState((){
    isChecked2  = newValue;
    if (isChecked2 ) {
      setState(() {
        _obscureText = false;
      });

    } else {
      setState(() {
        _obscureText = true;
      });
    }
  });

  _showP(){
    return Checkbox(
        value: isChecked2,
        onChanged: _showPass
    );
  }

  _showErrorDialog(String errMessage, String status)
  {
    showDialog(
        context: context,
        builder: (_){
          return AlertDialog(
            title: Text(status),
            content: Text(errMessage),
            actions: <Widget>[
              Platform.isIOS
                  ? new CupertinoButton(
                child: Text('Ok'),
                onPressed: ()=>Navigator.pop(context),
              ) : FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.pop(context);
                    Provider.of<AuthService>(context, listen: false).logout();

                  }
              )
            ],
          );
        }
    );

  }

  _submit() async
  {

    setState(() => _isLoading = false);

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
                Platform.isIOS
                    ? new CupertinoActivityIndicator() : new CircularProgressIndicator(),
                new Text("please wait...")
              ],
            ),
            action: new SnackBarAction(
                label: 'OK',
                onPressed: () => _scaffoldKey.currentState.removeCurrentSnackBar()),
          ));



    }
    final authService = Provider.of<AuthService>(context, listen: false);
    final dbService = Provider.of<DatabaseService>(context, listen: false);

    try
    {


      if(_formKey.currentState.validate())
      {

        _formKey.currentState.save();
        final bool isValid = EmailValidator.validate(email);
        if(!isValid)
        {
          _showErrorDialog("Email Is Wrong", "Fail");
          return;
        }
        if(phone.length < 11){
          _showErrorDialog("Invalid Phone Number", "Fail");
          return;
        }



        var uuid = Uuid();
        String userId = uuid.v4();
        var username = "nimi"+userId;
        


        List res = await dbService.addUser(name, email, password, phone, username);
        Map<String, dynamic> map;



        for(int i = 0; i < res.length; i++)
        {
          map = res[i];

        }

        if(map['status'] == "Fail")
        {
          _showErrorDialog(map['msg'], map['status']);
          return;
        }
        else
        {

          String res =  await authService.signUp(name, email, password, phone, username);


          if(res != null)
          {
            _showErrorDialog("An email verification link has been sent to your mail", "Account Succesfully Created");


          }
          else{
            _showErrorDialog("Error Creating Account", "Error");
          }


        }


      }
    }
    on PlatformException catch (err) {
      _showErrorDialog(err.message, "Error");
    }



  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Text(
                  'Register Account',
                  style: headingStyle,
                ),
                Text(
                  'Complete your details or continue \nwith social media',
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                    height: SizeConfig.screenHeight * 0.07), //8% of total height
                  Form(
                    key: _formKey,
                    child: Column(
                        children: [
                        buildNameFormField(),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    buildEmailFormField(),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    buildPasswordFormField(),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    buildPhoneFormField(),
                    FormError(errors: errors),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Padding(
                      padding: const EdgeInsets.only(left:20.0),
                      child: Row(
                        children: <Widget>[
                          Text("Show Password: ", style: TextStyle(
                              color: Colors.blue
                          ),),
                          _showP()
                        ],
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    DefaultButton1(
                      text: "Submit",
                      press: _submit,
                    )
                    ],
                  ),
                ),
                SizedBox(
                    height: SizeConfig.screenHeight * 0.07), //8% of total height
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: [
//                    SocialCard(
//                      icon: "assets/icons/google-icon.svg",
//                      press: () {},
//                    ),
//                    SocialCard(
//                      icon: "assets/icons/facebook-2.svg",
//                      press: () {},
//                    ),
//                    SocialCard(
//                      icon: "assets/icons/twitter.svg",
//                      press: () {},
//                    ),
//                  ],
//                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                Text(
                  'By continuing your confirm that you agree \nwith the Terms and Conditions',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value.trim().isEmpty) {
          addError(error: 'name is required');
          return "";
        }
        return null;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: 'name is required');
        }
      },
      onSaved: (value) => name = value,
      decoration: InputDecoration(
        labelText: 'full name',
        hintText: 'full name',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
  TextFormField buildPhoneFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value.trim().isEmpty) {
          addError(error: 'Phone number is required');
          return "";
        }
        return null;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: 'Phone number is required');
        }
      },
      onSaved: (value) => phone = value,
      decoration: InputDecoration(
        labelText: 'Phone number',
        hintText: 'phone number',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 6) {
          addError(error: kShortPassError);
          return "";
        }
        password = value;
        return null;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 6) {
          removeError(error: kShortPassError);
        }
        password = value;
        return null;
      },
      onSaved: (value) => password = value,
      obscureText: _obscureText,
      decoration: InputDecoration(
        hintText: 'Enter your password',
        labelText: 'Password',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Lock.svg",
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNulError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kEmailValidEmailError);
          return "";
        }

        return null;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNulError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kEmailValidEmailError);
        }

        return null;
      },
      onSaved: (newValue) => email = newValue,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Enter your email',
        labelText: 'Email',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Mail.svg",
        ),
      ),
    );
  }
}
