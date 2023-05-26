import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:core';

import '../../models/medicine.dart';
import 'alarms.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  @override
  void initState() {
    super.initState();
    getMedicationsFromFirestore().then((medications) {
      setState(() {
        _medications = medications;
      });
    });
  }

  var isOn = true;

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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0; i < medicine.timesPerDay!; i++)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Take ${i + 1} time',
                                ),
                                Switch(
                                  value: isOn,
                                  onChanged: (value) {
                                    setState(() {
                                      isOn = value;
                                    });
                                    print("hh");
                                  },
                                ),
                              ],
                            )
                        ],
                      ),
                    );
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
