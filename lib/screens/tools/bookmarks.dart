import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nimihub_online/models/user_data.dart';
import 'package:nimihub_online/screens/cart/cart.dart';
import 'package:nimihub_online/screens/cart/cart_screen.dart';
import 'package:nimihub_online/screens/essay_screen.dart';
import 'package:nimihub_online/screens/quiz_screen.dart';
import 'package:nimihub_online/screens/tools/components/greybar.dart';
import 'package:nimihub_online/screens/tools/components/toolstack.dart';
import 'package:nimihub_online/size_config.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class BookMarkScreen extends StatefulWidget
{
  final String email;
  BookMarkScreen({this.email});

  @override
  _BookMarkScreenState createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen>
{
  @override
  void initState()
  {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('BOOKMARKS'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 22),
            child: GestureDetector(
              onTap: () {
                Get.to(CartScreenMain(cart:Provider.of<UserData>(context, listen: false).cart,
                    sum: Provider.of<UserData>(context, listen: false).sum));
              },
              child: SvgPicture.asset(
                'assets/icons/Cart Icon.svg',
                height: 20,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            child: Column(
              children: [
                GreyBar(
                  text: 'BOOKMARKS',
                ),
                Wrap(
                  runSpacing: 6,
                  children: [
                    GestureDetector(
                      onTap: ()
                      {
                        UserData.email = widget.email;
                        UserData.questionType = "MCQ";
                        UserData.bookmark = "yes";
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>QuizScreen()));
                      },
                      child: ToolStack(
                        desc: 'Bookmarked MCQ questions',
                        icon: 'assets/images/rand.jpeg',
                        press: () {

                        },
                        title: 'MCQ',
                      ),
                    ),

                    GestureDetector(
                      onTap: ()
                      {
                        UserData.email = widget.email;
                        UserData.questionType = "ESSAY";
                        UserData.bookmark = "yes";
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>EssayScreen()));
                      },
                      child: ToolStack(
                        desc: 'Bookmarked Essay questions',
                        icon: 'assets/images/rand.jpeg',
                        press: () {

                        },
                        title: 'ESSAY',
                      ),
                    ),


                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(10)),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
