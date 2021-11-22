import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:nimihub_online/animation/delayed_animation.dart';
// import 'package:nimihub_online/animation/delayed_animation.dart';
import 'package:nimihub_online/constants.dart';
// import 'package:nimihub/my_clippers/clipPath.dart';
import 'package:nimihub_online/sizeConfig1.dart';

class CourseInfo extends StatefulWidget {
  final String title;
  final int lessonCount;
  final int money;
  final double rating;
  final String imagePath;

  const CourseInfo(
      {Key key,
      this.title,
      this.lessonCount,
      this.money,
      this.rating,
      this.imagePath})
      : super(key: key);

  @override
  _CourseInfoState createState() => _CourseInfoState();
}

class _CourseInfoState extends State<CourseInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDF0F2),
      bottomSheet: belowButton(),
      //resizeToAvoidBottomInset: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            // height: MediaQuery.of(context).size.height,
            // width: MediaQuery.of(context).size.width,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                SafeArea(
                  child: Stack(
                    children: <Widget>[
                      //ClipPath(clipper: MyClipper(), child: imageCenter()),
                      Positioned(right: 20, bottom: 5, child: starDecoration()),
                    ],
                  ),
                ),
                title(),
                SizedBox(height: 3 * SizeConfig1.heightMultiplier),
                moneyAndStar(),
                SizedBox(height: 3 * SizeConfig1.heightMultiplier),
                boxUi(),
                // discriptionText(),
                // discriptionText(),
                // discriptionText(),
                DelayedAnimation(
                  delayedDuration: 300,
                  animDuration: 700,
                  animOffsetX: -1.35,
                  animOffsetY: 2.0,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 7, left: 7, top: 18),
                    child: descriptionText('Course Description',
                        'Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero\'s De Finibus Bonorum et Malorum for use in a type specimen book. It usually begins with'),
                  ),
                ),
                DelayedAnimation(
                  delayedDuration: 500,
                  animDuration: 700,
                  animOffsetX: -1.35,
                  animOffsetY: 2.0,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 7, left: 7, top: 8),
                    child: descriptionText('Course Description',
                        'Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero\'s De Finibus Bonorum et Malorum for use in a type specimen book. It usually begins with'),
                  ),
                ),
                DelayedAnimation(
                  delayedDuration: 700,
                  animDuration: 700,
                  animOffsetX: -1.35,
                  animOffsetY: 2.0,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 7, left: 7, top: 8),
                    child: descriptionText('Course Description',
                        'Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero\'s De Finibus Bonorum et Malorum for use in a type specimen book. It usually begins with'),
                  ),
                ),
                DelayedAnimation(
                  delayedDuration: 100,
                  animDuration: 700,
                  animOffsetX: -1.35,
                  animOffsetY: 0.0,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 7, left: 7, top: 8),
                    child: descriptionText('Course Description',
                        'Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero\'s De Finibus Bonorum et Malorum for use in a type specimen book. It usually begins with'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 7, left: 7, top: 8),
                  child: descriptionText('Course Description',
                      'Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero\'s De Finibus Bonorum et Malorum for use in a type specimen book. It usually begins with'),
                ),

                SizedBox(height: 9 * SizeConfig1.heightMultiplier),
              ],
            ),
          ),

