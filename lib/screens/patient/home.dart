// ignore_for_file: prefer_const_constructors, unnecessary_import, implementation_imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:chatapp_master/screens/patient/about_us.dart';
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
import 'contactform.dart';
import 'mydrawer.dart';
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
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => notification()));
              },
              icon: Icon(Icons.notifications),
            ),
          ],
        ),
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
                  CustomButton(
                    name: "Scan Prescription",
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return prescription();
                      }));
                    },
                  ),
                  SizedBox(
                    height: size.height / 30,
                  ),
                  CustomButton(
                    name: "Alarm",
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Clock();
                      }));
                    },
                  ),
                  SizedBox(
                    height: size.height / 30,
                  ),
                  CustomButton(
                    name: "Prescriptions",
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AllPrescription.fromname();
                      }));
                    },
                  ),
                  SizedBox(
                    height: size.height / 30,
                  ),
                  CustomButton(
                    name: "Chat Room",
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Patient();
                      }));
                    },
                  ),
                  SizedBox(
                    height: size.height / 30,
                  ),
                  // Add your "Contact Us" section here
                  CustomButton(
                    name: "Chat With Ai",
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
          name: value.split('@')[0],
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
