import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nimihub_online/animation/delayed_animation.dart';
import 'package:nimihub_online/constants.dart';
import 'package:nimihub_online/models/cartItem.dart';
import 'package:nimihub_online/models/feature_model.dart';
import 'package:nimihub_online/models/lesson.dart';
import 'package:nimihub_online/models/products.dart';
import 'package:nimihub_online/models/user.dart';
import 'package:nimihub_online/models/user_data.dart';
import 'package:nimihub_online/screens/cart/cart.dart';
import 'package:nimihub_online/screens/cart/cart_screen.dart';
import 'package:nimihub_online/screens/video_screen.dart';
import 'package:nimihub_online/service/database.dart';
import 'package:nimihub_online/size_config.dart';
import 'package:nimihub_online/components/foldable_description_text.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class DetailedScreen extends StatefulWidget
{
  static String routeName = '/detailed_screen';
  final String id;
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
  final bool bought;
  final List<String> videos;


  const DetailedScreen(
      {Key key,
      this.id,
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
        this.bought,
        this.videos

      })
      : super(key: key);


  @override
  _DetailedScreenState createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen>
{

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String email, userId;
  bool _isLoading = false;
  bool show = false;
  String na;

  List<Lesson> _lessons;

  @override
  void initState()
  {
    super.initState();
    // TODO: implement initState
    userId = Provider.of<UserData>(context, listen: false).currentUserId;
    _setupProfileUser();
    _getLessons();



  }

  _setupProfileUser() async
  {
    Users profileUser = await Provider.of<DatabaseService>(
        context, listen: false).getUserWithId(userId);
    setState(() {
      email = profileUser.email;
    });
    Provider.of<DatabaseService>(context,listen: false).addViewedCourse(email, widget.id);
  }

  _getLessons() async
  {
    List<Lesson> lesson = await Provider.of<DatabaseService>(context, listen: false).getLessons(widget.id);
    setState(() {
      _lessons = lesson;
    });
    print(_lessons);
    print(widget.id);

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

                                      Wrap(
                                        alignment: WrapAlignment.start,
                                        runSpacing: 8.0,
                                        children: <Widget>[
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 8, 0),
                                                padding: EdgeInsets.fromLTRB(
                                                    8, 4, 8, 4),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.white,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.white,
                                                      size: 16,
                                                    ),
                                                    widget.rating != null ?  Text('${widget.rating}',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)) : SizedBox.shrink()
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 8, 0),
                                                padding: EdgeInsets.fromLTRB(
                                                    8, 4, 8, 4),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.white,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.person,
                                                      color: Colors.white,
                                                      size: 16,
                                                    ),
                                                    widget.enrolled != null ?  Text(
                                                        "${widget.enrolled} Enrolled",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)) : SizedBox.shrink()
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 8, 0),
                                                padding: EdgeInsets.fromLTRB(
                                                    8, 4, 8, 4),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.white,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.play_arrow,
                                                      color: Colors.white,
                                                      size: 16,
                                                    ),
                                                    widget.duration != null ?  Text(widget.duration,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)) : SizedBox.shrink()
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 8, 0),
                                                padding: EdgeInsets.fromLTRB(
                                                    8, 4, 8, 4),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.white54,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                child:widget.bought == false ? Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    widget.instructor != null ? Text(
                                                        "Created by ${widget.instructor}",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12)) : SizedBox.shrink()
                                                  ],
                                                ):SizedBox.shrink(),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 8, 0),
                                                padding: EdgeInsets.fromLTRB(
                                                    8, 4, 8, 4),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.white54,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    widget.dateModified != null ? Text("Updated ${widget.dateModified}",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12)) : SizedBox.shrink()
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 8, 0),
                                                padding: EdgeInsets.fromLTRB(
                                                    8, 4, 8, 4),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.white54,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Text("CC, English/German",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
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
            // Padding(
            //   padding: const EdgeInsets.only(top: 12.0, left: 8, right: 8),
            //   child: Container(
            //     height: getProportionateScreenHeight(50),
            //     width: getProportionateScreenWidth(400),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(6),
            //       color: kPrimraryColor,
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.black26.withOpacity(0.2),
            //           blurRadius: 15,
            //           offset: Offset(0, 5),
            //         )
            //       ],
            //     ),
            //     child: Center(
            //       child: Text(
            //         'Buy Now',
            //         style: TextStyle(
            //           color: nearlyWhite,
            //           fontWeight: FontWeight.bold,
            //           fontSize: 24,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
             Padding(
              padding: EdgeInsets.only(top: getProportionateScreenHeight(15.0), ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.bought == false ? Padding(
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
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                          child: GestureDetector(
                            onTap: ()
                            {



                              bool stat = cart.addItem(widget.id, widget.title, double.parse(widget.sale), widget.type);
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

                            )
                          ),
                        ),
                      ),
                    ),
                  ) : SizedBox.shrink(),
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
                            onPressed: ()
                            {
                              print('share');
                            },
                          ),
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
                              EvaIcons.bookOpen,
                            ),
                            color: kPrimraryColor,
                            onPressed: ()
                            {
                              print('review');
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
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                          ),
                          child: _lessons != null ?  Text(
                            'Course Modules:',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ): SizedBox.shrink(),
                        ),
                       _lessons != null ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: _lessons.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            return  ListTile(
                              visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                              leading: Icon(
                                EvaIcons.mapOutline,
                                size: 20,
                              ),
                              title: Transform(
                                transform: Matrix4.translationValues(-22, 0, 0),
                                child: GestureDetector(
                                  onTap: (){
                                     na = _lessons[index].moduleName;
                                    setState(() {
                                      if(show == false){
                                        show = true;
                                      }else if(show = true){
                                        show = false;
                                      }
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        _lessons[index].moduleName,
                                        style: TextStyle(fontSize: 13, color: kTextColor),
                                      ),
                                      show == true && na == _lessons[index].moduleName ? form(_lessons[index].moduleVideos) : SizedBox.shrink(),
                                    ],
                                  )
                                ),
                              ),
                            );
                          },
                        ) : Center(child:  Platform.isIOS
                           ? new CupertinoActivityIndicator() : new CircularProgressIndicator()),
