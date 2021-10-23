// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:buildeo/responsive.dart';
import 'package:buildeo/view/widget/barde_progression.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:buildeo/view/widget/drawer.dart';


List<String> filesList = [
  'Photocopie du CIN cértifié',
  'Plan de construction',
  "Autorisation d'alignement",
  'Statut de la société',
  'PV de nomination'
];

class ValidationAdmin extends StatelessWidget {

  ValidationAdmin({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  AppDrawer drawer = AppDrawer();

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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                        //Get.to(AppDrawer());
                        _key.currentState!.openDrawer();
                        },
                        icon: Icon(
                          Icons.sort,
                          color: Colors.white,
                        )
                      ),
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.home_filled,
                          color: Colors.white,
                        )
                      ),
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
                                  // fontWeight: FontWeight.bold,
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
                  ),
                  Center(
                    child : InkWell(
                      onTap: () {},
                      child:
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          decoration: BoxDecoration(
                            color: Color(0xff2ebc4f),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text("Tout valider", style: TextStyle(color: Colors.white),),
                        ),
                      ) 
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xfff0f7ff),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
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
                                "Dossier",
                                style: TextStyle(
                                    fontSize: 21,
                                    color: Color(0xff8891a4),
                                    fontWeight: FontWeight.bold),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xffeb3446),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text("M'affecter"),
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
                                      color: Colors.grey.shade300,
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
                                          backgroundColor: Color(0xff2ebc4f),
                                          child: Icon(Icons.download, color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Text(
                                      "Villa bas",
                                      style: TextStyle(
                                        color: Color(0xff333333),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
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
                                  primary: Color(0xff45b1ff),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text("Tout cocher"),
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
                                                  color: Colors.blueGrey[700],
                                                  fontFamily: "ProductSans",
                                                  // fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.check_box,
                                  color: Color(0xff45b1ff),
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
