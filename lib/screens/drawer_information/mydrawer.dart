import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pharmacy/TermsOfUsePage.dart';
import '../profile/profile.dart';

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
            decoration: const BoxDecoration(
              color: Colors.cyan,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40.0, color: Colors.blue),
                ),
                const SizedBox(height: 10.0),
                Text(
                  name!,
                  style: const TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                const SizedBox(height: 5.0),
                Text(
                  email!,
                  style: const TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              // Add code to navigate to the home screen here
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Show Profile'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return UserProfileScreen(
                    userId: FirebaseAuth.instance.currentUser!.uid);
              }));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help & Feedback'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return HelpFeedbackPage();
              }));
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_phone),
            title: const Text('Terms of Use'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const TermsOfUsePage();
              }));
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: onPressed,
          ),
        ],
      ),
    );
  }
}
