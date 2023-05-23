import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../shared/wedjets/materialbutton.dart';
import '../bot/chat_screen.dart';
import '../login/login_screen.dart';
import '../patient/about_us.dart';
import '../patient/mydrawer.dart';
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
        appBar: AppBar(),
        body: Stack(
          children: [
            // Add your background image or color here
            Container(
                decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover,
              ),
            )),
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
                    height: size.height / 40,
                  ),

                  SizedBox(
                    height: size.height / 30,
                  ),
                  CustomButton(
                    name: "Chat With Patient",
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Pharmacy();
                      }));
                    },
                  ),
                  SizedBox(
                    height: size.height / 30,
                  ),

                  // Add your "Contact Us" section here
                  CustomButton(
                    name: "Chat Bot",
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ChatScreen();
                      }));
                    },
                  ),
                  SizedBox(height: size.height / 20),

                  CustomButton(
                    name: "About Us",
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AboutUs();
                      }));
                    },
                  ),
                  SizedBox(height: size.height / 20),
                ],
              )),
            ),
          ],
        ),
        drawer: MyDrawer(
          name: email.split('@')[0],
          email: email,
          onPressed: () async {
            await FirebaseAuth.instance
                .signOut()
                .then((value) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    ));
          },
        ));
  }
}
