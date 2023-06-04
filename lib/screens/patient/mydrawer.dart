import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../pharmacy/TermsOfUsePage.dart';
import '../profile/edit_profile.dart';
import '../profile/profile.dart';
import 'about_us.dart';
import 'help-feedback.dart';

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
            leading: Icon(Icons.person),
            title: Text('Show Profile'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return UserProfileScreen(
                    userId: FirebaseAuth.instance.currentUser!.uid);
              }));
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
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_phone),
            title: Text('Terms of Use'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return TermsOfUsePage();
              }));
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: onPressed,
          ),
        ],
      ),
    );
  }
}
