import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool _lights = false;
  bool _values = false;
  bool _toggled = false;
  bool _tapped = false;
  bool _clicked = false;
  bool _checked = false;
  bool _touched = false;
  bool _switched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notification')),
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: [
            //
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: SwitchListTile(
                onChanged: (bool value) {
                  setState(() {
                    _toggled = value;
                  });
                },
                value: _toggled,
                title: Text('Comments'),
                // tileColor: Colors.blueGrey.withOpacity(0.05),
                subtitle: Text('Lorem Ipsum sit amet'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: SwitchListTile(
                onChanged: (bool value) {
                  setState(() {
                    _clicked = value;
                  });
                },
                value: _clicked,
                title: Text('Comments Likes'),
                activeColor: Colors.blueGrey.withOpacity(0.05),
                subtitle: Text('Lorem Ipsum sit amet'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: SwitchListTile(
                onChanged: (bool value) {
                  setState(() {
                    _checked = value;
                  });
                },
                value: _checked,
                title: Text('Replies'),
                // tileColor: Colors.blueGrey.withOpacity(0.05),
                subtitle: Text('Lorem Ipsum sit amet'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: SwitchListTile(
                onChanged: (bool value) {
                  setState(() {
                    _switched = value;
                  });
                },
                value: _switched,
                title: Text('Mentions'),
                activeColor: Colors.blueGrey.withOpacity(0.05),
                subtitle: Text('Lorem Ipsum sit amet'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: SwitchListTile(
                onChanged: (bool value) {
                  setState(() {
                    _touched = value;
                  });
                },
                value: _touched,
                title: Text('Likes'),
                // tileColor: Colors.blueGrey.withOpacity(0.05),
                subtitle: Text('Lorem Ipsum sit amet'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: SwitchListTile(
                onChanged: (bool value) {
                  setState(() {
                    _lights = value;
                  });
                },
                value: _lights,
                title: Text('Others'),
                activeColor: Colors.blueGrey.withOpacity(0.05),
                subtitle: Text('Lorem Ipsum sit amet'),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
