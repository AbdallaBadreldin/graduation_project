import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../chat_homelayout/chathomelayout.dart';
import 'login_screen.dart';
import 'package:chatapp_master/shared/constants.dart';

class Patient extends StatefulWidget {
  const Patient({super.key});

  @override
  State<Patient> createState() => _PatientState();
}

class _PatientState extends State<Patient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Patient"),
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
    await FirebaseAuth.instance
        .signOut()
        .then((value) => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            ));
  }
}
