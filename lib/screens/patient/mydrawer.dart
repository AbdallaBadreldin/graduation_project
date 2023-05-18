import 'package:chatapp_master/screens/patient/contactus.dart';
import 'package:flutter/material.dart';
import 'about_us.dart';
import 'contactform.dart';
import 'help-feedback.dart';

import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final String? name;
  final String? email;
  final VoidCallback? onPressed;

  const MyDrawer(
      {Key? key,
      required this.name,
      required this.email,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40.0, color: Colors.blue),
                ),
                SizedBox(height: 10.0),
                Text(
                  name!,
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                SizedBox(height: 5.0),
                Text(
                  email!,
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
              // Add code to navigate to the home screen here
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              // Add code to navigate to the settings screen here
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help & Feedback'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return HelpFeedbackPage();
              }));

              // Add code to navigate to the help/feedback screen here
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: onPressed
            // Add code to perform the logout operation here
            ,
          ),
        ],
      ),
    );
  }
}
