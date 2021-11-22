import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:nimihub_online/components/custom_suffix_icon.dart';
import 'package:nimihub_online/components/default_button1.dart';
import 'package:nimihub_online/components/form_error.dart';
import 'package:nimihub_online/components/no_accout_text.dart';
import 'package:nimihub_online/components/social_card.dart';
import 'package:nimihub_online/models/user_data.dart';
import 'package:nimihub_online/screens/forgot_password/forgot_password_screen.dart';
import 'package:nimihub_online/screens/home/home_screen.dart';
import 'package:nimihub_online/service/auth_service.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../size_config.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>
{
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final List<String> errors = [];
  String email;
  String password;
  bool remember = false;
  bool isChecked2 = false;
  bool _obscureText = true;

  bool _isLoading = false;
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

  _submit() async
  {

    setState(() => _isLoading = false);

    if(!_formKey.currentState.validate()){
      SizedBox.shrink();
      return;
    }

    else if(_isLoading == false)
    {
      _scaffoldKey.currentState.showSnackBar(
          new SnackBar(duration: new Duration(seconds: 2),
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


    try
    {


      if(_formKey.currentState.validate())
      {

        _formKey.currentState.save();



        String login = await authService.login(email, password);
        Provider.of<UserData>(context, listen: false).currentUserId = login;


        if(login != null && login.isNotEmpty)
        {
          Navigator.push(context, MaterialPageRoute(
            builder: (_)=>HomeScreen(),
          ));
        }
        else if(login == null){
          _showErrorDialog("Please check your email to verify your account first", "error");
        }
        else{
          _showErrorDialog("Invalid login details", "error");
        }



      }
    }
    on PlatformException catch (err) {
      _showErrorDialog(err.message, "Error");
    }



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

                  }
              )
            ],
          );
        }
    );

  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.screenHeight * 0.04),
                    Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(28),
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Sign in with your email and password \nor continue with social media",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.08),
                    Form(
                    key: _formKey,
                    child: Column(
                        children: [
                        buildEmailFormField(),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    buildPasswordFormField(),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:30.0),
                        child: Row(
                          children: <Widget>[
                            Text("Show Password: ", style: TextStyle(
                                color: Colors.blue
                            ),),
                            _showP()
                          ],
                        ),
                      ),

                  Spacer(),

                  ],
                  ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(
                          context, ForgotPasswordScreen.routeName),
                      child: Text(
                        'Forgot password',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                  FormError(errors: errors),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  DefaultButton1(
                      press:_submit,

                      text: 'Continue'),
                      ],
                    ),
                  ),
                    SizedBox(height: SizeConfig.screenHeight * 0.08),
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: [
//                        SocialCard(
//                          icon: "assets/icons/google-icon.svg",
//                          press: () {},
//                        ),
//                        SocialCard(
//                          icon: "assets/icons/facebook-2.svg",
//                          press: () {},
//                        ),
//                        SocialCard(
//                          icon: "assets/icons/twitter.svg",
//                          press: () {},
//                        ),
//                      ],
//                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    NoAccountText()
                  ],
                ),
              ),
            ),
          ),
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

  TextFormField buildPasswordFormField() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        }
        return null;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        }
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
}
