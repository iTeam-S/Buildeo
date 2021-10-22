import 'package:flutter/material.dart';

class MyProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Validation :",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                "52 %",
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          LinearProgressIndicator(
            value: 0.46,
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
