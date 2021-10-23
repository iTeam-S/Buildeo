// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:buildeo/view/widget/barde_progression.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyContainer extends StatelessWidget {
  /*final bool isActive;
  const MyContainer({
    Key key,
    this.isActive,
  }) : super(key: key);*/

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed("/validAmin");
      },
      child: Container(
        height: Get.height * .38,
        width: 50,
        margin: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(25),
              margin: EdgeInsets.only(bottom: 25, top: 25, left: 15, right: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 13.0,
                    offset: Offset(0, 13),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Color(0xffeb3446),
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Icon(
                              Icons.price_check,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Color(0xffeb3446),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Icon(
                            Icons.create_new_folder,
                            color: Colors.white54,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: CircleAvatar(
                              backgroundImage:
                                  ExactAssetImage("assets/images/user.png")),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * .02,
                  ),
                  Text(
                    "Getan Jonathan Bakary",
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * .02,
                  ),
                  MyProgressBar(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
