import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HelpFeedbackPage extends StatefulWidget {
  @override
  _HelpFeedbackPageState createState() => _HelpFeedbackPageState();
}

class _HelpFeedbackPageState extends State<HelpFeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  final _feedbackController = TextEditingController();
  double _rating = 0.0;

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Help/Feedback'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'How can we help you?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 16.0),
                RatingBar.builder(
                  initialRating: _rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  'Feedback',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  controller: _feedbackController,
                  decoration: InputDecoration(
                    hintText: 'Enter your feedback here',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your feedback';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final message =
                          'Rating: $_rating stars\n\n${_feedbackController.text}';
                      final ratingRegex =
                          RegExp(r'Rating: (\d+(\.\d+)?) stars');
                      final feedbackRegex = RegExp(r'(\n\n)(.*)');
                      final ratingMatch = ratingRegex.firstMatch(message);
                      final feedbackMatch = feedbackRegex.firstMatch(message);
                      final rating =
                          double.parse(ratingMatch?.group(1) ?? '0.0');
                      final feedbackText = feedbackMatch!.group(2);
                      final user = FirebaseAuth.instance.currentUser;
                      final userEmail = user?.email;

                      // Configure SMTP server details
                      final smtpServer = SmtpServer(
                        'smtp.gmail.com',
                        port: 587,
                        username: "ahmed.aboali9874@gmail.com",
                        password: 'ixfubwbavtalgjzk',
                        ssl: false,
                      );
                      // Create the email message
                      final emailMessage = Message()
                        ..from = Address(userEmail!)
                        ..recipients.add('ahmed.aboali9874@gmail.com')
                        ..subject = 'Feedback from $userEmail'
                        ..html = '''
                        <p><strong>Rating:</strong> $rating stars</p>
                        <p><strong>Feedback:</strong></p>
                        <p>${_feedbackController.text}</p>
                      ''';

                      // Send the email
                      try {
                        await send(emailMessage, smtpServer);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Feedback sent successfully!'),
                        ));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Failed to send feedback. Please try again later.'),
                        ));
                        print('Failed to send feedback: $e');
                      }
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ));
  }
}
