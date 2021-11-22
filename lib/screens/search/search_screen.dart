import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nimihub_online/animation/delayed_animation.dart';
import 'package:nimihub_online/models/search_model_list.dart';
// import 'package:nimihub_online/components/browse_categories.dart';
// import 'package:nimihub_online/models/searches_model.dart';
import '../../constants.dart';
import '../../size_config.dart';

class SearchScreen extends StatefulWidget {
  static String routeName = '/search';
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Map<String, String>> introData = [
    {
      "image": "assets/images/splash_3.png",
      "text2": 'Get more out of learning',
      'text1': 'Learner'
    },
    {
      "image": "assets/images/splash_2.png",
      "text1": 'Forward',
      'text2': 'Give it a shot, Give it your Best \nWatch the results Bloom'
    },
    {
      "image": "assets/images/splash_1.png",
      "text1": 'Invest',
      'text2': 'Read consistently, study everly \nand watch your progress '
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () => showSearch(context: context, delegate: SearchBar()),
          child: DelayedAnimation(
            delayedDuration: 300,
            animDuration: 700,
            animOffsetX: 1.35,
            animOffsetY: 0,
            child: TextField(
              cursorColor: Colors.black,
              decoration: InputDecoration(
                enabled: false,
                hintText: 'Search Courses',
                filled: false,
                fillColor: Colors.black.withOpacity(0.6),
                prefixIcon: Icon(Icons.search, color: Colors.black),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(color: kTextColor),
                  gapPadding: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(color: kTextColor),
                  gapPadding: 10,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(color: kTextColor),
                  gapPadding: 10,
                ),
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 14, left: 14),
            child: GestureDetector(
              onTap: () {
                print('cart');
                // Navigator.pushNamed(context, Cart.routeName);
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
        child: //Column(
            //children: [
            ListView.builder(
          itemCount: introData.length,
          itemBuilder: (BuildContext context, int index) {
            return Wrap(
              alignment: WrapAlignment.start,
              runSpacing: 8.0,
              children: [
                Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                    padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(introData[index]['text1']),
                      ],
                    )),
              ],
            );
          },
        ),
        // BrowseCategories(),
        // ],
        // ),
      ),
    );
  }
}

class SearchBar extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(
            EvaIcons.close,
          ),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(EvaIcons.arrowBackOutline),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(child: Text('ok'));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final searches = query.isEmpty
        ? searchModelList
        : searchModelList.where((p) => p.title.startsWith(query)).toList();

    return searches.isEmpty
        ? Center(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(radius: 80, child: Icon(EvaIcons.close)),
              Text('No Results Found',
                  style: TextStyle(
                      fontSize: getProportionateScreenHeight(22),
                      fontWeight: FontWeight.bold))
            ],
          ))
        : ListView.builder(
            itemCount: searches.length,
            itemBuilder: (BuildContext context, int index) {
              final searchList = searchModelList[index];
              return ListTile(
                onTap: () {
                  showResults(context);
                },
                title: Text(searchList.title),
                leading: Container(
                  height: getProportionateScreenHeight(80),
                  width: getProportionateScreenWidth(150),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(7),
                    image: DecorationImage(
                        image: AssetImage(searchList.image), fit: BoxFit.cover),
                  ),
                ),
                subtitle: Column(
                  children: [
                    Text(searchList.instructor),
                    Container(
                      width: 180,
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.deepOrangeAccent,
                            size: 8,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.deepOrangeAccent,
                            size: 8,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.deepOrangeAccent,
                            size: 8,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.deepOrangeAccent,
                            size: 8,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.deepOrangeAccent,
                            size: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              '${searchList.rating}',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              '(${searchList.enrolled})',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '\$${searchList.newAmount}',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text('\$${searchList.oldAmount}',
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 12)),
                        ),
                      ],
                    ),
                    Divider(),
                  ],
                ),
              );
            },
          );
  }
}
