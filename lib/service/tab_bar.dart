import 'package:flutter/material.dart';
import 'package:nimihub_online/screens/discover/discover_screeen.dart';
import 'package:nimihub_online/screens/ebooks/ebooks.dart';
import 'package:nimihub_online/screens/exams/exams.dart';

class TabBars extends StatefulWidget {
  @override
  _TabBarsState createState() => _TabBarsState();
}

class _TabBarsState extends State<TabBars> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(100.0),
              child: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.contacts), text: "Tab 1"),
                  Tab(icon: Icon(Icons.camera_alt), text: "Tab 2")
                ],
              )),
        ),
        body: TabBarView(  
            children: [  
              DiscoverScreen(), 
              EBooks(),
              Exams(),  
            ],  
          ),
      ),
    );
  }
}
