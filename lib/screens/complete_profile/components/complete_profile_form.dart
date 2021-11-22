import 'package:flutter/material.dart';
import 'package:nimihub_online/components/custom_suffix_icon.dart';
import 'package:nimihub_online/components/default_button1.dart';
import 'package:nimihub_online/components/form_error.dart';
import 'package:nimihub_online/screens/otp/otp_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CompleteProfileForm extends StatefulWidget {
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> errors = [];
  String firstName;
  String lastName;
  String phoneNumber;
  String address;

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
    return Form(
      key: _formkey,
      child: Column(
        children: [
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildAdressFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton1(
            press: () {
              if (_formkey.currentState.validate()) {
                // Proceed to Otp screen
                Navigator.pushNamed(context, OtpScreen.routeName);
              }
            },
            text: 'Continue',
          )
        ],
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }

        return null;
      },
      onSaved: (newValue) => phoneNumber = newValue,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: 'Enter your phone number',
        labelText: 'Phone Number',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Phone.svg",
        ),
      ),
    );
  }

  TextFormField buildAdressFormField() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }

        return null;
      },
      onSaved: (newValue) => address = newValue,
      decoration: InputDecoration(
        hintText: 'Enter your Address',
        labelText: 'Address',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Location point.svg",
        ),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNameNullError);
          return "";
        }
        return null;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
        }

        return null;
      },
      onSaved: (newValue) => lastName = newValue,
      decoration: InputDecoration(
        hintText: 'Enter your last name',
        labelText: 'Last Name',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/User.svg",
        ),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNameNullError);
          return "";
        }
        return null;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
        }

        return null;
      },
      onSaved: (newValue) => firstName = newValue,
      decoration: InputDecoration(
        hintText: 'Enter your first name',
        labelText: 'First Name',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/User.svg",
        ),
      ),
    );
  }
}
