import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:core';

import '../../models/medicine.dart';
import 'alarms.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AllPrescription extends StatefulWidget {
  List<Medicine> meds = [];

  @override
  AllPrescription(this.meds, {Key? key}) : super(key: key);

  AllPrescription.fromname() : this([]);

  @override
  State<AllPrescription> createState() => _AllPrescriptionState();
}

class _AllPrescriptionState extends State<AllPrescription> {
  List<Medicine> _medications = [];
  late List<bool> _isOnList;
  int v = 10;

  @override
  void initState() {
    super.initState();
    getMedicationsFromFirestore().then((medications) {
      setState(() {
        _medications = medications;
        _isOnList = List.filled(medications[0].timesPerDay! + 10,
            true); // initialize the isOn list with true for all medications
      });
    });
  }

  var isOn = true;
  DateTime now = DateTime.now();

  Widget build(BuildContext context) {
    List<Medicine> medss = _medications;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Precesions Page"),
        ),
        body: Column(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                child: const Text(
                  "",
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 400,
              padding: const EdgeInsets.all(10),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: ListView.builder(
                  itemCount: _medications.length,
                  itemBuilder: (BuildContext context, int index) {
                    final medicine = _medications[index];
                    if (medicine.timesPerDay == null) medicine.timesPerDay = 1;
                    return ListTile(
                        title:
                            Text('${medicine.medicine} (${medicine.strength})'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            for (int i = 0; i < medicine.timesPerDay!; i++)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    DateFormat('HH:mm').format(now.add(Duration(
                                        hours:
                                            (i * (24 / medicine.timesPerDay!))
                                                .toInt()))),
                                    style: TextStyle(fontSize: 16),

                                    // set a fixed width for the text
                                  ),
                                  SizedBox(
                                      width:
                                          8), // add a SizedBox to create space between the Text and Switch widgets
                                  Switch(
                                    value: _isOnList[i * medss.length +
                                        medicine.timesPerDay!],
                                    onChanged: (value) {
                                      setState(() {
                                        _isOnList[i * medss.length +
                                            medicine.timesPerDay!] = value;
                                      });
                                      print(i + medicine.timesPerDay!);
                                    },
                                  ),
                                ],
                              )
                          ],
                        ));
                  }),
            )
          ],
        ));
  }

  Future<List<Medicine>> getMedicationsFromFirestore() async {
    // Get the current user's ID
    String userId = FirebaseAuth.instance.currentUser!.uid;

    // Get a reference to the medications collection for the current user
    CollectionReference medicationsCollection =
        FirebaseFirestore.instance.collection('users/$userId/medications');

    // Get the medications document from Firestore
    DocumentSnapshot medicationsDocument =
        await medicationsCollection.doc('medications').get();

    // Get the medications list from the document
    List<dynamic> medicationsList = medicationsDocument['medications'];

    // Convert the medications list to a List<Medicine>
    List<Medicine> medications = medicationsList
        .map((medication) => Medicine.fromJson(medication))
        .toList();

    return medications;
  }
}
