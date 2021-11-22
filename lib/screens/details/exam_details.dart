import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nimihub_online/animation/delayed_animation.dart';
import 'package:nimihub_online/components/default_button1.dart';
import 'package:nimihub_online/constants.dart';
import 'package:nimihub_online/models/cartItem.dart';
import 'package:nimihub_online/models/feature_model.dart';
import 'package:nimihub_online/models/products.dart';
import 'package:nimihub_online/models/question_model.dart';
import 'package:nimihub_online/models/user.dart';
import 'package:nimihub_online/models/user_data.dart';
import 'package:nimihub_online/screens/cart/cart.dart';
import 'package:nimihub_online/screens/cart/cart_screen.dart';
import 'package:nimihub_online/screens/essay_screen.dart';
import 'package:nimihub_online/screens/quiz_screen.dart';
import 'package:nimihub_online/service/database.dart';
import 'package:nimihub_online/service/quiz/quiz_repository.dart';
import 'package:nimihub_online/size_config.dart';
import 'package:nimihub_online/components/foldable_description_text.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ExamDetailedScreen extends StatefulWidget
{
  static String routeName = '/exam_screen';
  final String id;
  final String examId;
  final String image;
  final String title;
  final String desc;
  final String fullDesc;
  final String instructor;
  final double rating;
  final String price;
  final String sale;
  final String enrolled;
  final String category;
  final String status;
  final String numContents;
  final String numRatings;
  final String similar;
  final String toLearn;
  final String requirements;
  final String duration;
  final String dateModified;
  final String dateCreated;
  final Product course;
  final String type;
  final List<String> years;
  final List<String> courses;
  final List<String> questionTypes;
  final bool bought;



  const ExamDetailedScreen(
      {Key key,
        this.id,
        this.examId,
        this.image,
        this.title,
        this.desc,
        this.fullDesc,
        this.instructor,
        this.price,
        this.sale,
        this.rating,
        this.enrolled,
        this.category,
        this.status,
        this.numContents,
        this.numRatings,
        this.similar,
        this.toLearn,
        this.requirements,
        this.duration,
        this.dateModified,
        this.dateCreated,
        this.course,
        this.type,
        this.years,
        this.courses,
        this.questionTypes,
        this.bought

      })
      : super(key: key);



  @override
  _ExamDetailedScreenState createState() => _ExamDetailedScreenState();
}

class _ExamDetailedScreenState extends State<ExamDetailedScreen>
{

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String email, userId;
  bool _isLoading = false;
  String year, type, course, examId;
  bool show = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState()
  {
    super.initState();
    // TODO: implement initState
    userId = Provider.of<UserData>(context, listen: false).currentUserId;
    _setupProfileUser();



  }

  _setupProfileUser() async
  {
    Users profileUser = await Provider.of<DatabaseService>(
        context, listen: false).getUserWithId(userId);
    setState(() {
      email = profileUser.email;
    });
//    Provider.of<DatabaseService>(context,listen: false).addViewedCourse(email, widget.id);
  }




