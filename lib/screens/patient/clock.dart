import 'package:flutter/material.dart';

class Clock extends StatelessWidget {
  const Clock({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Options Page"),
      ),
      body: Column(
        children: [
          Card(
            elevation: 5,
            child: SizedBox(
              width: double.infinity,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        "medicine",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.deepPurple,
                        ),
                      ),
                      Text(
                        "7.50 AM",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    iconSize: 40,
                    color: Colors.blue,
                    onPressed: () {},
                    icon: const Icon(Icons.toggle_on_outlined),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Fire",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Delete",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Adjust",
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
