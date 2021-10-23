// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class MyProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Traitement",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Text(
              "52 %",
              style: TextStyle(
                color: Colors.black,
              ),
            )
          ],
        ),
        SizedBox(
          height: 5,
        ),
        LinearProgressIndicator(
          value: 0.52,
          backgroundColor: Colors.black45,
          valueColor: AlwaysStoppedAnimation<Color>(
            Colors.green,
          ),
        ),
      ],
    );
  }
}
