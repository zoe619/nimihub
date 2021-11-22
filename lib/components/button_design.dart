import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nimihub_online/constants.dart';
import 'package:nimihub_online/sizeConfig1.dart';

class BouncingButton extends StatefulWidget {
  @override
  _BouncingButtonState createState() => _BouncingButtonState();
}

class _BouncingButtonState extends State<BouncingButton> {
  CategoryType categoryType = CategoryType.political;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 18,
        right: 18,
      ),
      child: Row(
        children: [
          getButtonUi(
              CategoryType.political, categoryType == CategoryType.political),
          SizedBox(width: 5 * SizeConfig1.widthMultiplier),
          getButtonUi(
              CategoryType.business, categoryType == CategoryType.business),
          SizedBox(width: 5 * SizeConfig1.widthMultiplier),
          getButtonUi(
              CategoryType.commercial, categoryType == CategoryType.commercial),
          SizedBox(width: 5 * SizeConfig1.widthMultiplier),
          // getButtonUi(CategoryType.administrative,
          //     categoryType == CategoryType.administrative),
          //   SizedBox(width: 5 * SizeConfig1.widthMultiplier),
          //   getButtonUi(
          //       CategoryType.criminal, categoryType == CategoryType.criminal),
          //   SizedBox(width: 5 * SizeConfig1.widthMultiplier),
          getButtonUi(
              CategoryType.foreign, categoryType == CategoryType.foreign),
        ],
      ),
    );
  }

  Widget getButtonUi(CategoryType categoryTypeData, bool isSelected) {
    String title;
    if (categoryTypeData == CategoryType.political) {
      title = 'Political';
    } else if (categoryTypeData == CategoryType.business) {
      title = 'Business';
    } else if (categoryTypeData == CategoryType.commercial) {
      title = 'Commercial';
    } else if (categoryTypeData == CategoryType.administrative) {
      title = 'Administrative';
    } else if (categoryTypeData == CategoryType.criminal) {
      title = 'Criminal';
    } else if (categoryTypeData == CategoryType.foreign) {
      title = 'Foreign';
    }
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            categoryType = categoryTypeData;
          });
        },
        child: isSelected
            ? getButton(isSelected, 0.0, Offset(0, 0), title)
            : getButton(isSelected, 15, Offset(0, 10), title),
      ),
    );
  }

  Widget getButton(
      bool isSelected, double borderRadius, Offset offset, String text) {
    return Container(
      height: 5.2 * SizeConfig1.heightMultiplier,
      width: 614.6 * SizeConfig1.widthMultiplier,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: borderRadius,
              offset: offset,
              color: Colors.black.withOpacity(0.3))
        ],
        color: isSelected ? kPrimraryColor : Colors.white,
        border: Border.all(color: kPrimraryColor),
        borderRadius: BorderRadius.all(
          Radius.circular(2.6 * SizeConfig1.heightMultiplier),
        ),
      ),
      child: Center(
        child: FittedBox(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black,
                letterSpacing: 1.0,
                // fontSize: 1.5 * SizeConfig1.textMultiplier,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum CategoryType {
  political,
  business,
  commercial,
  administrative,
  criminal,
  foreign,
}
