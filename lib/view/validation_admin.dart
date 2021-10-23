// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:buildeo/responsive.dart';
import 'package:buildeo/view/widget/barde_progression.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<String> filesList = [
  'Photocopie du CIN cértifié',
  'Plan de construction',
  "Autorisation d'alignement",
  'Statut de la société',
  'PV de nomination'
];

class ValidationAdmin extends StatelessWidget {
  const ValidationAdmin({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffeb3446),
        body: Column(
          children: <Widget>[
            Container(
              height: Get.height * 0.25,
              color: Color(0xffeb3446),
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          )),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green.shade400,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () {},
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: Get.height * 0.25,
                          width: Get.width * 0.25,
                          padding: EdgeInsets.all(9.0),
                          child: CircleAvatar(
                              backgroundImage:
                                  ExactAssetImage("assets/images/user.png")),
                        ),
                        SizedBox(width: 13),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Demande de permis n°04",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              MyProgressBar(),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                  boxShadow: [
                    BoxShadow(blurRadius: 13.0, color: Colors.black26),
                  ],
                ),
                padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Column(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Document",
                                style: TextStyle(
                                    fontSize: 21,
                                    color: Color(0xff8891a4),
                                    fontWeight: FontWeight.bold),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text("non validé"),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          SizedBox(
                            height: 151,
                            child: Center(
                              child: Container(
                                width: isMobile(context) ? 251 : 420,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 5.0),
                                padding: EdgeInsets.all(15.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade400,
                                      blurRadius: 9.0,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Image.asset(
                                          "assets/images/folder.png",
                                          height: 51,
                                          width: 51,
                                        ),
                                        Spacer(),
                                        CircleAvatar(
                                          child: Icon(Icons.download),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Text(
                                      "Villa bas",
                                      style: TextStyle(
                                        color: Color(0xff333333),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 21,
                                      ),
                                    ),
                                    Text(
                                      "Envoyer le : 17/07/2021",
                                      style: TextStyle(color: Colors.grey[500]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Fichiers",
                                style: TextStyle(
                                    fontSize: 21,
                                    color: Color(0xff8891a4),
                                    fontWeight: FontWeight.bold),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text("validé"),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 9,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (ctx, id) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 15),
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: filesList[id],
                                              style: TextStyle(
                                                  color: Color(0xff333333),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 21),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.check_box,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
