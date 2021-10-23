// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:buildeo/controller/app.dart';
import 'package:buildeo/model/permis.dart';
import 'package:buildeo/translate.dart';
import 'package:buildeo/view/widget/barde_progression.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


final AppController appController = Get.put(AppController());

Widget cardListePermis(Permis perm, List<Permis> permis) {
    bool current = perm == permis[0];
    return Container(
      height: Get.height * .25,
      width: 50,
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 0,
              bottom: 15,
              left: 15,
              right: 15
            ),
            margin: EdgeInsets.only(bottom: 0, top: 18, left: 15, right: 15),
            decoration: BoxDecoration(
              color: Color(0xfff0f7ff),
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
                      onTap: () {
                        if (current){
                          appController.currentPermis = perm;
                          Get.toNamed("/validAmin");
                        }
                      },
                      child:
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                            color: current ? Color(0xff2ebc4f) : Colors.blueGrey[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text("Traiter", style: TextStyle(color: Colors.white),),
                        ),
                      ) 
                    ),
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                            backgroundImage:
                                ExactAssetImage("assets/images/folder.png")),
                      ),
                    ),
                  ],
                ),
                Divider(),
                SizedBox(
                  height: Get.height * .02,
                ),
                Text(
                  "${translate("DEMANDE_DE_CONSTRUCTION", appController.lang)} ${perm.buildType}",
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: Get.height * .02,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

Widget myContainer() {
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
                color: Color(0xfff0f7ff),
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
                  myProgressBar(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
