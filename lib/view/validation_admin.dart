// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:buildeo/controller/api.dart';
import 'package:buildeo/controller/api.dart';
import 'package:buildeo/controller/app.dart';
import 'package:buildeo/responsive.dart';
import 'package:buildeo/view/widget/barde_progression.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:buildeo/view/widget/drawer.dart';
import 'package:url_launcher/url_launcher.dart';

List<String> filesList = [
  'Photocopie du CIN cértifié',
  'Plan de construction',
  "Autorisation d'alignement",
  'Lettre de demande',
  'PV de nomination'
];
List<bool> checkboxList = [false, false, false, false, false];

class ValidationAdmin extends StatefulWidget {
  const ValidationAdmin({Key? key}) : super(key: key);

  @override
  _ValidationAdmin createState() => _ValidationAdmin();
}

class _ValidationAdmin extends State<ValidationAdmin>  {

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  AppDrawer drawer = AppDrawer();
  final AppController appController = Get.put(AppController());

  _launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

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
                          )),
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
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
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  ExactAssetImage("assets/images/logo_b.png")),
                        ),
                        SizedBox(width: 13),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Demande de permis n°${appController.currentPermis!.id}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              myProgressBar(pourcentage: checkboxList.where((c) => c == true).toList().length / checkboxList.length),
                            ],
                          ),
                        )
                      ],
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
                                  primary:  checkboxList.where((c) => c == true).toList().length != checkboxList.length ? Color(0xffeb3446) : Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(  checkboxList.where((c) => c == true).toList().length != checkboxList.length ? 
                                  "Réfuser": "Valider"),
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
                                          child: IconButton(icon: Icon(Icons.download),
                                          onPressed: (){
                                            _launchURL("${baseUrlprotocol}/download/attachement/${appController.currentPermis!.attachements}?token=${appController.user!.token}");
                                          },
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Text(
                                        appController.currentPermis!.buildType,
                                      style: TextStyle(
                                        color: Color(0xff333333),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      "Envoyer le : ${appController.currentPermis!.reqDate}",
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
                                onPressed: () {
                                  setState(() {
                                    if (checkboxList.where((c) => c == true).toList().isEmpty) {
                                      for (int i=0; i<checkboxList.length;i++){
                                          checkboxList[i] = true;
                                      }
                                    }
                                    else {
                                      for (int i=0; i<checkboxList.length;i++){
                                          checkboxList[i] = false;
                                      }
                                    }
                                  });
                                },
                                child: Text( checkboxList.where((c) => c == true).toList().isEmpty ? "Tout cocher" : "Tout Décocher"),
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
                               Checkbox(
                                  checkColor: Colors.white,
                                  value: checkboxList[id],
                                  onChanged: (bool? value) {
                                    setState(() {
                                      checkboxList[id] = value!;
                                    });               
                                  })
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
