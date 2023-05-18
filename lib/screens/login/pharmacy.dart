import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../chat_homelayout/chathomelayout.dart';
import 'package:chatapp_master/shared/constants.dart';
import 'package:chatapp_master/globals.dart' as globals;
import 'login_screen.dart';

class Pharmacy extends StatefulWidget {
  const Pharmacy({super.key});

  @override
  State<Pharmacy> createState() => _PharmacyState();
}

class _PharmacyState extends State<Pharmacy> {
  @override
  Widget build(BuildContext context) {
    // Constants.userRole = "Pharmacy";
    globals.sharedValue = "Pharmacy";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pharmacy"),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(
              Icons.logout,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const ChatHome(),
            ),
          );
        },
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    Constants.userRole = "";
    const CircularProgressIndicator();
    await FirebaseAuth.instance.signOut().then(
          (value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          ),
        );
  }
}
