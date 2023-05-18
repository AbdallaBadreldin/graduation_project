// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

// ignore: camel_case_types
class alarm extends StatelessWidget {
  List value = [];
  @override
  alarm(this.value, {super.key});

  alarm.fromname({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Alarm"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Container(
                child: const Text(
                  "Prescription",
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
              height: 200,
              padding: const EdgeInsets.all(10),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: SingleChildScrollView(
                child: Center(
                  child: Text(
                    value as String,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
