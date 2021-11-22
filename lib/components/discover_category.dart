import 'package:flutter/material.dart';
import 'package:nimihub_online/screens/discover/discover_screeen.dart';
import 'package:nimihub_online/screens/ebooks/ebooks.dart';
import 'package:nimihub_online/screens/exams/exams.dart';

// For the categories bar (a stateful widget is required)
// class DiscoverCategories extends StatefulWidget {
//   @override
//   _DiscoverCategoriesState createState() => _DiscoverCategoriesState();
// }

// class _DiscoverCategoriesState extends State<DiscoverCategories> {
//   List<String> categories = [
//     'Tutorials',
//     'Books',
//     'Exams',
//   ];
// // Makes the first item to be selected by default
//   int selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20),
//       child: SizedBox(
//         height: 25,
//         child: ListView.builder(
//           itemBuilder: (context, index) => buildCategory(index),
//           itemCount: categories.length,
//           scrollDirection: Axis.horizontal,
//           physics: BouncingScrollPhysics(),
//         ),
//       ),
//     );
//   }

//   Widget buildCategory(int index) => GestureDetector(
//         onTap: () {
//           setState(() {
//             selectedIndex = index;
//             if (selectedIndex == 1) {
//               Navigator.pushNamed(context, EBooks.routeName);
//             } else if (selectedIndex == 2) {
//               Navigator.pushNamed(context, Exams.routeName);
//             }
//             return null;
//           });
//         },
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 25,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
            
//               Text(
//                 categories[index],
//                 style: TextStyle(
//                   fontSize: selectedIndex == index ? 20:16,
//                     fontWeight: FontWeight.bold,
//                     color: selectedIndex == index
//                         ? Color(0xFF535353)
//                         : Color(0xFFACACAC)),
//               ),
//               Container(
//                 margin: EdgeInsets.only(
//                     top: 20 / 4), // Puts a padding of 5 on the top of it
//                 height: 2.0,
//                 width: 30.0,
//                 color:
//                     selectedIndex == index ? Colors.black : Colors.transparent,
//               )
//             ],
//           ),
//         ),
//       );
// }


class DiscoverCategories extends StatefulWidget {
  @override
  _DiscoverCategoriesState createState() => _DiscoverCategoriesState();
}

class _DiscoverCategoriesState extends State<DiscoverCategories> {
  PageController pageController = new PageController();

  void onTap(int page) {
    setState(() {
      selectedIndex = page;
    });
    pageController.jumpToPage(page);
  }

  List<String> categories = [
    'Tutorials',
    'Books',
    'Exams',
  ];
// Makes the first item to be selected by default
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        height: 25,
        child: ListView.builder(
          itemBuilder: (context, index) => buildCategory(index),
          itemCount: categories.length,
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
        ),
      ),
    );
  }

  Widget buildCategory(int index) => GestureDetector(
        onTap: () => onTap,

        // onTap: () {
        //   // onTap;
        //   // setState(() {
        //   //   selectedIndex = index;
        //   //   if (selectedIndex == 1) {
        //   //     Navigator.pushNamed(context, EBooks.routeName);
        //   //   } else if (selectedIndex == 2) {
        //   //     Navigator.pushNamed(context, Exams.routeName);
        //   //   }
        //   //   return null;
        //   // });
        // },
        child: Column(
          children: [
            
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    categories[index],
                    style: TextStyle(
                        fontSize: selectedIndex == index ? 20 : 16,
                        fontWeight: FontWeight.bold,
                        color: selectedIndex == index
                            ? Color(0xFF535353)
                            : Color(0xFFACACAC)),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 20 / 4), // Puts a padding of 5 on the top of it
                    height: 2.0,
                    width: 30.0,
                    color: selectedIndex == index
                        ? Colors.black
                        : Colors.transparent,
                  ),
                  PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              children: [
                DiscoverScreen(),
                EBooks(),
                Exams(),
              ],
            ),
                ],
              ),
            ),
          ],
        ),
      );
}
