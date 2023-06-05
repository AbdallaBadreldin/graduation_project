import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
      ),
      body: Stack(
        children: [
          // Add your background image or color here
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1534834730574-6db4d7bff6f3',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "About Us",
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: size.height / 20),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      "We are a team of five passionate developers who embarked on this project as part of our graduation requirements. Our goal is to create innovative solutions that improve healthcare and make it more accessible to everyone. Our app allows patients to scan their handwritten prescriptions and extract the medicine name, dosage, and frequency. Patients can then set alarms to remind them to take their medicine at the right time. We understand the importance of communication in healthcare, which is why our app also includes a chat feature that allows patients to communicate with their pharmacy and ask questions about their medication. We strive to provide a seamless and user-friendly experience for our users, and we are committed to continuously improving our app to meet their needs.",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  SizedBox(height: size.height / 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