  @override
  Widget build(BuildContext context)
  {
    final cart = Provider.of<CartMain>(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFFEDF0F2),
      bottomSheet: widget.bought == false ? belowButton() : SizedBox.shrink(),
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 22),
            child: GestureDetector(
              onTap: () {
                //  Navigator.pushNamed(context, Cart.routeName);
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[

                      Container(
                          child: Container(
                            height: getProportionateScreenHeight(585),
                            decoration: widget.image != null ? BoxDecoration(
                                color: Colors.black12,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  colorFilter: new ColorFilter.mode(
                                      Colors.black.withOpacity(0.5),
                                      BlendMode.darken),
                                  image: CachedNetworkImageProvider(widget.image),
                                )
                            ) : SizedBox.shrink(),
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 8),
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          widget.title != null ? Text(
                                              widget.title,
                                              style: TextStyle(
                                                  fontSize: 32,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400)) : SizedBox.shrink(),
                                          widget.desc != null ?  Text(
                                              widget.desc,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400)) : SizedBox.shrink(),
                                          // Text("Comcombined! In Theano and Tensorflow",
                                          // style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w400)),
                                          // Text("Compbined! In Theano and Tensorflow",
                                          // style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w400)),
                                          // Text("Comp combined! In Theano and Tensorflow",
                                          // style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w400)),

                                          SizedBox(
                                            height: 16,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    56, 0, 56, 0),
                                                height:
                                                getProportionateScreenHeight(
                                                    160),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.black12,
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        colorFilter: new ColorFilter.mode(
                                                            Colors.black.withOpacity(0.5),
                                                            BlendMode.darken),
                                                        image: CachedNetworkImageProvider(widget.image),
                                                      )
                                                  ),
                                                  child: Center(
                                                      child: Icon(
                                                        Icons.play_arrow,
                                                        size: 100,
                                                        color: Colors.white,
                                                      )),
                                                )),
                                          ),


                                          // SizedBox(
                                          //   height: getProportionateScreenHeight(),
                                          // )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )),
                      // SizedBox(
                      //   height: 80,
                      // )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: getProportionateScreenHeight(15.0), ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(8.0)),
                    child: Container(
                      // height: getProportionateScreenHeight(50),
                      // width: getProportionateScreenWidth(400),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: nearlyWhite,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15,
                            color: Colors.black26.withOpacity(0.2),
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: widget.bought == false ? Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                          child: GestureDetector(
                            onTap: ()
                            {



                              bool stat = cart.addItem(widget.examId, widget.title, double.parse(widget.sale), widget.type);
                              if(stat == true){
                                _showErrorDialog("Item added to cart", "success");
                              }else{
                                _showErrorDialog("Item exist in cart", "error");
                              }


                            },
                            child: Text(
                              'Add To Cart',
                              style: TextStyle(
                                color: kPrimraryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),

                            ),
                          ),
                        ),
                      ) : SizedBox.shrink()
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(8.0)),
                    child: Container(
                      // height: getProportionateScreenHeight(50),
                      // width: getProportionateScreenWidth(400),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: nearlyWhite,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15,
                            color: Colors.black26.withOpacity(0.2),
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Padding(

                        padding: EdgeInsets.all(5),
                        child: IconButton(
                            icon: Icon(
                                EvaIcons.heartOutline
                            ),
                            iconSize: 30,
                            color: Colors.red,
                            onPressed:_submit
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(8.0)),
                    child: Container(
                      // height: getProportionateScreenHeight(50),
                      // width: getProportionateScreenWidth(400),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: nearlyWhite,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26.withOpacity(0.2),
                            blurRadius: 15,
                            offset: Offset(0, 5),
                          )
                        ],
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: IconButton(
                            icon: Icon(
                              EvaIcons.shareOutline,
                            ),
                            color: kPrimraryColor,
                            onPressed: () {
                              print('fucked');
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                  top: getProportionateScreenHeight(15),
                  left: getProportionateScreenHeight(5),
                  right: getProportionateScreenHeight(5)),
              child: Card(
                child: Container(
                  width: getProportionateScreenWidth(400),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                          ),
                          child: Text(
                            'This Exam Includes Following Question Types:',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: widget.questionTypes.length,
                            itemBuilder: (BuildContext context, int index) {
                              return  ListTile(
                                visualDensity:
                                VisualDensity(horizontal: 0, vertical: -4),
                                leading: Icon(
                                  EvaIcons.questionMark,
                                  size: 20,
                                ),
                                title: Transform(
                                  transform: Matrix4.translationValues(-22, 0, 0),
                                  child: Text(
                                    widget.questionTypes[index],
                                    style: TextStyle(fontSize: 13, color: kTextColor),
                                  ),
                                ),
                               );
                              },
                            ),

                      ],
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                  top: getProportionateScreenHeight(15),
                  left: getProportionateScreenHeight(5),
                  right: getProportionateScreenHeight(5)),
              child: Card(
                child: Container(
                  width: getProportionateScreenWidth(400),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                          ),
                          child: Flexible(
                            child: Text(
                              'This Exam Includes Following Courses:',
                              style: TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: widget.courses.length,
                          itemBuilder: (BuildContext context, int index) {
                            return  ListTile(
                              visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                              leading: Icon(
                                EvaIcons.book,
                                size: 20,
                              ),
                              title: Transform(
                                transform: Matrix4.translationValues(-22, 0, 0),
                                child: Text(
                                  widget.courses[index],
                                  style: TextStyle(fontSize: 13, color: kTextColor),
                                ),
                              ),
                            );
                          },
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: getProportionateScreenHeight(15),
                  left: getProportionateScreenHeight(5),
                  right: getProportionateScreenHeight(5)),
              child: Card(
                child: Container(
                  width: getProportionateScreenWidth(400),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                          ),
                          child: Flexible(
                            child: Text(
                              'This Exam Includes Questions For The Year:',
                              style: TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: widget.years.length,
                          itemBuilder: (BuildContext context, int index) {
                            return  ListTile(
                              visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                              leading: Icon(
                                EvaIcons.calendar,
                                size: 20,
                              ),
                              title: Transform(
                                transform: Matrix4.translationValues(-22, 0, 0),
                                child: Text(
                                  widget.years[index],
                                  style: TextStyle(fontSize: 13, color: kTextColor),
                                ),
                              ),
                            );
                          },
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
            widget.bought == true ? Padding(
                padding: EdgeInsets.only(
                  top: getProportionateScreenHeight(5),
                  left: getProportionateScreenWidth(5),
                  right: getProportionateScreenWidth(5),
                ),
              child: Padding(
                padding: EdgeInsets.only(top: getProportionateScreenHeight(8.0)),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: GestureDetector(
                      onTap: (){
                       setState(() {
                         if(show == false){
                           show = true;
                         }else{
                           show = false;
                         }
                       });
                      },
                      child: Text('Take Exam',
                          style: TextStyle(
                              fontSize: 20.5, color: Colors.black)),
                    ),
                  ),

                ),
              ),
            ) : SizedBox.shrink(),
            SizedBox(height: 20.0),
           show == true ? Padding(
                padding: EdgeInsets.only(
                  top: getProportionateScreenHeight(5),
                  left: getProportionateScreenWidth(5),
                  right: getProportionateScreenWidth(5),
                ),
                child: Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                          child: DropdownButtonFormField(
                            isDense: true,
                            icon: Icon(Icons.arrow_drop_down_circle),
                            iconSize: 20.0,
                            iconEnabledColor: Theme.of(context).primaryColor,
                            items: widget.years.map((String years)
                            {
                              return DropdownMenuItem(
                                value: years,
                                child: Text(
                                  years, style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0
                                ),
                                ),

                              );
                            }).toList(),
                            style: TextStyle(fontSize: 15.0),
                            decoration: InputDecoration(
                                labelText: 'Select Exam Year',
                                labelStyle: TextStyle(fontSize: 15.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )
                            ),
                            validator: (input)=> year == null
                                ? "Please Exam Year"
                                : null,
                            onChanged: (value)
                            {
                              setState(() {
                                year = value;
                              });
                            },
                            value: year != null ? year : null,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                          child: DropdownButtonFormField(
                            isDense: true,
                            icon: Icon(Icons.arrow_drop_down_circle),
                            iconSize: 20.0,
                            iconEnabledColor: Theme.of(context).primaryColor,
                            items: widget.courses.map((String course)
                            {
                              return DropdownMenuItem(
                                value: course,
                                child: Text(
                                  course, style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 6.5,
                                    fontWeight: FontWeight.bold

                                ),
                                ),

                              );
                            }).toList(),
                            style: TextStyle(fontSize: 15.0),
                            decoration: InputDecoration(
                                labelText: 'Select Course',
                                labelStyle: TextStyle(fontSize: 15.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )
                            ),
                            validator: (input)=> course == null
                                ? "Please Select Course"
                                : null,
                            onChanged: (value)
                            {
                              setState(() {
                                course = value;
                              });
                            },
                            value:  course != null ? course : null,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                          child: DropdownButtonFormField(
                            isDense: true,
                            icon: Icon(Icons.arrow_drop_down_circle),
                            iconSize: 20.0,
                            iconEnabledColor: Theme.of(context).primaryColor,
                            items: widget.questionTypes.map((String types)
                            {
                              return DropdownMenuItem(
                                value: types,
                                child: Text(
                                  types, style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0
                                ),
                                ),

                              );
                            }).toList(),
                            style: TextStyle(fontSize: 15.0),
                            decoration: InputDecoration(
                                labelText: 'Select Question Type',
                                labelStyle: TextStyle(fontSize: 13.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )
                            ),
                            validator: (input)=> type == null
                                ? "Please Select Question Type"
                                : null,
                            onChanged: (value)
                            {
                              setState(() {
                                type = value;
                              });
                            },
                            value: type != null ? type : null,
                          ),
                        ),
                        SizedBox(height: 20.0),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                          child: DefaultButton1(
                              press:()
                              {

                                if(_formKey.currentState.validate())
                                {
                                  UserData.examId = int.parse(widget.examId);
                                  UserData.type = type;
                                  UserData.year = year;
                                  UserData.course = course;
                                  UserData.email = email;
                                  UserData.bookmark = "no";
                                  if(UserData.type == "MCQ")
                                  {
                                    Navigator.push(context, MaterialPageRoute(builder: (_)=>QuizScreen()));
                                  }
                                  else{
                                    Navigator.push(context, MaterialPageRoute(builder: (_)=>EssayScreen()));
                                  }


                                }else{
                                  _scaffoldKey.currentState.showSnackBar(
                                      new SnackBar(duration: new Duration(seconds: 2),
                                        content:
                                        new Row(
                                          children: <Widget>[

                                            new Text("please make all three selections")
                                          ],
                                        ),
                                        action: new SnackBarAction(
                                            label: 'OK',
                                            onPressed: () => _scaffoldKey.currentState.removeCurrentSnackBar()),
                                      ));
                                }

                              },
                              text: 'Continue'),
                        ),
                      ],
                    ),
                  ),

                  )
             ) :SizedBox.shrink(),

            SizedBox(height: 70),
          ],
        ),
      ),
    );
  }

  Widget belowButton()
  {
    final cart = Provider.of<CartMain>(context);
    return Container(
      height: getProportionateScreenHeight(70),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18),
        child: Row(
          children: <Widget>[
            widget.sale != null ? Text("\NGN${widget.sale}",
                style: TextStyle(
                    fontFamily: "muli",
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    letterSpacing: 0.27,
                    color: Colors.black)) : SizedBox.shrink(),
            //SizedBox(width: 4.7 * SizeConfig1.widthMultiplier),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: DelayedAnimation(
                  delayedDuration: 900,
                  animDuration: 700,
                  animOffsetX: -1.35,
                  animOffsetY: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: kPrimraryColor,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 15,
                              color: Colors.black38.withOpacity(0.2),
                              offset: Offset(0, 15))
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      // padding: EdgeInsets.symmetric(
                      //     vertical: 15),
                      child: GestureDetector(
                        onTap: ()
                        {

                          bool stat = cart.addItem(widget.examId, widget.title, double.parse(widget.sale), widget.type);
                          if(stat == true){
                            _showErrorDialog("Item added to cart", "success");
                          }else{
                            _showErrorDialog("Item exist in cart", "error");
                          }
                        },
                        child: Text("BUY NOW",
                            style: TextStyle(
                                fontFamily: "muli",
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                letterSpacing: 0.27,
                                color: nearlyWhite)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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

                  }
              )
            ],
          );
        }
    );

  }

  void _submit() async
  {
    if(_isLoading == false)
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
    try{

      List res = await Provider.of<DatabaseService>(context,listen: false).addWishes(email, widget.title,
          widget.examId, widget.type, widget.dateCreated, widget.dateModified);

      Map<String, dynamic> map;



      for(int i = 0; i < res.length; i++)
      {
        map = res[i];

      }

      if(map['status'] == "Failed")
      {
        _showErrorDialog(map['msg'], map['status']);
        return;
      }else{
        _showErrorDialog(map['msg'], map['status']);
      }
      setState(() => _isLoading = true);

    }
    on PlatformException catch (err) {
      _showErrorDialog(err.message, "Error");
    }

  }
}

