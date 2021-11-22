import 'package:flutter/material.dart';
import 'package:nimihub_online/size_config.dart';

import '../../../constants.dart';
import 'complete_profile_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              Text(
                'Complete Profile',
                style: headingStyle,
              ),
              Text(
                "Complete your details or continue \nwith social media",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              CompleteProfileForm(),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     SocialCard(
              //       icon: "assets/icons/google-icon.svg",
              //       press: () {},
              //     ),
              //     SocialCard(
              //       icon: "assets/icons/facebook-2.svg",
              //       press: () {},
              //     ),
              //     SocialCard(
              //       icon: "assets/icons/twitter.svg",
              //       press: () {},
              //     ),
              //   ],
              // ),
              SizedBox(height: getProportionateScreenHeight(30)),
              Text(
                'By continuing your confirm that you agree \nwith the Terms and Conditions',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
