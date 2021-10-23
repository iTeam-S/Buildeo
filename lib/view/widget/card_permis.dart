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
        height: Get.height * .27,
        width: 50,
        margin: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(bottom: 0, top: 25, left: 15, right: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 9.0,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {},
                        child:
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                              color: Color(0xff229af0),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text("Payé", style: TextStyle(color: Colors.white),),
                          ),
                        ) 
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
                      fontSize: 20,
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