class StudentsAllViewContentRow extends StatelessWidget
{
  const StudentsAllViewContentRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenHeight(225),
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: featureModelList.length,
        itemBuilder: (BuildContext context, int index) {
          final String image = featureModelList[index].image;
          final String title = featureModelList[index].title;
          final String instructor = featureModelList[index].instructor;
          final double rating = featureModelList[index].rating;
          final String oldAmount = featureModelList[index].oldAmount.toString();
          final String newAmount = featureModelList[index].newAmount.toString();
          final String enrolled = featureModelList[index].enrolled;
          return GestureDetector(

            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 4.0),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: getProportionateScreenHeight(55),
                        width: getProportionateScreenWidth(120),
                        //color: Colors.red,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: AssetImage(featureModelList[index].image),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Container(
                          //height: 4//3,
                          constraints: BoxConstraints(maxWidth: 140),
                          child: Text(
                            featureModelList[index].title,
                            style:
                            TextStyle(fontSize: 14.0, color: Colors.black),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          featureModelList[index].instructor,
                        ),
                      ),
                      // Expanded(
                      //   child: Container(
                      //     // width: 100,
                      //     child: Row(
                      //       children: [
                      //         Icon(
                      //           Icons.star,
                      //           color: Colors.deepOrangeAccent,
                      //           size: 7,
                      //         ),
                      //         Icon(
                      //           Icons.star,
                      //           color: Colors.deepOrangeAccent,
                      //           size: 7,
                      //         ),
                      //         Icon(
                      //           Icons.star,
                      //           color: Colors.deepOrangeAccent,
                      //           size: 7,
                      //         ),
                      //         Icon(
                      //           Icons.star,
                      //           color: Colors.deepOrangeAccent,
                      //           size: 7,
                      //         ),
                      //         Icon(
                      //           Icons.star,
                      //           color: Colors.deepOrangeAccent,
                      //           size: 7,
                      //         ),
                      //         Padding(
                      //           padding: const EdgeInsets.only(left: 5.0),
                      //           child: Text(
                      //             '${featureModelList[index].rating}',
                      //             style: TextStyle(fontSize: 8),
                      //           ),
                      //         ),
                      //         Padding(
                      //           padding: const EdgeInsets.only(left: 4.0),
                      //           child: Text(
                      //             '(${featureModelList[index].enrolled})',
                      //             style: TextStyle(fontSize: 12),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Row(
                          children: [
                            Text(
                              '\$${featureModelList[index].newAmount}',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                  '\$${featureModelList[index].oldAmount}',
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 9)),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text('Bestseller',
                                style: TextStyle(
                                    fontSize: 8.5, color: Colors.black)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CircularIcon extends StatelessWidget
{
  final IconData icon;
  final Color color;

  const CircularIcon({
    Key key,
    @required this.icon,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return ListTile(
      visualDensity:
      VisualDensity(horizontal: 0, vertical: -4),
      leading: Icon(
        EvaIcons.playCircleOutline,
        size: 20,
      ),
      title: Transform(
        transform: Matrix4.translationValues(-22, 0, 0),
        child: Text(
          '21.5 total hours on-demand video',
          style: TextStyle(fontSize: 13, color: kTextColor),
        ),
      ),
    );
  }
}
