import 'package:flutter/material.dart';

GestureDetector buildGestureDetector(
    {required BuildContext context,
    required String image,
    required VoidCallback? onPressed,
    required String text,
    required IconData icon}) {
  return GestureDetector(
    // borderRadius: BorderRadius.circular(20),
    onTap: onPressed,
    child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              image,
            ),
            fit: BoxFit.cover,
            opacity: .6,
          ),
          boxShadow: const [BoxShadow(blurRadius: 2)],
          borderRadius: BorderRadius.circular(20),
        ),
        height: 200,
        width: double.infinity,
        margin: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(
            //   icon,
            //   size: 60,
            //   color: Colors.white70,
            // ),
            Text(
              text,
              style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )
          ],
        )),
  );
}
