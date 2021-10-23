// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

  Widget myProgressBar({pourcentage=0.01}) {
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
              "${pourcentage*100} %",
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
          value: pourcentage,
          backgroundColor: Colors.black45,
          valueColor: AlwaysStoppedAnimation<Color>(
            Colors.green,
          ),
        ),
      ],
    );
  }