//            SizedBox(height: 8 * SizeConfig1.heightMultiplier),

          // descriptionText('Course Description',
          //     'Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero\'s De Finibus Bonorum et Malorum for use in a type specimen book. It usually begins with'),
          //SizedBox(height: 6 * SizeConfig1.heightMultiplier),
        ],
      ),
    );
  }

  Widget belowButton() {
    return Container(
      height: 8 * SizeConfig1.heightMultiplier,
      // color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18),
        child: Row(
          children: <Widget>[
            Text("\$${widget.money}",
                style: TextStyle(
                    fontFamily: "muli",
                    fontWeight: FontWeight.bold,
                    fontSize: 2.3 * SizeConfig1.textMultiplier,
                    letterSpacing: 0.27,
                    color: Colors.black)),
            //SizedBox(width: 4.7 * SizeConfig1.widthMultiplier),
            SizedBox(
              width: 30 * SizeConfig1.widthMultiplier,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 2 * SizeConfig1.heightMultiplier),
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
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 0.5 * SizeConfig1.heightMultiplier),
                        child: Text("BUY NOW",
                            style: TextStyle(
                                fontFamily: "muli",
                                fontWeight: FontWeight.bold,
                                fontSize: 2.0 * SizeConfig1.textMultiplier,
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

  Widget descriptionText(String title, String description) {
    // return Flexible(
    //   child: Padding(
    //     padding: EdgeInsets.only(
    //         left: 18, right: 18, top: 1.6 * SizeConfig1.heightMultiplier),
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.0))),
      elevation: 2,
      //margin: EdgeInsets.all(12.0),
      child: ExpansionTile(
        backgroundColor: Colors.white,
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: SizedBox(),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(description, textAlign: TextAlign.left),
          ),
        ],
      ),
    );
    //   ),
    // );
  }

  // Widget discriptionText() {
  //   return Flexible(
  //       flex: 2,
  //       child: Padding(
  //         padding: const EdgeInsets.only(left: 18, right: 18),
  //         child: Padding(
  //           padding: EdgeInsets.only(top: 1.6 * SizeConfig1.heightMultiplier),
  //           child: Container(
  //             child: Center(
  //               child: Text(
  //                   "A design is a plan or specification for the construction of an object or system or  design is a plan or specification for the construction of an object or system or for t design is a plan or specification for the construction of an object or system or for t design is a plan or specification for the construction of an object or system or for t for the implementation of an activity or process, or the result of that plan or specification in the form of a prototype, product or process.",
  //                   textAlign: TextAlign.center,
  //                   style: TextStyle(
  //                       fontFamily: "muli",
  //                       fontSize: 2.1 * SizeConfig1.textMultiplier,
  //                       letterSpacing: 0.27,
  //                       color: Colors.black)),
  //             ),
  //           ),
  //         ),
  //       ));
  // }

  Widget boxUi() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(right: 18, left: 18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DelayedAnimation(
                delayedDuration: 100,
                animDuration: 700,
                animOffsetX: -1.35,
                animOffsetY: 0.0,
                child: getBoxUi('${widget.lessonCount}', 'Lessons')),
            DelayedAnimation(
                delayedDuration: 300,
                animDuration: 300,
                animOffsetX: -1.35,
                animOffsetY: 0.0,
                child: getBoxUi('2 Hours', 'Time')),
            DelayedAnimation(
                delayedDuration: 500,
                animDuration: 700,
                animOffsetX: -1.35,
                animOffsetY: 0.0,
                child: getBoxUi('16', 'Seats')),
          ],
        ),
      ),
    );
  }

  Widget getBoxUi(String s1, String s2) {
    return Container(
      width: 11.23 * SizeConfig1.heightMultiplier,
      height: 18.5 * SizeConfig1.widthMultiplier,
      decoration: BoxDecoration(
        color: kPrimraryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black45.withOpacity(0.2),
            blurRadius: 15,
            offset: Offset(0, 15),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            s1,
            style: TextStyle(
                color: nearlyWhite,
                fontWeight: FontWeight.bold,
                fontSize: 2 * SizeConfig1.heightMultiplier,
                letterSpacing: 0.27),
          ),
          Text(
            s2,
            style: TextStyle(
                color: nearlyWhite,
                fontWeight: FontWeight.bold,
                fontSize: 1.8 * SizeConfig1.heightMultiplier,
                letterSpacing: 0.27),
          ),
        ],
      ),
    );
  }

  Widget moneyAndStar() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 18, right: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\$${widget.money}',
              style: TextStyle(
                letterSpacing: 0.27,
                fontSize: 2.3 * SizeConfig1.heightMultiplier,
                color: kPrimraryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Text(
                  '${widget.rating}',
                  style: TextStyle(
                    letterSpacing: 0.27,
                    fontSize: 2.3 * SizeConfig1.heightMultiplier,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.star,
                  color: Colors.red,
                  size: 2.8 * SizeConfig1.heightMultiplier,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget title() {
    return Container(
      width: 62.5 * SizeConfig1.widthMultiplier,
      child: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 20),
        child: Text(
          widget.title,
          style: TextStyle(
            fontSize: 2.8 * SizeConfig1.heightMultiplier,
            letterSpacing: 1.2,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget starDecoration() {
    return Container(
      height: 6 * SizeConfig1.heightMultiplier,
      width: 11 * SizeConfig1.widthMultiplier,
      decoration: BoxDecoration(
        color: nearlyWhite,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: kPrimraryColor.withOpacity(0.4),
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Icon(
        Icons.star,
        color: kPrimraryColor,
        size: 4 * SizeConfig1.heightMultiplier,
      ),
    );
  }

  Widget imageCenter() {
    return Container(
      color: kPrimraryColor,
      width: double.infinity,
      height: 35 * SizeConfig1.heightMultiplier,
      child: DelayedAnimation(
        delayedDuration: 700,
        animDuration: 700,
        animOffsetX: -1.35,
        animOffsetY: 0.0,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Image.asset(widget.imagePath),
          ),
        ),
      ),
    );
  }
}
