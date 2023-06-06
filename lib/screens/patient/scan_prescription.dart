// ignore_for_file: prefer_const_constructors, sort_child_properties_last, import_of_legacy_library_into_null_safe, implementation_imports, unused_import, unnecessary_import, unnecessary_new, duplicate_ignore, camel_case_types, unnecessary_null_comparison
import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chatapp_master/screens/patient/precesions-1.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../drug_names.dart';
import '../../globals.dart';
import '../../models/medicine.dart';

class prescription extends StatefulWidget {
  const prescription({super.key});

  @override
  State<prescription> createState() => _prescriptionState();
}

// ignore: camel_case_types
class _prescriptionState extends State<prescription> {
  List<Medicine> meds = [];
  String result = '';
  File? image;
  File? image1;
  var imagepicker = new ImagePicker();
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  late OpenAI? openAI;
  @override
  void initState() {
    openAI = OpenAI.instance.build(
        token: API_KEY,
        baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 6)));
    super.initState();
  }

  uploadimage() async {
    var pickedimage = await imagepicker.pickImage(source: ImageSource.camera);
    image = File(pickedimage!.path);

    setState(() {
      if (pickedimage != null) {
        performImageLabeling();
      } else {}
    });
  }

  uploadfromgallary() async {
    var pickedimage = await imagepicker.pickImage(source: ImageSource.gallery);
    image = File(pickedimage!.path);
    print(image?.path);
    setState(() {
      if (pickedimage != null) {
        performImageLabeling();
      } else {}
    });
  }

  performImageLabeling() async {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    result = '';
    meds = [];
    try {
      final inputImage = InputImage.fromFile(image!);

      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);

      setState(() {
        for (TextBlock block in recognizedText.blocks) {
          for (TextLine line in block.lines) {
            for (TextElement element in line.elements) {
              // ignore: prefer_interpolation_to_compose_strings
              result += (element.text + " ");
            }
          }
          result += "\n";
          // print(result);
        }
      });
      print(result);
      String content =
          "I have OCR text from a prescription that I need to translate to a JSON format with specific keys. The OCR text may contains information about different medications, including their names, strength, frequency of dosage, duration of treatment, and any notes that may be relevant. Please provide the translated text in the following List of JSON format with the specified keys: 'medicine', 'strength', 'timesPerDay'<int>, 'durationOfTreatment'<int>, and 'note'.put null value if not found.\nHere is the OCR text: $result \n Thank you!";

      print(content);
      await requestRapidApi(content);
    } catch (e) {
      Future.delayed(Duration(milliseconds: 10), () {
        showErrorDialog(context, e);
      });
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // ignore: prefer_const_constructors
        decoration: BoxDecoration(
            image: const DecorationImage(
          image: AssetImage('assets/images/back.jpg'),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: [
            SizedBox(
              width: 100,
            ),
            Container(
              height: MediaQuery.of(context).size.height * .4,
              width: MediaQuery.of(context).size.width * .72,
              margin: EdgeInsets.only(top: 70),
              padding: EdgeInsets.only(left: 28, bottom: 5, right: 18),
              child: ListView.builder(
                  itemCount: meds.length,
                  itemBuilder: (BuildContext context, int index) {
                    final medicine = meds[index];
                    return ListTile(
                      title:
                          Text('${medicine.medicine} (${medicine.strength})'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Times per day: ${medicine.timesPerDay}'),
                          Text(
                              'Duration of treatment: ${medicine.durationOfTreatment} days'),
                          Text('instruction: ${medicine.note}'),
                        ],
                      ),
                    );
                  }),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/note.jpg'),
                      fit: BoxFit.fill)),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 20, right: 140),
                child: Stack(
                  children: [
                    Stack(
                      children: [
                        Center(
                          child: Image.asset(
                            'assets/images/pin.png',
                            height: 240,
                            width: 240,
                          ),
                        )
                      ],
                    ),
                    Center(
                      child: TextButton(
                          onPressed: uploadimage,
                          onLongPress: uploadfromgallary,
                          child: Container(
                              margin: EdgeInsets.only(top: 25),
                              child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    Colors.black87,
                                    BlendMode.hue,
                                  ),
                                  child: image != null
                                      ? Image.file(
                                          image!,
                                          width: 140,
                                          height: 192,
                                          fit: BoxFit.fill,
                                        )
                                      // ignore: sized_box_for_whitespace
                                      : Container(
                                          width: 240,
                                          height: 200,
                                          child: Icon(
                                            Icons.camera,
                                            size: 100,
                                            color: Colors.grey,
                                          ),
                                        )))),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await saveMedicationsToFirestore();
                // Show a success message or navigate to a new screen
              },
              child: Text('Save Medications'),
            ),
            ElevatedButton.icon(
                onPressed: (() => Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AllPrescription(meds);
                    }))),
                icon: Icon(Icons.alarm),
                label: Text("Alarm"))
          ],
        ),
      ),
    );
  }

  Future<void> requestRapidApi(String content) async {
    try {
      final dio = Dio();
      final headers = {
        'Content-Type': 'application/json',
        'X-Rapidapi-Key': '918aafa1a8msh1dfaa73cfe0adf0p101ac5jsnfaa45819bed4',
        'X-Rapidapi-Host': 'openai80.p.rapidapi.com',
      };
      final body = {
        "model": "gpt-3.5-turbo",
        "messages": [
          {"role": "user", "content": content}
        ]
      };

      final response = await dio.post(
        'https://openai80.p.rapidapi.com/chat/completions',
        data: jsonEncode(body),
        options: Options(headers: headers),
      );
      final decodedData = response.data;
      final String data = decodedData['choices'][0]['message']['content'];
      print(data);
      if (data.contains('[')) {
        List<dynamic> decodeContent = json.decode(
            "[${data.substring(data.indexOf('[') + 1, data.indexOf(']'))}]");
        for (var medicine in decodeContent) {
          meds.add(Medicine.fromJson(medicine));
        }
        print(meds[0].medicine);
        print(meds[1].medicine);
        for (int i = 0; i < meds.length; i++) {
          meds[i].medicine = await correctDrugName(meds[i].medicine);
          print(meds[i].medicine);
        }
        setState(() {
          meds = meds;
        });
      } else {
        requestRapidApi(content);
      }
    } catch (e) {
      Future.delayed(Duration(milliseconds: 10), () {
        showErrorDialog(context, e);
      });
    }
  }

  Future<String?> correctDrugName(String? drugName) async {
    try {
      if (drugName == null) return drugName;
      Response response = await Dio()
          .get("https://www.googleapis.com/customsearch/v1", queryParameters: {
        "key": "AIzaSyBYFi1hvmGIRkzuAfThLfR6Vpia790xRZM",
        "cx": "e290357a2666147e2",
        "q": drugName.toString(),
        "gl": "eg"
      });
      print(response.data);
      if (response.data.containsKey("spelling")) {
        String suggestedQuery = response.data["spelling"]["correctedQuery"];
        print(suggestedQuery);
        // Check if the suggested correction is different from the original query.
        if (suggestedQuery != drugName) {
          return suggestedQuery;
        }
      } else {
        return drugName; // No results found.
      }
    } catch (e) {
      Future.delayed(Duration(milliseconds: 10), () {
        showErrorDialog(context, e);
      });
      return drugName; // Return the original name if an error occurs.
    }
    return null;
  }

  Future<void> requestOpenAI(String content) async {
    String data = '';
    print("start");

    final request = ChatCompleteText(messages: [
      Map.of({"role": "user", "content": content})
    ], maxToken: 200, model: ChatModel.gptTurbo0301);
    try {
      openAI?.onChatCompletionSSE(request: request).listen((event) async {
        data += event.choices[0].message!.content;
        if (event.choices[0].finishReason == 'stop') {
          print(data);
          List<dynamic> decodeContent = json.decode(
              "[${data.substring(data.indexOf('[') + 1, data.indexOf(']'))}]");
          for (var medicine in decodeContent) {
            meds.add(Medicine.fromJson(medicine));
          }
          print(meds[0].medicine);
          print(meds[1].medicine);
          for (int i = 0; i < meds.length; i++) {
            meds[i].medicine = await correctDrugName(meds[i].medicine);

            print(meds[i].medicine);
          }
          setState(() {
            meds = meds;
          });

          Navigator.pop(context);
        }
      });
    } catch (e) {
      print(e);
      showErrorDialog(context, e);
    }
  }

  Future<void> saveMedicationsToFirestore() async {
    // Get the current user's ID
    String userId = FirebaseAuth.instance.currentUser!.uid;

    // Get a reference to the medications collection for the current user
    CollectionReference medicationsCollection =
        FirebaseFirestore.instance.collection('users/$userId/medications');

    // Create a Map for the medications list
    Map<String, dynamic> medicationsData = {
      'medications': meds
          .map((med) => {
                'medicine': med.medicine,
                'strength': med.strength,
                'timesPerDay': med.timesPerDay,
                'note': med.note,
                'durationOfTreatment': med.durationOfTreatment,
                'addedTime': DateTime.now()
                    .toIso8601String(), // add the current time as a string
              })
          .toList(),
      'savedTime': DateTime.now()
          .toIso8601String(), // add the current time as a string for the saved time
    };

    // Save the medications data to Firestore
    await medicationsCollection.doc('medications').set(medicationsData);
  }
}

void showErrorDialog(BuildContext context, dynamic error) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(
        error.toString(),
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          color: Colors.black87,
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blueAccent,
          ),
          child: Text(
            'Okay',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      insetPadding: EdgeInsets.all(10.0),
    ),
  );
}
