import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nimihub_online/components/custom_suffix_icon.dart';
import 'package:nimihub_online/components/default_button1.dart';
import 'package:nimihub_online/components/form_error.dart';
import 'package:nimihub_online/components/no_accout_text.dart';
import 'package:nimihub_online/service/auth_service.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body>
{
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _isLoading = false;
  var email;
  List<String> errors = [];

  _submit() async
  {


    if(!_formKey.currentState.validate())
    {
      SizedBox.shrink();
    }

    else if(_isLoading == false)
    {
      _scaffoldKey.currentState.showSnackBar(
          new SnackBar(duration: new Duration(seconds: 1),
            content:
            new Row(
              children: <Widget>[
                Platform.isIOS ? CupertinoActivityIndicator() : new CircularProgressIndicator(),
                new Text("please wait...")
              ],
            ),
          ));



    }
    final authService = Provider.of<AuthService>(context, listen: false);


    try
    {
      if(_formKey.currentState.validate())
      {
        _formKey.currentState.save();

        await authService.sendPasswordReset(email);
        _showErrorDialog("password reset link has been sent to your mail", "success");


      }
    }
    on PlatformException catch(error){
      _showErrorDialog(error.message, "error");
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
              Platform.isIOS ? CupertinoButton(
                child: Text('Ok'),
                onPressed: ()=> Navigator.pop(context),
              ) : FlatButton(
                  child: Text('Ok'),
                  onPressed: (){
                    Navigator.pop(context);

                  }
              )
            ],
          );
        }
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                'Forgot Password',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: getProportionateScreenWidth(28)),
              ),
              Text(
                'Please enter your email and we will send \nyou a link to return to your account',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              _buildForm(),
            ],
          ),
        ),
      ),
    );
  }

  _buildForm()
  {

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value.isEmpty && !errors.contains(kEmailNulError)) {
                setState(() {
                  errors.add(kEmailNulError);
                });
              } else if (!emailValidatorRegExp.hasMatch(value) &&
                  !errors.contains(kEmailValidEmailError)) {
                setState(() {
                  errors.add(kEmailValidEmailError);
                });
              }

              return null;
            },
            onChanged: (value) {
              if (value.isNotEmpty && errors.contains(kEmailNulError)) {
                setState(() {
                  errors.remove(kEmailNulError);
                });
              } else if (emailValidatorRegExp.hasMatch(value) &&
                  errors.contains(kEmailValidEmailError)) {
                setState(() {
                  errors.remove(kEmailValidEmailError);
                });
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
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          DefaultButton1(
              text: 'Continue',
              press: _submit ),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          NoAccountText()
        ],
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String email;
  @override
  Widget build(BuildContext context)
  {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value.isEmpty && !errors.contains(kEmailNulError)) {
                setState(() {
                  errors.add(kEmailNulError);
                });
              } else if (!emailValidatorRegExp.hasMatch(value) &&
                  !errors.contains(kEmailValidEmailError)) {
                setState(() {
                  errors.add(kEmailValidEmailError);
                });
              }

              return null;
            },
            onChanged: (value) {
              if (value.isNotEmpty && errors.contains(kEmailNulError)) {
                setState(() {
                  errors.remove(kEmailNulError);
                });
              } else if (emailValidatorRegExp.hasMatch(value) &&
                  errors.contains(kEmailValidEmailError)) {
                setState(() {
                  errors.remove(kEmailValidEmailError);
                });
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
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          DefaultButton1(
              text: 'Continue',
              press: () {
                if (_formKey.currentState.validate()) {
                  // Do What you want to do
                }
              }),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          NoAccountText()
        ],
      ),
    );
  }
}
