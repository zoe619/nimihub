import 'package:flutter/material.dart';
import 'package:nimihub_online/screens/notification/notification.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _tapped = false;
  bool _toggled = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('User Interface'),
          SwitchListTile(
            onChanged: (bool value) {
              setState(() {
                _tapped = value;
              });
            },
            value: _tapped,
            title: Text('Dark Mode'),
            activeColor: Colors.blueGrey.withOpacity(0.05),
            subtitle: Text('Lorem Ipsum sit amet'),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: SwitchListTile(
              onChanged: (bool value) {
                setState(() {
                  _toggled = value;
                });
              },
              value: _toggled,
              title: Text('View answer button'),
              // tileColor: Colors.blueGrey.withOpacity(0.05),
              subtitle: Text(
                'Lorem Ipsum sit amet',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          Divider(),
          Text(
            'Account Privacy',
          ),
          SwitchListTile(
            onChanged: (bool value) {
              setState(() {
                _tapped = value;
              });
            },
            value: _tapped,
            title: Text('Privacy'),
            activeColor: Colors.blueGrey.withOpacity(0.05),
            subtitle: Text('Who can see my Bio'),
          ),
          Divider(),
          Text(
            'Video preference',
          ),
          ListTile(
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
            title: Text(
              'Download options',
              style: TextStyle(
                  color: Colors.black, fontSize: 15, letterSpacing: -1),
            ),
            subtitle: Text(
              'Lorem Ipsum sit amet',
              style: TextStyle(fontSize: 14),
            ),
          ),
          ListTile(
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
            title: Text(
              'Video playback options',
              style: TextStyle(
                  color: Colors.black, fontSize: 15, letterSpacing: -1),
            ),
            subtitle: Text(
              'Lorem Ipsum sit amet',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Divider(),
          Text(
            'Notifications',
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => new NotificationScreen(),
                ),
              );
            },
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
            title: Text(
              'On Nimihub',
              style: TextStyle(
                  color: Colors.black, fontSize: 15, letterSpacing: -1),
            ),
            subtitle: Text(
              'Lorem Ipsum sit amet',
              style: TextStyle(fontSize: 14),
            ),
          ),
          // Divider(),
          ListTile(
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
            title: Text(
              'Push Notification',
              style: TextStyle(
                  color: Colors.black, fontSize: 15, letterSpacing: -1),
            ),
            subtitle: Text(
              'Lorem Ipsum sit amet',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      )),
    ));
  }
}
