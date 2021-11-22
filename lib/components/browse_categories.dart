import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:nimihub_online/constants.dart';
import 'package:nimihub_online/models/wish.dart';

class BrowseCategories extends StatelessWidget
{
  final List<Wishes> wishes;

  const BrowseCategories({
    Key key, this.wishes
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 13.0),
          child: Text(
            'Browse categories',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
      ListView.builder(
      itemCount: wishes.length,
      scrollDirection: Axis.vertical,
        shrinkWrap: true,
      itemBuilder: (BuildContext context, int index)
      {
         return Transform(
           transform: Matrix4.translationValues(20, 0, 0),
           child: Text(
             '${wishes[index].item}',
             style: TextStyle(fontSize: 13, color: kTextColor),
           ),
         );
       },
      ),



//    ListTile(
//      leading: Icon(
//        EvaIcons.code,
//        size: 20,
//      ),
//      title: Transform(
//        transform: Matrix4.translationValues(-22, 0, 0),
//        child: Text(
//          'Development',
//          style: TextStyle(fontSize: 13, color: kTextColor),
//        ),
//      ),
//    ),
//    ListTile(
//      leading: Icon(EvaIcons.barChart, size: 20),
//      title: Transform(
//        transform: Matrix4.translationValues(-22, 0, 0),
//        child: Text(
//          'Business',
//          style: TextStyle(fontSize: 13, color: kTextColor),
//        ),
//      ),
//    ),
//    ListTile(
//      leading: Icon(EvaIcons.monitor, size: 20),
//      title: Transform(
//        transform: Matrix4.translationValues(-22, 0, 0),
//        child: Text(
//          'IT & Software',
//          style: TextStyle(fontSize: 13, color: kTextColor),
//        ),
//      ),
//    ),
//    ListTile(
//      leading: Icon(
//        EvaIcons.browserOutline,
//        size: 20,
//      ),
//      title: Transform(
//        transform: Matrix4.translationValues(-22, 0, 0),
//        child: Text(
//          'Finance and banking',
//          style: TextStyle(fontSize: 13, color: kTextColor),
//        ),
//      ),
//    ),
//    ListTile(
//      leading: Icon(
//        EvaIcons.browserOutline,
//        size: 20,
//      ),
//      title: Transform(
//        transform: Matrix4.translationValues(-22, 0, 0),
//        child: Text(
//          'Finance and banking',
//          style: TextStyle(fontSize: 13, color: kTextColor),
//        ),
//      ),
//    ),
//    ListTile(
//      leading: Icon(
//        EvaIcons.browserOutline,
//        size: 20,
//      ),
//      title: Transform(
//        transform: Matrix4.translationValues(-22, 0, 0),
//        child: Text(
//          'Finance and banking',
//          style: TextStyle(fontSize: 13, color: kTextColor),
//        ),
//      ),
//    ),
//    ListTile(
//      leading: Icon(
//        EvaIcons.browserOutline,
//        size: 20,
//      ),
//      title: Transform(
//        transform: Matrix4.translationValues(-22, 0, 0),
//        child: Text(
//          'Finance and banking',
//          style: TextStyle(fontSize: 13, color: kTextColor),
//        ),
//      ),
//    ),
//    ListTile(
//      leading: Icon(
//        EvaIcons.browserOutline,
//        size: 20,
//      ),
//      title: Transform(
//        transform: Matrix4.translationValues(-22, 0, 0),
//        child: Text(
//          'Finance and banking',
//          style: TextStyle(fontSize: 13, color: kTextColor),
//        ),
//      ),
//    ),
//    ListTile(
//      leading: Icon(
//        EvaIcons.browserOutline,
//        size: 20,
//      ),
//      title: Transform(
//        transform: Matrix4.translationValues(-22, 0, 0),
//        child: Text(
//          'Finance and banking',
//          style: TextStyle(fontSize: 13, color: kTextColor),
//        ),
//      ),
//    ),
//    ListTile(
//      leading: Icon(
//        EvaIcons.browserOutline,
//        size: 20,
//      ),
//      title: Transform(
//        transform: Matrix4.translationValues(-22, 0, 0),
//        child: Text(
//          'Finance and banking',
//          style: TextStyle(fontSize: 13, color: kTextColor),
//        ),
//      ),
//    ),
//    ListTile(
//      leading: Icon(
//        EvaIcons.browserOutline,
//        size: 20,
//      ),
//      title: Transform(
//        transform: Matrix4.translationValues(-22, 0, 0),
//        child: Text(
//          'Finance and banking',
//          style: TextStyle(fontSize: 13, color: kTextColor),
//        ),
//      ),
//    ),
//    ListTile(
//      leading: Icon(
//        EvaIcons.browserOutline,
//        size: 20,
//      ),
//      title: Transform(
//        transform: Matrix4.translationValues(-22, 0, 0),
//        child: Text(
//          'Finance and banking',
//          style: TextStyle(fontSize: 13, color: kTextColor),
//        ),
//      ),
//    ),
//    ListTile(
//      leading: Icon(
//        EvaIcons.browserOutline,
//        size: 20,
//      ),
//      title: Transform(
//        transform: Matrix4.translationValues(-22, 0, 0),
//        child: Text(
//          'Finance and banking',
//          style: TextStyle(fontSize: 13, color: kTextColor),
//        ),
//      ),),
      ],
    );
  }
}
