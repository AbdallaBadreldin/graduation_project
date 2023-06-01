import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? name;
  final VoidCallback? onPressed;

  const CustomButton({Key? key, required this.name, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        padding: const EdgeInsets.all(8.0),
        focusElevation: 8.0,
        minWidth: double.tryParse('300'),
        height: 100,
        onPressed: onPressed,
        color: Colors.greenAccent,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          child: Text(
            name!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ));
  }
}
