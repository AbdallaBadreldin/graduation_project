import 'package:flutter/material.dart';
import 'contactform.dart';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Us"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Contact Us",
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                "If you have any questions or feedback, please feel free to contact us by email or phone.",
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
              SizedBox(height: 40.0),
              Row(
                children: [
                  Icon(Icons.email, color: Colors.black, size: 30.0),
                  SizedBox(width: 10.0),
                  Text(
                    "ahmed.aboali9874@gmail.com",
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Icon(Icons.phone, color: Colors.black, size: 30.0),
                  SizedBox(width: 10.0),
                  Text(
                    "+1 (555) 555-5555",
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 40.0),
              Divider(thickness: 2.0),
              SizedBox(height: 40.0),
              Text(
                "Send us a Message",
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20.0),
              ContactForm(),
            ],
          ),
        ),
      ),
    );
  }
}
