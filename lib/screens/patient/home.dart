// ignore_for_file: prefer_const_constructors, unnecessary_import, implementation_imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:chatapp_master/screens/drawer_information/about_us.dart';
import 'package:chatapp_master/screens/patient/precesions-1.dart';
import 'package:chatapp_master/screens/patient/scan_prescription.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:chatapp_master/screens/login/login_screen.dart';
import 'package:chatapp_master/shared/constants.dart';
import 'package:chatapp_master/globals.dart' as globals;

import '../../models/user_model.dart';
import '../../shared/wedjets/materialbutton.dart';
import '../bot/chat_screen.dart';
import 'clock.dart';
import '../drawer_information/mydrawer.dart';
import '../drawer_information/button.dart';
import 'notifications.dart';
import 'package:chatapp_master/screens/login/patient.dart';

class Home extends StatelessWidget {
  Home({super.key});

  String value = '';
  Home.fromname(this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    globals.sharedValue = "Patient";
    final size = MediaQuery.of(context).size;
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email ?? 'Not signed in';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Patient Home",
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
                    image: 'assets/images/Scan.jpg',
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return prescription();
                      }));
                    },
                    text: "Scan Prescription",
                    icon: Icons.document_scanner),
                SizedBox(
                  height: 20,
                ),

                buildGestureDetector(
                    context: context,
                    image: 'assets/images/alarm.webp',
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AllPrescription.fromname();
                      }));
                    },
                    text: "Alarm",
                    icon: Icons.alarm),
                SizedBox(
                  height: 20,
                ),
                buildGestureDetector(
                    context: context,
                    image: 'assets/images/download.jpg',
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Patient();
                      }));
                    },
                    text: "Chat",
                    icon: Icons.access_alarm),
                SizedBox(
                  height: size.height / 30,
                ),
                // Add your "Contact Us" section here
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
        name: value.split('@')[0],
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
      ),
    );
  }
}
