import 'package:flutter/material.dart';

import 'clock.dart';


class AllAlarms extends StatelessWidget {
  const AllAlarms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Alarms Page",
          ),
        ),
        body: Column(
          children: <Widget>[
            Card(
              elevation: 5,
              child: SizedBox(
                height: 70,
                width: double.infinity,
                child: InkWell(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: const Text(
                      "Alarm 1",
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => const Clock()));
                  },
                ),
              ),
            ),
            Card(
              elevation: 5,
              child: Container(
                width: double.infinity,
                height: 70,
                margin: const EdgeInsets.all(10),
                child: const Text(
                  "Alarm 2",
                ),
              ),
            ),
            Card(
              elevation: 5,
              child: Container(
                width: double.infinity,
                height: 70,
                margin: const EdgeInsets.all(10),
                child: const Text(
                  "Alarm 3",
                ),
              ),
            ),
            Card(
              elevation: 5,
              child: Container(
                width: double.infinity,
                height: 70,
                margin: const EdgeInsets.all(10),
                child: const Text(
                  "Alarm 4",
                ),
              ),
            ),
          ],
        ));
  }
}