//                        ListTile(
//                          visualDensity:
//                              VisualDensity(horizontal: 0, vertical: -4),
//                          leading: Icon(
//                            EvaIcons.playCircleOutline,
//                            size: 20,
//                          ),
//                          title: Transform(
//                            transform: Matrix4.translationValues(-22, 0, 0),
//                            child: Text(
//                              '21.5 total hours on-demand video',
//                              style: TextStyle(fontSize: 13, color: kTextColor),
//                            ),
//                          ),
//                        ),
//                        ListTile(
//                          visualDensity:
//                              VisualDensity(horizontal: 0, vertical: -4),
//                          leading: Icon(
//                            EvaIcons.flash,
//                            size: 20,
//                          ),
//                          title: Transform(
//                            transform: Matrix4.translationValues(-22, 0, 0),
//                            child: Text(
//                              '23 Quizzes',
//                              style: TextStyle(fontSize: 13, color: kTextColor),
//                            ),
//                          ),
//                        ),
//                        ListTile(
//                          visualDensity:
//                              VisualDensity(horizontal: 0, vertical: -4),
//                          leading: Icon(
//                            EvaIcons.bookOpenOutline,
//                            size: 20,
//                          ),
//                          title: Transform(
//                            transform: Matrix4.translationValues(-22, 0, 0),
//                            child: Text(
//                              '12 Articles',
//                              style: TextStyle(fontSize: 13, color: kTextColor),
//                            ),
//                          ),
//                        ),
//                        ListTile(
//                          visualDensity:
//                              VisualDensity(horizontal: 0, vertical: -4),
//                          leading: Icon(
//                            EvaIcons.closeCircleOutline,
//                            size: 20,
//                          ),
//                          title: Transform(
//                            transform: Matrix4.translationValues(-22, 0, 0),
//                            child: Text(
//                              'Full lifetime access',
//                              style: TextStyle(fontSize: 13, color: kTextColor),
//                            ),
//                          ),
//                        ),
//                        ListTile(
//                          visualDensity:
//                              VisualDensity(horizontal: 0, vertical: -4),
//                          leading: Icon(
//                            EvaIcons.phoneOutline,
//                            size: 20,
//                          ),
//                          title: Transform(
//                            transform: Matrix4.translationValues(-22, 0, 0),
//                            child: Text(
//                              'Access on mobile, desktop an TV',
//                              style: TextStyle(fontSize: 13, color: kTextColor),
//                            ),
//                          ),
//                        ),
//                        ListTile(
//                          visualDensity:
//                              VisualDensity(horizontal: 0, vertical: -4),
//                          // contentPadding: EdgeInsets.only(left: 0, right: 0),
//                          leading: Icon(
//                            EvaIcons.menu2Outline,
//                            size: 20,
//                          ),
//                          title: Transform(
//                            transform: Matrix4.translationValues(-22, 0, 0),
//                            child: Text(
//                              'Certificate of Completion',
//                              style: TextStyle(fontSize: 13, color: kTextColor),
//                            ),
//                          ),
//                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
//            Padding(
//              padding: EdgeInsets.only(
//                top: getProportionateScreenHeight(5),
//                left: getProportionateScreenWidth(5),
//                right: getProportionateScreenWidth(5),
//              ),
//              child: Card(
//                child: Container(
//                  width: getProportionateScreenWidth(400),
//                  child: Padding(
//                    padding: const EdgeInsets.only(top: 15.0),
//                    child: Column(
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: [
//                        Padding(
//                          padding: EdgeInsets.only(
//                              top: getProportionateScreenHeight(15),
//                              left: getProportionateScreenHeight(15)),
//                          child: Text(
//                            'What Will I Learn?',
//                            style: TextStyle(color: Colors.black, fontSize: 16),
//                          ),
//                        ),
//                        ListTile(
//                          visualDensity:
//                              VisualDensity(horizontal: 0, vertical: -4),
//                          leading: Icon(
//                            EvaIcons.playCircleOutline,
//                            size: 20,
//                          ),
//                          title: Transform(
//                            transform: Matrix4.translationValues(-22, 0, 0),
//                            child: Text(
//                              '21.5 total hours on-demand video',
//                              style: TextStyle(fontSize: 13, color: kTextColor),
//                            ),
//                          ),
//                        ),
//                        ListTile(
//                          visualDensity:
//                              VisualDensity(horizontal: 0, vertical: -4),
//                          leading: Icon(
//                            EvaIcons.flash,
//                            size: 20,
//                          ),
//                          title: Transform(
//                            transform: Matrix4.translationValues(-22, 0, 0),
//                            child: Text(
//                              '23 Quizzes',
//                              style: TextStyle(fontSize: 13, color: kTextColor),
//                            ),
//                          ),
//                        ),
//                        ListTile(
//                          visualDensity:
//                              VisualDensity(horizontal: 0, vertical: -4),
//                          leading: Icon(
//                            EvaIcons.bookOpenOutline,
//                            size: 20,
//                          ),
//                          title: Transform(
//                            transform: Matrix4.translationValues(-22, 0, 0),
//                            child: Text(
//                              '12 Articles',
//                              style: TextStyle(fontSize: 13, color: kTextColor),
//                            ),
//                          ),
//                        ),
//                        ListTile(
//                          visualDensity:
//                              VisualDensity(horizontal: 0, vertical: -4),
//                          leading: Icon(
//                            EvaIcons.closeCircleOutline,
//                            size: 20,
//                          ),
//                          title: Transform(
//                            transform: Matrix4.translationValues(-22, 0, 0),
//                            child: Text(
//                              'Full lifetime access',
//                              style: TextStyle(fontSize: 13, color: kTextColor),
//                            ),
//                          ),
//                        ),
//                        ListTile(
//                          visualDensity:
//                              VisualDensity(horizontal: 0, vertical: -4),
//                          leading: Icon(
//                            EvaIcons.phoneOutline,
//                            size: 20,
//                          ),
//                          title: Transform(
//                            transform: Matrix4.translationValues(-22, 0, 0),
//                            child: Text(
//                              'Access on mobile, desktop an TV',
//                              style: TextStyle(fontSize: 13, color: kTextColor),
//                            ),
//                          ),
//                        ),
//                        ListTile(
//                          visualDensity:
//                              VisualDensity(horizontal: 0, vertical: -4),
//                          // contentPadding: EdgeInsets.only(left: 0, right: 0),
//                          leading: Icon(
//                            EvaIcons.menu2Outline,
//                            size: 20,
//                          ),
//                          title: Transform(
//                            transform: Matrix4.translationValues(-22, 0, 0),
//                            child: Text(
//                              'Certificate of Completion',
//                              style: TextStyle(fontSize: 13, color: kTextColor),
//                            ),
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//              ),
//            ),
            Padding(
                padding: EdgeInsets.only(
                  top: getProportionateScreenHeight(5),
                  left: getProportionateScreenWidth(5),
                  right: getProportionateScreenWidth(5),
                ),
                child: Card(
                    child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: getProportionateScreenHeight(5),
                          left: getProportionateScreenWidth(5),
                          right: getProportionateScreenWidth(5),
                          bottom: getProportionateScreenWidth(10),
                        ),
                        child: Text('Course Description',
                            style: TextStyle(
                                fontSize: getProportionateScreenHeight(18),
                                fontWeight: FontWeight.bold)),
                      ),
                      widget.fullDesc != null ? DescriptionTextWidget(
                          text: widget.fullDesc) : SizedBox.shrink(),
                    ],
                  ),
                ))),
            Padding(
                padding: EdgeInsets.only(
                  top: getProportionateScreenHeight(5),
                  left: getProportionateScreenWidth(5),
                  right: getProportionateScreenWidth(5),
                ),
                child: widget.bought == false ? Card(
                    child: Container(
                  child: ListTile(
                    title: Text('Requirements',
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(18),
                            fontWeight: FontWeight.bold)),
                    subtitle: widget.requirements != null ? Text(
                        widget.requirements,
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(18),
                            fontWeight: FontWeight.bold)) : SizedBox.shrink(),
                  ),
                )) : SizedBox.shrink()
            ),
            widget.bought == false ?  Padding(
              padding: EdgeInsets.only(
                top: getProportionateScreenHeight(5),
                left: getProportionateScreenWidth(5),
                right: getProportionateScreenWidth(5),
              ),
              child: Card(
                  child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: getProportionateScreenHeight(5),
                          left: getProportionateScreenWidth(10),
                          // right: getProportionateScreenWidth(5),
                          bottom: getProportionateScreenWidth(15),
                        ),
                        child: Text('Students also Viewed',
                            style: TextStyle(
                                fontSize: getProportionateScreenHeight(18),
                                fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: getProportionateScreenHeight(10.0),
                        ),
                        child: StudentsAllViewContentRow(),
                      ),
                      SizedBox(height: getProportionateScreenWidth(15)),
                    ]),
              )),
            ) : SizedBox.shrink(),
            widget.bought == false ? Padding(
              padding: EdgeInsets.only(
                top: getProportionateScreenHeight(5),
                left: getProportionateScreenWidth(5),
                right: getProportionateScreenWidth(5),
              ),
              child: Card(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                       Padding(
                        padding: EdgeInsets.only(
                          top: getProportionateScreenHeight(10),
                          left: getProportionateScreenWidth(15),
                          bottom: getProportionateScreenWidth(10),
                        ),
                        child: widget.instructor != null ? Text(
                          'Created by ${widget.instructor}',
                          style: TextStyle(
                              fontSize: getProportionateScreenHeight(18),
                              fontWeight: FontWeight.bold),
                        ) : SizedBox.shrink(),
                      ),
                      Container(
                        height: getProportionateScreenHeight(100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                height: getProportionateScreenHeight(80),
                                width: getProportionateScreenWidth(150),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(7),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/tshirt.png'),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                widget.enrolled != null ?  Row(children: [
                                  Icon(Icons.person),
                                  Text('${widget.enrolled} students')
                                ]) : SizedBox.shrink(),
                                widget.enrolled != null ? Row(children: [
                                  Icon(Icons.book),
                                  Text('${widget.enrolled} students')
                                ]) : SizedBox.shrink(),
                                widget.rating != null ? Row(children: [
                                  Icon(Icons.star),
                                  Text('${widget.rating} students')
                                ]) : SizedBox.shrink(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ) : SizedBox.shrink(),
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
        child: widget.bought == false ? Row(
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

                          bool stat = cart.addItem(widget.id, widget.title, double.parse(widget.sale), widget.type);
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
                                color: nearlyWhite))
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ) : SizedBox.shrink()
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

  Widget form(List<String> videos)
  {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: videos.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return  ListTile(
          visualDensity:
          VisualDensity(horizontal: 0, vertical: -4),
          leading: Icon(
            EvaIcons.video,
            size: 20,
          ),
          title: Transform(
            transform: Matrix4.translationValues(-22, 0, 0),
            child: GestureDetector(
              onTap: ()
              {
                if(widget.bought == true){
                  String url = "https://fetch.nimihub.com/dele/api/services/"+videos[index];
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>
                      VideoScreen(videoPlayerController: VideoPlayerController.network(
                        url,
                      ), looping: true)));
                }else{
                  _showErrorDialog('You Have To Pay For The Course', 'Error');
                }

              },
              child: Flexible(
                child: Text(
                  videos[index],
                  style: TextStyle(fontSize: 13, color: Colors.blue),
                  maxLines: 3,
                ),
              ),
            ),
          ),
        );
      },
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
          widget.id, widget.type, widget.dateCreated, widget.dateModified);

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

class StudentsAllViewContentRow extends StatelessWidget {
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
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => DetailedScreen(
                            image: image,
                            title: title,
                            instructor: instructor,
                            rating: rating,
                            price: oldAmount,
                            sale: newAmount,
                            enrolled: enrolled,
                            bought: false,
                          )));
            },
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
                          child: Flexible(
                            child: Text(
                              featureModelList[index].title,
                              style:
                                  TextStyle(fontSize: 14.0, color: Colors.black),
                              softWrap: true,
                            ),
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
