import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 40),
      children: <TextSpan>[
        TextSpan(
          text: 'QR',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54),
        ),
        TextSpan(
          text: 'Nest',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blue),
        ),
      ],
    ),
  );
}