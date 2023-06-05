import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../shared/wedjets/materialbutton.dart';
import '../bot/chat_screen.dart';
import '../login/login_screen.dart';
import '../drawer_information/about_us.dart';
import '../drawer_information/mydrawer.dart';
import '../drawer_information/button.dart';
import 'pharmacy.dart';

class home_pharmacy extends StatefulWidget {
  home_pharmacy({super.key});

  String value = '';
  home_pharmacy.fromname(this.value, {super.key});

  @override
  State<home_pharmacy> createState() => _home_pharmacyState();
}

class _home_pharmacyState extends State<home_pharmacy> {
  var _username;
  final firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    // Get the current user's ID
    String userId = FirebaseAuth.instance.currentUser!.uid;
    // Retrieve the username from the database
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .get()
        .then((DocumentSnapshot snapshot) {
      setState(() {
        // Add a null check to ensure that snapshot.data() is not null
        final Map<String, dynamic> data =
            snapshot.data() as Map<String, dynamic>;
        _username = data != null && data.containsKey("username")
            ? data["username"]
            : null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email ?? 'Not signed in';

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Pharmacy Home",
            style: TextStyle(
              fontFamily: "Courgette",
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.cyan,
          foregroundColor: Colors.white,
        ),
        body: Stack(
          children: [
            // Add your background image or color here
            Container(),
            SingleChildScrollView(
              child: Container(
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height / 80,
                  ),
                  buildGestureDetector(
                      context: context,
                      image: 'assets/images/download.jpg',
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Pharmacy();
                        }));
                      },
                      text: "Chat",
                      icon: Icons.access_alarm),
                  SizedBox(height: 20),
                  buildGestureDetector(
                      context: context,
                      image: 'assets/images/ai.jpg',
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const ChatScreen();
                        }));
                      },
                      text: "Chat Bot",
                      icon: Icons.access_alarm),
                  SizedBox(height: 20),
                  buildGestureDetector(
                      context: context,
                      image: 'assets/images/inf.jpg',
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return AboutUs();
                        }));
                      },
                      text: "About Us",
                      icon: Icons.access_alarm),
                  SizedBox(height: 20),
                ],
              )),
            ),
          ],
        ),
        drawer: MyDrawer(
          name: email.split('@')[0],
          email: email,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Logout'),
                  content: Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Logout'),
                      onPressed: () async {
                        Navigator.of(context).pop();
                        await FirebaseAuth.instance.signOut().then((value) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
                        });
                      },
                    ),
                  ],
                );
              },
            );
          },
        ));
  }
}
